import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/stream/ctr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/common/utils/utils.dart';
import 'package:house_of_genuises/data/models/course_info_model.dart';
import 'package:house_of_genuises/data/models/courses_model.dart';
import 'package:house_of_genuises/data/models/download_model.dart';
import 'package:house_of_genuises/data/models/video_link_response.dart';
import 'package:house_of_genuises/data/models/video_model.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/data/providers/databaseProvider/video_database.dart';
import 'package:house_of_genuises/data/repositories/category_repo.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/pick_quality_dialog.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/pick_quality_from_url.dart';
import 'package:house_of_genuises/presentation/my_courses/controllers/my_courses_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CourseDetailsController extends GetxController {
  @override
  void onInit() {
    _courseModel = Get.arguments;
    getCourseInfo(_courseModel!.id).then((value) {
      getDownloadedVideos();
    });
    super.onInit();
  }

  bool isVideoDownloaded(String videoName) {
    bool isdownloaded = false;
    downloadedVideos.forEach((element) {
      print(element.videoName);
      print(videoName);
      if (element.videoName == videoName) {
        isdownloaded = true;
      }
    });
    return isdownloaded;
  }

  RxInt currentTabIndex = 0.obs;

  void updateCurrentTabIndex(int index) {
    currentTabIndex.value = index;
  }

  RxList<Video> downloadedVideos = <Video>[].obs;
  getDownloadedVideos() async {
    downloadedVideos.clear();
    downloadedVideos.value = await VideoDatabase.getVideosByCourseName(
            courseInfoModel!.course!.name ?? "none") ??
        [];
    if (downloadedVideos.isEmpty) {
      print(courseInfoModel!.course!.name);
    } else {
      print(downloadedVideos);
    }

    update();
  }

  VideoLinksResponse? watchResponse;
  watchResponseFromUrl(context,
      {required String link,
      required int id,
      String? description,
      required String name}) async {
    var response = await _categoryRepository.watchVideo(link);
    if (response.success) {
      watchResponse = VideoLinksResponse.fromJson(response.data);
      CustomDialog(context,
          child: PickQualityFromUrl(
            response: watchResponse!,
            id: id,
            description: description,
            name: name,
          ));
    }
  }

  TextEditingController activationController = TextEditingController();
  var courseDetailFormKey = GlobalKey<FormState>();

  CourseModel? _courseModel;
  CourseInfoResponse? courseInfoModel;

  var getCourseInfoStatus = RequestStatus.begin.obs;
  var signInCourseStatus = RequestStatus.begin.obs;

  final CategoryRepository _categoryRepository = CategoryRepository();

  updateGetCourseInfo(RequestStatus status) =>
      getCourseInfoStatus.value = status;

  updateSignInCourseStatus(RequestStatus status) =>
      signInCourseStatus.value = status;

  Future<void> signInCourse(int id, String activationCode) async {
    updateSignInCourseStatus(RequestStatus.loading);
    var response = await _categoryRepository.signInCourse(id, activationCode);
    if (response.success) {
      print(response.data);

      updateSignInCourseStatus(RequestStatus.success);
      Get.back();
      // CustomDialog(Get.context, child: const CodeSuccessWidget());
      getCourseInfo(id);
      Get.isRegistered<MyCoursesController>()
          ? Get.find<MyCoursesController>()
              .getMyCourses(CacheProvider.getUserId())
          : Get.put(MyCoursesController())
              .getMyCourses(CacheProvider.getUserId());
    } else {
      print(response.errorMessage);
      Get.back();
      Get.snackbar("حدث خطأ", response.errorMessage!);
      updateSignInCourseStatus(RequestStatus.onError);
    }
  }

  Future<void> getCourseInfo(int id) async {
    updateGetCourseInfo(RequestStatus.loading);
    var response = await _categoryRepository.getCourseInfo(id);
    print(" lks im alsese : ${response.errorMessage}");
    if (response.success) {
      print(response.data);
      courseInfoModel = CourseInfoResponse.fromJson(response.data);
      Utils.logPrint(response.data);
      if (courseInfoModel == null || courseInfoModel!.course == null) {
        updateGetCourseInfo(RequestStatus.noData);
      } else {
        updateGetCourseInfo(RequestStatus.success);
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateGetCourseInfo(RequestStatus.noInternentt);
      } else {
        updateGetCourseInfo(RequestStatus.onError);
      }
    }
  }

  RxInt currentWidgetIndex = 0.obs;
  changeCurrentWidgetIndx(int val) {
    currentWidgetIndex.value = val;
  }

  void launchTelegramURL(String? url) async {
    if (url != null) {
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  DownloadResponse? downloadResponse;
  var downloadStatus = RequestStatus.begin.obs;
  updateDownloadStatus(RequestStatus status) => downloadStatus.value = status;

  Future<void> downloadVideo(String link, context, String courseName,
      String videoName, int videoId, String? description) async {
    updateDownloadStatus(RequestStatus.loading);
    var response = await _categoryRepository.downloadVideo(link);
    if (response.success) {
      downloadResponse = DownloadResponse.fromJson(response.data['link']);

      print("course video :$videoName");
      CustomDialog(context,
          child: PickQualityDialog(
              response: downloadResponse!,
              videoName: videoName,
              courseName: courseName,
              videoId: videoId,
              description: description));

      updateDownloadStatus(RequestStatus.success);
    } else {
      updateDownloadStatus(RequestStatus.onError);
    }
  }

  RxList<int> currentDownloadedVidId = <int>[].obs;

  updateCurrentId(int id) {
    currentDownloadedVidId.add(id);
  }

  final _secureStorage = const FlutterSecureStorage();

  deleteVideo(String courseName, String courseVid) async {
    await VideoDatabase.deleteVideo(courseName, courseVid).then((value) {
      getDownloadedVideos();
    });
  }

  Future<void> isWatched(int lesson_id) async {
    var response = await _categoryRepository.isWatched(lesson_id);
    print(response.success);
  }

  // Define encryptFile at the top level
  static FutureOr<void> encryptFile(String filePathAndKey) async {
    final parts = filePathAndKey
        .split('|'); // Assuming filePath and key are separated by '|'
    final filePath = parts[0];
    final key = parts[1];

    final file = File(filePath);
    final plainText = await file.readAsBytes();
    final keyBytes = Uint8List.fromList(key.codeUnits);
    final iv = Uint8List(16);
    final cipher = CTRStreamCipher(AESFastEngine())
      ..init(
        true,
        ParametersWithIV(
          KeyParameter(keyBytes),
          iv,
        ),
      );

    final encryptedBytes = cipher.process(plainText);
    await file.writeAsBytes(encryptedBytes);
  }

  Future<void> saveAndDownload({
    required String url,
    required String courseName,
    required String courseVidName,
    required int videoId,
    required String? description,
  }) async {
    updateDownloadStatus(RequestStatus.loading);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Uint8List uint8list = response.bodyBytes;
      var buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);

      var dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/$courseVidName.mp4';
      await File(filePath).writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      // Encrypt the file
      await compute(encryptFile, '$filePath|u8x/A?D(G+KbPeShVmYq3t6w9z/C&F)J');

      // Assuming _secureStorage and VideoDatabase are accessible here
      final key = 'video_$courseName-$courseVidName';
      await _secureStorage.write(key: key, value: filePath);
      await VideoDatabase.insertVideo(
        courseName: courseName,
        videoName: courseVidName,
        key: key,
        videoId: videoId,
        description: description,
      );

      updateDownloadStatus(RequestStatus.success);
      getDownloadedVideos();
      Get.snackbar(
          "تم الأمر بنجاح", "نود بإعلامك أن هذا الفيديو أصبح من المحفوظات");
      print("success downloading video");
    } else {
      updateDownloadStatus(RequestStatus.onError);
      throw Exception('Failed to download video');
    }
  }
}

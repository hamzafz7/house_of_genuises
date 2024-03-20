import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:house_of_genuises/data/providers/download_provide.dart';
import 'package:permission_handler/permission_handler.dart';
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
import 'package:al_downloader/al_downloader.dart';
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

  // Future<void> encryptFile(File file, String key) async {
  //   final plainText = await file.readAsBytes();
  //   final keyBytes = Uint8List.fromList(key.codeUnits);
  //   final iv = Uint8List(16);
  //   final cipher = CTRStreamCipher(AESFastEngine())
  //     ..init(
  //       true,
  //       ParametersWithIV(
  //         KeyParameter(keyBytes),
  //         iv,
  //       ),
  //     );

  //   final encryptedBytes = cipher.process(plainText);
  //   await file.writeAsBytes(encryptedBytes);
  // }

  // // 2
  // Future<void> saveAndDownload({
  //   required String url,
  //   required String courseName,
  //   required String courseVidName,
  //   required int videoId,
  //   required String? description,
  // }) async {
  //   updateDownloadStatus(RequestStatus.loading);
  //   var request = http.Request('GET', Uri.parse(url));
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     var bytes = <int>[];
  //     response.stream.listen((newBytes) {
  //       print(newBytes);
  //       bytes.addAll(newBytes);
  //     }, onDone: () async {
  //       final key = 'video_$courseName-$courseVidName';
  //       final directory = await getApplicationDocumentsDirectory();
  //       final filePath = '${directory.path}/$courseVidName.mp4';
  //       final file = File(filePath);
  //       await file.writeAsBytes(bytes);
  //       await encryptFile(file, 'u8x/A?D(G+KbPeShVmYq3t6w9z/C&F)J');
  //       await _secureStorage.write(key: key, value: filePath);
  //       print("course video :$courseVidName");
  //       VideoDatabase.insertVideo(
  //               courseName: courseName,
  //               videoName: courseVidName,
  //               key: key,
  //               videoId: videoId,
  //               description: description)
  //           .then((value) {
  //         updateDownloadStatus(RequestStatus.success);
  //         getDownloadedVideos();
  //         Get.snackbar("تم الأمر بنجاح",
  //             "نود بإعلامك أن هذا الفيديو أصبح من المحفوظات ");
  //         print("success downloading video");
  //       });
  //     });
  //   } else {
  //     updateDownloadStatus(RequestStatus.onError);
  //   }
  // }

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

  // Future<void> saveAndDownload({
  //   required String url,
  //   required String courseName,
  //   required String courseVidName,
  //   required int videoId,
  //   required String? description,
  // }) async {
  //   updateDownloadStatus(RequestStatus.loading);
  //   var request = http.Request('GET', Uri.parse(url));
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     var bytes = <int>[];
  //     response.stream.listen((newBytes) {
  //       print(newBytes);
  //       bytes.addAll(newBytes);
  //     }, onDone: () async {
  //       final key = 'video_$courseName-$courseVidName';
  //       final directory = await getApplicationDocumentsDirectory();
  //       final filePath = '${directory.path}/$courseVidName.mp4';
  //       final file = File(filePath);
  //       await file.writeAsBytes(bytes);

  //       // Use compute to run encryptFile in a separate isolate
  //       await compute(
  //           encryptFile, '$filePath|u8x/A?D(G+KbPeShVmYq3t6w9z/C&F)J');

  //       await _secureStorage.write(key: key, value: filePath);
  //       print("course video :$courseVidName");
  //       VideoDatabase.insertVideo(
  //               courseName: courseName,
  //               videoName: courseVidName,
  //               key: key,
  //               videoId: videoId,
  //               description: description)
  //           .then((value) {
  //         updateDownloadStatus(RequestStatus.success);
  //         getDownloadedVideos();
  //         Get.snackbar("تم الأمر بنجاح",
  //             "نود بإعلامك أن هذا الفيديو أصبح من المحفوظات ");
  //         print("success downloading video");
  //       });
  //     });
  //   } else {
  //     updateDownloadStatus(RequestStatus.onError);
  //   }
  // }

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
      File file = await File(filePath).writeAsBytes(
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

  // Future<void> saveAndDownload({
  //   required String url,
  //   required String courseName,
  //   required String courseVidName,
  //   required int videoId,
  //   required String? description,
  // }) async {
  //   updateDownloadStatus(RequestStatus.loading);

  //   try {
  //     final dio = Dio();
  //     final response = await dio.get(
  //       url,
  //       options: Options(responseType: ResponseType.stream),
  //     );
  //     if (response.statusCode == 200) {
  //       final directory = await getApplicationDocumentsDirectory();
  //       final filePath = '${directory.path}/$courseVidName.mp4';
  //       final file = File(filePath);

  //       final completer = Completer<void>();
  //       response.data.stream.listen(
  //         (data) {
  //           file.writeAsBytes(data, mode: FileMode.append, flush: true);
  //         },
  //         onDone: () {
  //           completer.complete();
  //         },
  //         onError: (error) {
  //           completer.completeError(error);
  //         },
  //       );

  //       await completer.future;

  //       // Use compute to run encryptFile in a separate isolate
  //       await compute(
  //           encryptFile, '$filePath|u8x/A?D(G+KbPeShVmYq3t6w9z/C&F)J');

  //       final key = 'video_$courseName-$courseVidName';
  //       await _secureStorage.write(key: key, value: filePath);

  //       await VideoDatabase.insertVideo(
  //         courseName: courseName,
  //         videoName: courseVidName,
  //         key: key,
  //         videoId: videoId,
  //         description: description,
  //       );

  //       updateDownloadStatus(RequestStatus.success);
  //       getDownloadedVideos();

  //       Get.snackbar(
  //         "تم الأمر بنجاح",
  //         "نود بإعلامك أن هذا الفيديو أصبح من المحفوظات",
  //       );

  //       print("success downloading video");
  //     } else {
  //       updateDownloadStatus(RequestStatus.onError);
  //     }
  //   } catch (error) {
  //     print(error);
  //     updateDownloadStatus(RequestStatus.onError);
  //   }
  // }

  // Future<void> saveAndDownload({
  //   required String url,
  //   required String courseName,
  //   required String courseVidName,
  //   required int videoId,
  //   required String? description,
  // }) async {
  //   updateDownloadStatus(RequestStatus.loading);

  //   // Define the directory path where you want to save the downloaded files
  //   final directory = await getApplicationDocumentsDirectory();
  //   final savedDir = '${directory.path}'; // Adjust the path as needed

  //   // Check if the directory exists and create it if it doesn't
  //   final savedDirPath = Directory(savedDir);
  //   bool hasExisted = await savedDirPath.exists();
  //   if (!hasExisted) {
  //     await savedDirPath.create(recursive: true); // Create the directory
  //   }

  //   final taskId = await FlutterDownloader.enqueue(
  //     url: url,
  //     savedDir: savedDir, // Use the directory path here
  //     showNotification: true,
  //     openFileFromNotification: false,
  //   );

  //   FlutterDownloader.registerCallback((id, status, progress) async {
  //     if (id == taskId) {
  //       if (status == DownloadTaskStatus.complete) {
  //         final key = 'video_$courseName-$courseVidName';
  //         final filePath = '$savedDir/$courseVidName.mp4';

  //         // Use compute to run encryptFile in a separate isolate
  //         await compute(
  //             encryptFile, '$filePath|u8x/A?D(G+KbPeShVmYq3t6w9z/C&F)J');

  //         await _secureStorage.write(key: key, value: filePath);
  //         print("course video :$courseVidName");
  //         VideoDatabase.insertVideo(
  //                 courseName: courseName,
  //                 videoName: courseVidName,
  //                 key: key,
  //                 videoId: videoId,
  //                 description: description)
  //             .then((value) {
  //           updateDownloadStatus(RequestStatus.success);
  //           getDownloadedVideos();
  //           Get.snackbar("تم الأمر بنجاح",
  //               "نود بإعلامك أن هذا الفيديو أصبح من المحفوظات ");
  //           print("success downloading video");
  //         });
  //       } else if (status == DownloadTaskStatus.failed) {
  //         updateDownloadStatus(RequestStatus.onError);
  //       }
  //     }
  //   });
  // }

//

  void downloadCallback(String id, int status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/common/utils/utils.dart';
import 'package:house_of_genuises/data/models/course_info_model.dart';
import 'package:house_of_genuises/data/models/courses_model.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/data/repositories/category_repo.dart';
import 'package:house_of_genuises/presentation/my_courses/controllers/my_courses_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsController extends GetxController {
  @override
  void onInit() {
    _courseModel = Get.arguments;
    getCourseInfo(_courseModel!.id);
    super.onInit();
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
}

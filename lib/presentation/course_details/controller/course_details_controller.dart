import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/data/models/courses_model.dart';
import 'package:house_of_genuises/data/repositories/category_repo.dart';

class CourseDetailsController extends GetxController {
  @override
  void onInit() {
    debugPrint("zzzz");
    _courseModel = Get.arguments;
    getCourseInfo(_courseModel!.id);
    super.onInit();
  }

  CourseModel? _courseModel;

  var getCourseInfoStatus = RequestStatus.begin.obs;

  final CategoryRepository _categoryRepository = CategoryRepository();

  updateGetCourseInfo(RequestStatus status) =>
      getCourseInfoStatus.value = status;

  Future<void> getCourseInfo(int id) async {
    var response = await _categoryRepository.getCourseInfo(id);
    print(response.data);
  }

  RxInt currentWidgetIndex = 0.obs;
  changeCurrentWidgetIndx(int val) {
    print("zzz from change");
    currentWidgetIndex.value = val;
  }
}

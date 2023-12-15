import 'package:get/get.dart';

class CourseDetailsController extends GetxController {
  RxInt currentWidgetIndex = 0.obs;
  changeCurrentWidgetIndx(int val) {
    currentWidgetIndex.value = val;
  }
}

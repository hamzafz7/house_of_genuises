import 'package:get/get.dart';

class QuizController extends GetxController {
  RxDouble initalValue = 0.0.obs;
  RxInt totalQuistions = 70.obs;
  RxInt currentQuistions = 0.obs;

  incrementQuistionsValue() {
    initalValue.value = initalValue.value + 1 / totalQuistions.value;
    currentQuistions.value++;
    print(initalValue.value);
  }
}

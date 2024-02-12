import 'package:get/get.dart';

class QuizController extends GetxController {
  RxDouble initalValue = 0.0.obs;
  RxInt totalQuistions = 3.obs;
  RxInt currentQuistions = 0.obs;

  incrementQuistionsValue() {
    if (currentQuistions.value < totalQuistions.value) {
      initalValue.value = initalValue.value + 1 / totalQuistions.value;
      currentQuistions.value++;
      print(initalValue.value);
    }
  }

  Map<int, int> userSolutions = {};

  provideSolution(int key, int val) {
    userSolutions[key] = val;
  }
}

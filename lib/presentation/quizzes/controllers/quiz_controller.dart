import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  @override
  void onInit() {
    startCountdown();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    timer.value.cancel();
  }

  RxInt _totalTimeInSeconds = 3600.obs;
  RxDouble initalValue = (1 / 3).obs;
  RxInt totalQuistions = 3.obs;
  RxInt currentQuistions = 1.obs;
  Rx<String> get formattedTime =>
      "${(_totalTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(_totalTimeInSeconds % 60).toString().padLeft(2, '0')}"
          .obs;

  late Rx<Timer> timer;

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalTimeInSeconds > 0) {
        _totalTimeInSeconds--;

        // print(formattedTime);
      } else {
        timer.cancel();
      }
      update(); // Notify listeners to rebuild the UI with the updated time
    }).obs;
  }

  Rx<PageController> pageController = PageController().obs;
  Rx<int> currentIndex = 0.obs;

  incrementQuistionsValue() {
    if (currentQuistions.value < totalQuistions.value) {
      initalValue.value = initalValue.value + 1 / totalQuistions.value;
      currentQuistions.value++;
      currentIndex.value++;
    }
  }

  decrementQuistionsValue() {
    if (currentQuistions.value > 1) {
      initalValue.value = initalValue.value - 1 / totalQuistions.value;
      currentQuistions.value--;
      currentIndex.value--;
    }
  }

  Map<int, int> userSolutions = {};

  provideSolution(int key, int val) {
    userSolutions[key] = val;
  }
}

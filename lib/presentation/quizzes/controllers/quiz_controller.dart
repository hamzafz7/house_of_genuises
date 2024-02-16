import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/data/models/quiz_model.dart';

class QuizController extends GetxController {
  late QuizzModel model;
  RxInt _totalTimeInSeconds = 3600.obs;
  RxDouble initalValue = (1 / 3).obs;
  late RxInt totalQuistions;
  RxInt currentQuistions = 1.obs;
  RxDouble finalResults = 0.0.obs;

  @override
  void onInit() {
    model = Get.arguments;
    totalQuistions = model.questions?.length.obs ?? 1.obs;
    startCountdown();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    timer.value.cancel();
  }

  Rx<String> get formattedTime =>
      "${(_totalTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(_totalTimeInSeconds % 60).toString().padLeft(2, '0')}"
          .obs;

  late Rx<Timer> timer;

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalTimeInSeconds > 0) {
        _totalTimeInSeconds--;
      } else {
        timer.cancel();
      }
      update();
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

  calcResult() {
    finalResults.value = 0.0;
    for (var element in model.questions!) {
      int ind = 0;
      for (int i = 0; i < element.choices!.length; i++) {
        if (element.choices![i].isTrue!) {
          ind = element.id!;
          break;
        }
      }
      if (userSolutions.containsKey(element.id) &&
          userSolutions.containsValue(ind)) {
        print("hehe");
        finalResults.value += 1 / totalQuistions.value;
      }
    }
    print(finalResults.value);
  }

  provideSolution(int key, int val) {
    userSolutions[key] = val;
    update();
  }
}

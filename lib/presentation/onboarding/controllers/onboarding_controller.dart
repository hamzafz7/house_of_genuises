import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/data/models/onboarding_model.dart';

class OnBoardingPageController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  final List<OnBoardingModel> onboardingScreens = [
    OnBoardingModel(
        body:
            "لكن يجب أن أشرح لك كيف ولدت كل هذه الفكرة الخاطئة المتمثلة في إدانة السرور ومدح الألم",
        imageSrc: "assets/images/onBoarding1.svg",
        title: "جميع الدورات المطلوبة"),
    OnBoardingModel(
        body:
            "لكن يجب أن أشرح لك كيف ولدت كل هذه الفكرة الخاطئة المتمثلة في إدانة السرور ومدح الألم",
        imageSrc: "assets/images/onBoarding2.svg",
        title: "في جميع الأوقات"),
    OnBoardingModel(
        body:
            "لكن يجب أن أشرح لك كيف ولدت كل هذه الفكرة الخاطئة المتمثلة في إدانة السرور ومدح الألم",
        imageSrc: "assets/images/onBoarding3.svg",
        title: "اختبر مدى فهمك "),
  ];
}

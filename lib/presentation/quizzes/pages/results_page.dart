import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/quiz_info_widget.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/result_button_widget.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/result_grade_Stack.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: Get.width,
              height: 430.h,
              decoration: BoxDecoration(
                  color: kprimaryBlueColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r))),
            ),
            Positioned(
                top: 0,
                right: 30,
                left: 30,
                bottom: 500.h,
                child: const ResultGradeStack()),
            Positioned(
                top: 320.h,
                bottom: 320.h,
                right: 30,
                left: 30,
                child: const QuizInfoWidget()),
            Positioned(
              bottom: 60.h,
              child: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const ResultButtonWidget(
                          color: Colors.red,
                          svgURL: "assets/images/eye.svg",
                          text: "رؤية النتائج",
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        const ResultButtonWidget(
                            color: Colors.red,
                            svgURL: "assets/images/eye.svg",
                            text: "رؤية النتائج")
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const ResultButtonWidget(
                            color: Colors.red,
                            svgURL: "assets/images/eye.svg",
                            text: "رؤية النتائج"),
                        SizedBox(
                          height: 40.h,
                        ),
                        const ResultButtonWidget(
                            color: Colors.red,
                            svgURL: "assets/images/eye.svg",
                            text: "رؤية النتائج")
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/progress_header_widget.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/question_widget.dart';
import 'package:house_of_genuises/presentation/widgets/custom_button.dart';

class QuizzesPage extends GetView<QuizController> {
  const QuizzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QuizController());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "الاختبار الاول",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProgressHeaderWidget(),
            ExpandablePageView.builder(
              onPageChanged: (val) {},
              physics: const NeverScrollableScrollPhysics(),
              animationDuration: const Duration(milliseconds: 0),
              controller: controller.pageController.value,
              itemCount: 3,
              itemBuilder: (context, index) {
                return QuestionPage(
                  index: index,
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Center(
                child: CustomButton(
                  onTap: () {
                    if (controller.currentQuistions.value !=
                        controller.totalQuistions.value) {
                      controller.pageController.value
                          .jumpToPage(controller.currentIndex.value + 1);
                      controller.incrementQuistionsValue();
                    } else {
                      Get.toNamed(AppRoute.showQuizResultRoute);
                    }
                  },
                  width: 354.w,
                  height: 48.h,
                  child: Text(
                    "التالي",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    if (controller.currentQuistions.value > 1) {
                      print("zzzz");
                      controller.pageController.value
                          .jumpToPage(controller.currentIndex.value - 1);
                      controller.decrementQuistionsValue();
                    }
                  },
                  child: Text(
                    "الرجوع",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: kprimaryBlueColor,
                        decoration: TextDecoration.underline,
                        decorationColor: kprimaryBlueColor),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
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

            // PageView.builder(
            //   itemCount: 4,
            //   itemBuilder: (context, index) => QuestionPage(),
            // ),
            ExpandablePageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return QuestionPage();
              },
            ),
            Center(
              child: CustomButton(
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
          ],
        ),
      ),
    );
  }
}

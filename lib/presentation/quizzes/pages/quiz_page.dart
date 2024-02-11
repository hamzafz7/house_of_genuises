import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/progress_header_widget.dart';

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
            TextButton(
                onPressed: () {
                  controller.incrementQuistionsValue();
                },
                child: Text("press"))
          ],
        ),
      ),
    );
  }
}

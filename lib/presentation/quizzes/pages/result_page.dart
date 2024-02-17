import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/data/models/quiz_model.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/quistion_result.dart';

// ignore: must_be_immutable
class ResultPage extends StatelessWidget {
  ResultPage({super.key, this.model});
  var controller = Get.find<QuizController>();
  QuizzModel? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CacheProvider.getAppTheme()
            ? const Color.fromARGB(255, 7, 37, 61)
            : null,
        surfaceTintColor:
            CacheProvider.getAppTheme() ? kDarkBlueColor : Colors.white,
        title: Text(
          "نتائج ${model!.title ?? " "} ",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: controller.model.questions!.length,
          itemBuilder: (context, index) => QuestionResultWidget(
                isTrue:
                    controller.rightSolutions[model!.questions![index].id] ==
                        controller.userSolutions[model!.questions![index].id],
                index: index,
                model: controller.model.questions![index],
              )),
    );
  }
}

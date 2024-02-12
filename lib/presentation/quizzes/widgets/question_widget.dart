import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/answer_widget.dart';
import 'package:house_of_genuises/presentation/quizzes/widgets/question_header_widget.dart';

// ignore: must_be_immutable
class QuestionPage extends StatelessWidget {
  QuestionPage({super.key, required this.index});
  final int index;
  var controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionHeaderWidget(
            index: index,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "أختر الإجابة الصحيحة:",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 20.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(6.r),
          //   child: Checkbox(
          //     value: true,
          //     onChanged: (val) {},
          //     overlayColor: ,
          //   ),
          // )
          ListView.builder(
              controller: ScrollController(
                  initialScrollOffset: 0.0, keepScrollOffset: true),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => AnswerWidget()),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

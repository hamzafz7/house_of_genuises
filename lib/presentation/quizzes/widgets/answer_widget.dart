import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/quizzes/controllers/quiz_controller.dart';

// ignore: must_be_immutable
class AnswerWidget extends StatelessWidget {
  AnswerWidget({super.key});
  var controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.white,
              ),
              child: Checkbox(
                hoverColor: kprimaryBlueColor,
                activeColor: kprimaryBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1.0, color: Colors.blue),
                ),
                value: false,
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              width: 280.w,
              child: Text(
                "يمكن أن يكون لشي قيمة تبادلية دون أن يكون له قيمة استعمالية.",
              ),
            )
          ],
        ),
      ),
    );
  }
}

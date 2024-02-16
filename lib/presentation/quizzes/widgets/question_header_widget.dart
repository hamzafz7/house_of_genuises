import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class QuestionHeaderWidget extends StatelessWidget {
  const QuestionHeaderWidget({super.key, required this.index, this.title});
  final int index;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 360.w,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Color.fromARGB(255, 231, 231, 231))
        ]),
        child: Padding(
          padding: EdgeInsets.all(20.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "السؤال ${index + 1}:",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                title ?? "هذا السؤال بلا نص",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: kprimaryGreyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class QuestionHeaderWidget extends StatelessWidget {
  const QuestionHeaderWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "للشيئ عموماً قيمتان ، قيمة تبادلية وقيمة استعمالية , ولكن  :",
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:svg_flutter/svg_flutter.dart';

class AcquiredLessonsText extends StatelessWidget {
  const AcquiredLessonsText({super.key, required this.lesson});
  final String lesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/images/bulb.svg"),
          SizedBox(
            width: 5.w,
          ),
          Text(
            lesson,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kprimaryGreyColor, fontSize: 14.sp),
          )
        ],
      ),
    );
  }
}

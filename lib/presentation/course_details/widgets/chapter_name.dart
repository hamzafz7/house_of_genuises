import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class ChapterName extends StatelessWidget {
  const ChapterName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "01",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kprimaryGreyColor),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            "البحث الأول :",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            "مدخل إلى علم الإقتصاد",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kprimaryGreyColor),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CourseDetailsHeader extends StatelessWidget {
  const CourseDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 337.h,
      width: Get.width,
      child: Stack(
        children: [
          SizedBox(
            width: Get.width,
            child: Image.asset(
              "assets/images/course_pic.png",
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: Get.width,
            child: Image.asset(
              "assets/images/grey_pic.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          Positioned(
            top: 120.h,
            bottom: 0,
            left: 10.w,
            right: 10.w,
            child: SizedBox(
              width: 300.w,
              child: Text(
                'كورس دراسة الجدوى الاقتصادية',
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 36.sp),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

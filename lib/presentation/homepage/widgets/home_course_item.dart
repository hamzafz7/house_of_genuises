import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/constants.dart';
import 'package:house_of_genuises/presentation/course_details/pages/course_details_page.dart';
import 'package:house_of_genuises/presentation/widgets/custom_button.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeCourseItem extends StatelessWidget {
  const HomeCourseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 187.w,
        height: 360.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: kprimarwhiteColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 12.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                defPic,
                height: 136.h,
                width: 166.w,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/users.svg",
                    height: 15.h,
                    width: 15.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      "حمزة الفواز وجواد تقي الدين",
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 10.sp, color: ksecondaryGreyColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                width: 150.w,
                child: Text(
                  'كورس دراسة الجدوى \nالاقتصادية',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            CustomButton(
              onTap: () {
                Get.to(() => const CourseDetailsPage());
              },
              height: 40.h,
              width: 110.w,
              borderRadius: 6.r,
              child: Text(
                "انضم الأن",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

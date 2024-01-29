import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/acquired_lessons_text.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/chapter_name.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_def_title.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/custom_name_text.dart';

// ignore: must_be_immutable
class CourseDescribtionWidget extends StatelessWidget {
  CourseDescribtionWidget({super.key});
  var controller = Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourseDefineTitle(
          titleName: "مدرسو المادة",
          width: 150.w,
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.courseInfoModel!.course!.teachers!.length,
          itemBuilder: (context, index) => CustomNameText(
              name: controller.courseInfoModel!.course!.teachers![index]),
        ),
        CourseDefineTitle(titleName: "الفصول الرئيسية ", width: 145.w),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.courseInfoModel!.course!.chapters!.length,
          itemBuilder: (context, index) => ChapterName(
              chapterModel:
                  controller.courseInfoModel!.course!.chapters![index]),
        ),
        SizedBox(
          height: 15.h,
        ),
        CourseDefineTitle(titleName: "ماذا سوف نتعلم ؟ ", width: 170.w),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.courseInfoModel!.course!.valuesOfCourse!.length,
          itemBuilder: (context, index) => AcquiredLessonsText(
              lesson:
                  controller.courseInfoModel!.course!.valuesOfCourse![index]),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

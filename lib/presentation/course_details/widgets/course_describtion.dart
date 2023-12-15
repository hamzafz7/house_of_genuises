import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/acquired_lessons_text.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/chapter_name.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_def_title.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/custom_name_text.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/main_requirment_text.dart';

class CourseDescribtionWidget extends StatelessWidget {
  const CourseDescribtionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          child: Text(
              'تعتبر مادة كورس مبادئ الاحصاء من أهم مواد الفصل الأول وهي تتبع لقسم الإحصاء، حيث أنها تحتوي على عدد كبير من القوانين التي يجب حفظها والتفريق بينها بدقة .',
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14.sp, color: kprimaryGreyColor)),
        ),
        SizedBox(
          height: 20.h,
        ),
        CourseDefineTitle(
          titleName: "مدرسو المادة",
          width: 150.w,
        ),
        const CustomNameText(name: "الدكتورة هدى الروماني"),
        SizedBox(
          height: 15.h,
        ),
        CourseDefineTitle(
          titleName: "يتألف الكتاب من الفصول التالية",
          width: 230.w,
        ),
        const ChapterName(),
        SizedBox(
          height: 15.h,
        ),
        CourseDefineTitle(titleName: "ماذا سوف نتعلم ؟ ", width: 170.w),
        const AcquiredLessonsText(
            lesson: "مجموعة الدالات الحسابية والرياضية المستخدمة"),
        SizedBox(
          height: 15.h,
        ),
        CourseDefineTitle(titleName: "المتطلبات الرئيسية", width: 145.w),
        SizedBox(
          height: 15.h,
        ),
        const MainRequirementText(name: "ما هي مستويات الإطار الفهمي")
      ],
    );
  }
}

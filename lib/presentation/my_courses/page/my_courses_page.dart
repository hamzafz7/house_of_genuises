import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/my_courses/widgets/my_course_container.dart';
import 'package:house_of_genuises/presentation/my_courses/widgets/my_courses_page_header.dart';

class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          const MyCoursesPageHeader(),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SearchBar(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFFF1F1F1)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Text('كورساتي',
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: kDarkBlueColor, fontSize: 18.sp)),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const MyCourseCotainer()),
          )
        ],
      ),
    );
  }
}

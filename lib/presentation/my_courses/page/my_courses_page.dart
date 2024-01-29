import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/presentation/my_courses/controllers/my_courses_controller.dart';
import 'package:house_of_genuises/presentation/my_courses/widgets/my_course_container.dart';
import 'package:house_of_genuises/presentation/my_courses/widgets/my_courses_page_header.dart';

class MyCoursesPage extends GetView<MyCoursesController> {
  const MyCoursesPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MyCoursesController());
    return Scaffold(
        body: RefreshIndicator(
      color: kprimaryBlueColor,
      onRefresh: () async {
        controller.getMyCourses(CacheProvider.getUserId());
      },
      child: Column(
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
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Text('كورساتي',
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 18.sp)),
          ),
          Expanded(
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) => const MyCourseCotainer()),
          ),
        ],
      ),
    ));
  }
}

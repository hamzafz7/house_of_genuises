import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/home_course_item.dart';

class YearsCoursesPage extends StatelessWidget {
  const YearsCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "السنة الأولى",
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const Divider(),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                const Text("يتضمن هذا الكورس"),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 101.w,
                  height: 36.h,
                  decoration: ShapeDecoration(
                    color: ksecondaryBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "10",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: kprimaryBlueColor),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Text("كورسات")
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36.h,
          ),
          GridView.count(
            childAspectRatio: 1 / 1.7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(10, (index) => const HomeCourseItem()),
          )
        ]),
      ),
    );
  }
}

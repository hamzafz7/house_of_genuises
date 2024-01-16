import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/homepage/controller/home_controller.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/home_course_item.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CoursesWidget extends StatelessWidget {
  CoursesWidget({super.key});

  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text(
                  controller.categoriesModel!
                      .categories![controller.currentCategoryIndex.value].name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18.sp),
                ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'رؤية المزيد',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              decorationColor: kprimaryBlueColor,
                              color: kprimaryBlueColor,
                              fontSize: 14.sp,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                      SvgPicture.asset(
                        "assets/icons/arrow-right.svg",
                        color: kprimaryBlueColor,
                        height: 15.h,
                      ),
                    ],
                  ))
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
          children: List.generate(10, (index) => HomeCourseItem()),
        )
      ],
    );
  }
}

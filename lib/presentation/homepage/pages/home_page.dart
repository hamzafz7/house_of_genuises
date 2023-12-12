import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/home_course_item.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/home_stack_header.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/year_button.dart';
import 'package:svg_flutter/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: Get.width, child: HomeStackHeader()),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text('التصنيفات الرئيسية',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20.sp, fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 70.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: YearButton(index: index, onPressed: () {}),
                        )),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Text(
                      "السنة الأولى",
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
          ),
        ),
      ),
    );
  }
}

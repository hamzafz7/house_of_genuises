import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/constants.dart';
import 'package:house_of_genuises/data/models/news_model.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/news_item.dart';
import 'package:house_of_genuises/presentation/widgets/custom_button.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeStackHeader extends StatelessWidget {
  const HomeStackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 1.1,
      width: Get.width,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.asset(
            "assets/images/home_forground.png",
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/home_background2.png",
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 14.w),
              child: Image.asset(
                "assets/images/logo.png",
                height: 45.h,
                width: 45.w,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 14.w),
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: const ShapeDecoration(
                    color: Color(0x28F9F9F9),
                    shape: OvalBorder(),
                  ),
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: const Divider(),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'ابحث وستجد ',
                          style: Theme.of(context).textTheme.labelLarge),
                      TextSpan(
                          text: 'أهم\n',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: ksecondaryColor)),
                      TextSpan(
                          text: ' الكورسات والدورات المثالية لك! ',
                          style: Theme.of(context).textTheme.labelLarge),
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Text(
                      'ابحث وستجد أهم الكورسات اعثر على دورة مثالية لكوالدورات المثالية لك اعثر على دورة مثالية لك اعثر على دورة مثالية لك اعثر على دورة مثالية لك ',
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14.sp, color: Colors.white))),
              SizedBox(
                height: 120.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: CustomButton(
                  height: 55.h,
                  width: 200.w,
                  borderRadius: 6.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ابدأ الآن",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        width: 22.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: SvgPicture.asset("assets/icons/arrow-right.svg"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text('أخر الأخبار',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelLarge),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 215.h,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => NewsItem(
                        model: NewsModel(
                            image: defPic,
                            news: "Lorem ipsum dolor sit amet, consectetur."))),
              ),
            ],
          )
        ],
      ),
    );
  }
}

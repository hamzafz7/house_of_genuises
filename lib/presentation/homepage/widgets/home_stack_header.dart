import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/constants.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/presentation/homepage/controller/home_controller.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/news_item.dart';

// ignore: must_be_immutable
class HomeStackHeader extends StatelessWidget {
  HomeStackHeader({super.key});
  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: !CacheProvider.getAppTheme()
                  ? [kprimaryBlueColor, Colors.white]
                  : [
                      const Color.fromARGB(255, 12, 25, 36),
                      const Color.fromARGB(255, 16, 79, 131)
                    ])),
      height: Get.height / 1.5,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 14.w),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  )),
              const Spacer(),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 14.w),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 45.h,
                  width: 45.w,
                ),
              ),
            ],
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
          SizedBox(
            height: 10.h,
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
            child: Obx(() => switch (controller.getNewsStatus.value) {
                  RequestStatus.success => ListView.builder(
                      itemCount: controller.newsResponse!.news.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => NewsItem(
                          model: controller.newsResponse!.news[index])),
                  RequestStatus.begin => Container(),
                  RequestStatus.loading => Center(
                      child: appCircularProgress(),
                    ),
                  RequestStatus.onError => const Center(
                      child: Text("حدث خطأ"),
                    ),
                  RequestStatus.noData => const Center(
                      child: Text("لا يوجد أخبار للعرض"),
                    ),
                  RequestStatus.noInternentt => const Center(
                      child: Text("لا يوجد اتصال بالانترنت"),
                    ),
                }),
          ),
        ],
      ),
    );
  }
}

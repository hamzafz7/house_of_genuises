import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/constants.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/presentation/homepage/controller/home_controller.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/courses.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/home_stack_header.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/year_button.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: Get.width, child: const HomeStackHeader()),
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
                child: Obx(() => switch (controller.categoriesStatus.value) {
                      RequestStatus.success => controller.categoriesModel !=
                                  null &&
                              controller.categoriesModel!.categories!.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .categoriesModel!.categories!.length,
                              itemBuilder: (context, index) {
                                print(
                                  controller
                                      .categoriesModel!.categories!.length,
                                );
                                return Padding(
                                  padding: EdgeInsets.all(8.0.r),
                                  child: YearButton(
                                    index: index,
                                    onPressed: () {
                                      controller.changeCurrentIndex(
                                          index,
                                          controller.categoriesModel!
                                              .categories![index].id!);
                                      print("Zzz");
                                    },
                                    categoryModel: controller
                                        .categoriesModel!.categories![index],
                                  ),
                                );
                              })
                          : Container(),
                      RequestStatus.begin => Container(),
                      RequestStatus.loading => Center(
                          child: appCircularProgress(),
                        ),
                      RequestStatus.onError => const SizedBox(
                          height: 70,
                          child: Text("حدث خطأ"),
                        ),
                      RequestStatus.noData => const SizedBox(
                          height: 70,
                          child: Text("لا يوجد بيانات"),
                        ),
                      RequestStatus.noInternentt => const Center(
                          child: Text("لا يوجد اتصال بالانترنت"),
                        ),
                    }),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(() => switch (controller.courseStatus.value) {
                    RequestStatus.success =>
                      controller.coursesModel!.courses!.isNotEmpty ||
                              controller.coursesModel!.courses != null
                          ? CoursesWidget()
                          : Container(),
                    RequestStatus.begin => Container(),
                    RequestStatus.loading => Center(
                        child: appCircularProgress(),
                      ),
                    RequestStatus.onError => const Center(
                        child: Text("حدث خطأ"),
                      ),
                    RequestStatus.noData => const Center(
                        child: Text("لا يوجد بيانات"),
                      ),
                    RequestStatus.noInternentt => const Center(
                        child: Text("لا يوجد اتصال بالانترنت"),
                      ),
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

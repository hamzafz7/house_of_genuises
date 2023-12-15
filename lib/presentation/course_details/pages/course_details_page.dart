import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_curriculum.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_describtion.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_details_header.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/custom_pick_button.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/custom_shape.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/code_success.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:house_of_genuises/presentation/widgets/custom_button.dart';

class CourseDetailsPage extends GetView<CourseDetailsController> {
  const CourseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CourseDetailsController());
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                  clipper: ContainerCustomClipper(),
                  child: const CourseDetailsHeader()),
              CustomPickButton(),
              SizedBox(
                height: 40.h,
              ),
              Obx(() => controller.currentWidgetIndex.value == 0
                  ? const CourseDescribtionWidget()
                  : const CourseCurriculum()),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: CustomButton(
                  onTap: () {
                    CustomDialog(context, child: const CodeSuccessWidget());
                  },
                  height: 50.h,
                  width: 382.w,
                  borderRadius: 17.r,
                  child: Text(
                    "ٍسجل الآن",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

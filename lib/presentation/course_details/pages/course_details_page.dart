import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/constants.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/common/utils/utils.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_curriculum.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_describtion.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_details_header.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/custom_pick_button.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/custom_shape.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/code_activate_dialog.dart';
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
        child: Obx(
          () => switch (controller.getCourseInfoStatus.value) {
            RequestStatus.success => SingleChildScrollView(
                child: Form(
                  key: controller.courseDetailFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipPath(
                          clipper: ContainerCustomClipper(),
                          child: CourseDetailsHeader(
                            text: controller.courseInfoModel!.course!.name,
                            image: controller.courseInfoModel!.course!.image,
                          )),
                      CustomPickButton(),
                      SizedBox(
                        height: 40.h,
                      ),
                      Obx(() => controller.currentWidgetIndex.value == 0
                          ? CourseDescribtionWidget()
                          : CourseCurriculum()),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: CustomButton(
                          onTap: () {
                            if (controller.courseInfoModel!.course != null) {
                              if (!controller.courseInfoModel!.course!.isOpen! &&
                                  !controller
                                      .courseInfoModel!.course!.isPaid! &&
                                  controller.courseInfoModel!.course!
                                          .isTeachWithCourse !=
                                      true) {
                                CustomDialog(context,
                                    child: CodeActivationWidget(
                                      controller:
                                          controller.activationController,
                                      onValidate: (val) {
                                        return Utils.isFeildValidated(val);
                                      },
                                      onTap: () {
                                        if (controller
                                            .courseDetailFormKey.currentState!
                                            .validate()) {
                                          controller.signInCourse(
                                              controller
                                                  .courseInfoModel!.course!.id!,
                                              controller
                                                  .activationController.text);
                                        }
                                      },
                                    ),
                                    height: 380);
                              } else {
                                controller.changeCurrentWidgetIndx(1);
                              }
                            }
                          },
                          height: 50.h,
                          width: 382.w,
                          borderRadius: 17.r,
                          child: Text(
                            controller.courseInfoModel!.course!.isPaid ==
                                        true ||
                                    controller
                                            .courseInfoModel!.course!.isOpen ==
                                        true ||
                                    controller.courseInfoModel!.course!
                                            .isTeachWithCourse ==
                                        true
                                ? "تابع المشاهدة"
                                : "ٍسجل الآن",
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
            RequestStatus.begin => Container(),
            RequestStatus.loading => Center(
                child: appCircularProgress(),
              ),
            RequestStatus.onError => const Center(
                child: Text("حدث خطأ"),
              ),
            RequestStatus.noData => const Center(
                child: Text("لا يوجد بيانات "),
              ),
            RequestStatus.noInternentt => Container(),
          },
        ),
      ),
    );
  }
}

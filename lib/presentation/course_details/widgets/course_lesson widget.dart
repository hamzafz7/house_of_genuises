import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/data/models/lession_model.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_pdf.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/complete_failure.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CourseLessonWidget extends StatelessWidget {
  CourseLessonWidget({super.key, required this.lessionModel});
  final LessionModel lessionModel;
  final controller = Get.find<CourseDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (lessionModel.isOpen! ||
                controller.courseInfoModel!.course!.isPaid! ||
                controller.courseInfoModel!.course!.isOpen! ||
                controller.courseInfoModel!.course!.isTeachWithCourse == true ||
                CacheProvider.getUserType() == 'admin') {
              if (lessionModel.type == 'video') {
                controller.watchResponseFromUrl(context,
                    link: lessionModel.link!,
                    id: lessionModel.id,
                    description: lessionModel.description);
              } else {
                Get.to(FileViewWidget(imagePath: lessionModel.link!));
                // print(lessionModel.link);
              }
            } else {
              CustomDialog(context, child: const CompleteFailureWidget());
            }
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.r),
                child: lessionModel.type == 'video'
                    ? lessionModel.isWatched == false
                        ? SvgPicture.asset(
                            'assets/icons/play-circle.svg',
                          )
                        : Container(
                            height: 26.h,
                            width: 26.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: Icon(
                              Icons.check,
                              color: const Color.fromARGB(255, 207, 197, 197),
                            ),
                          )
                    : const Icon(
                        Icons.file_copy,
                        color: kprimaryBlueColor,
                      ),
              ),
              SizedBox(
                  width: 210.w,
                  child: Text(
                    lessionModel.title ?? " ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
        ),
        Spacer(),
        if (lessionModel.type == 'video' &&
            !controller.isVideoDownloaded(lessionModel.title ?? "nonr"))
          Obx(
            () => controller.downloadStatus.value == RequestStatus.loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 140, 186, 224)
                              .withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Center(
                        child: Text(
                          "جاري التحميل ..",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: kprimaryBlueColor, fontSize: 10.sp),
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      if (lessionModel.isOpen! ||
                          controller.courseInfoModel!.course!.isPaid! ||
                          controller.courseInfoModel!.course!.isOpen! ||
                          controller
                                  .courseInfoModel!.course!.isTeachWithCourse ==
                              true ||
                          CacheProvider.getUserType() == 'admin') {
                        controller.downloadVideo(
                            lessionModel.link!,
                            context,
                            controller.courseInfoModel!.course!.name!,
                            lessionModel.title!);
                      }
                    },
                    icon: Icon(
                      Icons.download,
                      color: kprimaryBlueColor,
                    )),
          )
      ],
    );
  }
}

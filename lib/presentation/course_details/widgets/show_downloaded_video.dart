import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/presentation/course_details/controller/downloaded_course_controller.dart';

class ShowDownloadedVideo extends GetView<downloadedVideoController> {
  const ShowDownloadedVideo({super.key, this.description});
  final String? description;

  @override
  Widget build(BuildContext context) {
    Get.put(downloadedVideoController());
    return Scaffold(
        body: Obx(
      () => controller.watchVideoStatus.value == RequestStatus.success
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                    aspectRatio: 1 / 0.7,
                    child: FlickVideoPlayer(
                        flickManager: FlickManager(
                            videoPlayerController:
                                controller.videoPlayerController!))),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Text("الوصف الخاص في هذا الدرس:",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: kprimaryGreyColor)),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Text(description ?? 'لا يوجد وصف لهذا الفيديو'),
                ),
              ],
            )
          : controller.watchVideoStatus.value == RequestStatus.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(child: Text("حدث خطأ ما أثناء تحميل الفيديو")),
    ));
  }
}

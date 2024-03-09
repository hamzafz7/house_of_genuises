import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/presentation/course_details/controller/show_lesson_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/flick_video_speed_widget.dart';

// class ShowCourseVideo extends StatefulWidget {
//   const ShowCourseVideo({super.key, this.video});
//   final String? video;

//   @override
//   State<ShowCourseVideo> createState() => _ShowCourseVideoState();
// }

// class _ShowCourseVideoState extends State<ShowCourseVideo> {
//   late WebViewController webViewController;

//   @override
//   void initState() {
//     webViewController = WebViewController()
//       ..loadRequest(Uri.parse(widget.video!), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': " Bearer ${CacheProvider.getAppToken()}",
//       })
//       ..setJavaScriptMode(JavaScriptMode.unrestricted);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // webViewController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebViewWidget(controller: webViewController);
//   }
// }
class ShowCourseVideo extends GetView<ShowLessonController> {
  const ShowCourseVideo({super.key, this.description});
  final String? description;

  @override
  Widget build(BuildContext context) {
    Get.put(ShowLessonController());
    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => controller.watchVideoStatus.value == RequestStatus.success
            ? Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                alignment: Alignment.topRight,
                children: [
                  AspectRatio(
                    aspectRatio: 1 / 0.6,
                    child: Stack(
                      children: [
                        FlickVideoPlayer(
                          flickManager: FlickManager(
                              videoPlayerController:
                                  controller.videoPlayerController!),
                          flickVideoWithControls: const FlickVideoWithControls(
                            controls: FlickPortraitControls(),
                          ),
                          flickVideoWithControlsFullscreen:
                              FlickVideoWithControls(
                            videoFit: BoxFit.fitWidth,
                            controls: Container(
                              child: Stack(
                                children: [
                                  FlickVideoSpeedControlWidget(
                                      flickManager: FlickManager(
                                          videoPlayerController: controller
                                              .videoPlayerController!)),
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: const FlickLandscapeControls(),
                                  ),
                                ],
                              ),
                            ),
                            playerLoadingFallback:
                                Center(child: CircularProgressIndicator()),
                            iconThemeData:
                                IconThemeData(size: 30, color: Colors.white),
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: FlickVideoSpeedControlWidget(
                                flickManager: FlickManager(
                                    videoPlayerController:
                                        controller.videoPlayerController!))),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 270.h,
                      ),
                      if (description != null && description!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0.r),
                              child: Text("الوصف الخاص في هذا الدرس:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: kprimaryGreyColor)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0.w, vertical: 8.h),
                              child: Text(description!),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              )
            : controller.watchVideoStatus.value == RequestStatus.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(child: Text("حدث خطأ ما أثناء تحميل الفيديو")),
      )),
    );
  }
}

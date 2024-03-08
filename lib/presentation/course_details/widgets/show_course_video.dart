import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/presentation/course_details/controller/show_lesson_controller.dart';

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
    return Scaffold(
        body: Obx(
      () => controller.watchVideoStatus.value == RequestStatus.success
          ? Stack(
              // crossAxisAlignment: CrossAxisAlignment.start,
              alignment: Alignment.topRight,
              children: [
                AspectRatio(
                    aspectRatio: 1 / 0.7,
                    child: FlickVideoPlayer(
                        flickManager: FlickManager(
                            videoPlayerController:
                                controller.videoPlayerController!))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0.r),
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

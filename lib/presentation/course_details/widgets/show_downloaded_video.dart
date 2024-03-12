import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/presentation/course_details/controller/downloaded_course_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/flick_video_speed_widget.dart';

class ShowDownloadedVideo extends GetView<downloadedVideoController> {
  const ShowDownloadedVideo({super.key, this.description});
  final String? description;

  @override
  Widget build(BuildContext context) {
    Get.put(downloadedVideoController());
    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => controller.watchVideoStatus.value == RequestStatus.success
            ? Column(
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
                ],
              )
            : controller.watchVideoStatus.value == RequestStatus.loading
                ? Center(
                    child:
                        Center(child: Text("جاري تحميل الفيديو الخاص بك ..")),
                  )
                : Center(child: Text("حدث خطأ ما أثناء تحميل الفيديو")),
      )),
    );
  }
}

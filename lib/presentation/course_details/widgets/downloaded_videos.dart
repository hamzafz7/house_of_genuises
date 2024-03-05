import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/downloaded_video_widget.dart';

class DownloadedVideosWidget extends StatelessWidget {
  DownloadedVideosWidget({super.key});
  final controller = Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseDetailsController>(builder: (_) {
      if (controller.downloadedVideos.isNotEmpty) {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.downloadedVideos.length,
            itemBuilder: (context, index) => DownloadedVideoWidget(
                video: controller.downloadedVideos[index]));
      } else {
        return Container();
      }
    });
  }
}

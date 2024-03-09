import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/data/models/video_link_response.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/show_course_video.dart';
import 'package:house_of_genuises/presentation/widgets/quality_button.dart';

class PickQualityFromUrl extends StatelessWidget {
  PickQualityFromUrl(
      {super.key, required this.response, this.description, required this.id});
  final VideoLinksResponse response;
  final String? description;
  final int id;
  final controller = Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Text(
            "اختر الدقة المناسبة:",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kDarkBlueColor),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: response.link.length,
              itemBuilder: (item, index) => QualityButton(
                  onPressed: () {
                    Get.back();

                    Get.to(
                        () => ShowCourseVideo(
                              description: description,
                            ),
                        arguments: response.link[index].link);
                    controller.isWatched(id);
                  },
                  quality: response.link[index].rendition)),
        ),
      ]),
    );
  }
}

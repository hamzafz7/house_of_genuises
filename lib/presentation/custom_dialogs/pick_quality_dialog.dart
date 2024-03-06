import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/data/models/download_model.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';
import 'package:house_of_genuises/presentation/widgets/quality_button.dart';

class PickQualityDialog extends StatelessWidget {
  PickQualityDialog(
      {super.key,
      required this.response,
      required this.videoName,
      required this.courseName});
  final DownloadResponse response;
  final String videoName;
  final String courseName;
  final controller = Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Text("اختر الدقة المناسبة:"),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: response.downloadOptions.length,
              itemBuilder: (item, index) => QualityButton(
                  onPressed: () {
                    controller.saveAndDownload(
                        response.downloadOptions[index].link!,
                        courseName,
                        videoName);
                    Get.back();
                  },
                  quality: response.downloadOptions[index].quality!)),
        ),
      ]),
    );
  }
}

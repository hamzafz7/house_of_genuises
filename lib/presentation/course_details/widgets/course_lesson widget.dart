import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/data/models/lession_model.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/course_pdf.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/show_course_video.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CourseLessonWidget extends StatelessWidget {
  const CourseLessonWidget({super.key, required this.lessionModel});
  final LessionModel lessionModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (lessionModel.type == 'video') {
              Get.to(() => ShowCourseVideo(video: lessionModel.link));
            } else {
              Get.to(FileViewWidget(imagePath: lessionModel.link));
              // print(lessionModel.link);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: lessionModel.type == 'video'
                ? SvgPicture.asset('assets/icons/play-circle.svg')
                : const Icon(
                    Icons.file_copy,
                    color: kprimaryBlueColor,
                  ),
          ),
        ),
        SizedBox(
            width: 250.w,
            child: Text(
              lessionModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }
}

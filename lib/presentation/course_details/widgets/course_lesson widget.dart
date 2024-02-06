import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/data/models/lession_model.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CourseLessonWidget extends StatelessWidget {
  const CourseLessonWidget({super.key, required this.lessionModel});
  final LessionModel lessionModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.r),
          child: lessionModel.type == 'video'
              ? SvgPicture.asset('assets/icons/play-circle.svg')
              : const Icon(
                  Icons.file_copy,
                  color: kprimaryBlueColor,
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

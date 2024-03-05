import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/data/models/video_model.dart';
import 'package:svg_flutter/svg.dart';

class DownloadedVideoWidget extends StatelessWidget {
  const DownloadedVideoWidget({super.key, required this.video});
  final Video video;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        width: Get.width,
        child: Row(children: [
          SvgPicture.asset('assets/icons/play-circle.svg'),
          Spacer(),
          SizedBox(
            width: 240.w,
            child: Text(
              video.videoName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ]),
      ),
    );
  }
}

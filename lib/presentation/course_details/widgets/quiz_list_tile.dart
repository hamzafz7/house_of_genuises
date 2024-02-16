import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';

import 'package:house_of_genuises/data/models/quiz_model.dart';
import 'package:house_of_genuises/presentation/course_details/controller/course_details_controller.dart';

class QuizListTile extends StatelessWidget {
  QuizListTile({super.key, required this.quizzModel});
  final QuizzModel quizzModel;
  final controller = Get.find<CourseDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
              width: 250.w,
              child: Text(
                quizzModel.title ?? " ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          GestureDetector(
            onTap: () {
              print(quizzModel.description);
              Get.toNamed(AppRoute.quizzPageRoute, arguments: quizzModel);
            },
            child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Text(
                  "بدء",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red),
                )),
          ),
        ],
      ),
    );
  }
}

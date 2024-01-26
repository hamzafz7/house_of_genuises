import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/common/constants/constants.dart';
import 'package:house_of_genuises/data/models/news_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 211.w,
          height: 234.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: kprimarwhiteColor),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Column(children: [
            CachedNetworkImage(
              imageUrl: model.image ?? defPic,
              height: 157.h,
              width: 211.w,
              fit: BoxFit.cover,
            ),
            SizedBox(
                width: 211.w,
                child: Text(
                  model.news ?? "لا يوجد",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall,
                ))
          ]),
        ),
      ),
    );
  }
}

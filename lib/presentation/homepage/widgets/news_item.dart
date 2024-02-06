import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/constants.dart';
import 'package:house_of_genuises/common/constants/shimmer_effect.dart';
import 'package:house_of_genuises/data/models/news_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: SizedBox(
          height: 250.h,
          child: Card(
            elevation: 3,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey,
            borderOnForeground: false,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: model.image ?? defPic,
                  height: 140.h,
                  width: 350.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return ShimmerPlaceholder(
                        child: Container(
                      height: 140.h,
                      color: Colors.black,
                    ));
                  },
                ),
              ),
              SizedBox(
                  width: 211.w,
                  child: Text(
                    model.news ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class MyProfileImage extends StatelessWidget {
  const MyProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kprimaryBlueColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(58.r),
          child: CachedNetworkImage(
            imageUrl:
                "https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1702746365~exp=1702746965~hmac=d69d2e417b17c8e24a04eabd7a5d0ca923eb3a5806a83f576d1f19f0da10318f",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

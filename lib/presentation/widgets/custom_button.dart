import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.height = 55, this.width = 252, this.onTap, this.child});

  final double? height;
  final double? width;
  final Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width!.w,
        height: height!.h,
        padding: EdgeInsets.symmetric(vertical: 13.h),
        decoration: ShapeDecoration(
            color: kprimaryBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            )),
        child: Center(child: child),
      ),
    );
  }
}

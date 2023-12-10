import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:svg_flutter/svg_flutter.dart';

class RegisterationFormFeild extends StatelessWidget {
  const RegisterationFormFeild(
      {super.key,
      required this.svgSrc,
      this.validator,
      this.hintText,
      required this.controller});

  final String svgSrc;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.w,
      decoration: ShapeDecoration(
        color: klightGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(33.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 8.w),
        child: TextFormField(
          controller: controller,
          validator: validator,
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: kprimaryGreyColor),
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: SvgPicture.asset(
                  svgSrc,
                ),
              )),
        ),
      ),
    );
  }
}

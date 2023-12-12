import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class YearButton extends StatelessWidget {
  const YearButton({super.key, required this.index, required this.onPressed});
  final int index;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 146.w,
        height: 70.h,
        decoration: ShapeDecoration(
          color: kprimaryBlueColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: kprimaryBlueColor),
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        child: Center(
          child: Text(
            index == 0
                ? "السنة الآولى"
                : index == 1
                    ? "السنة الثانية"
                    : index == 2
                        ? "السنة الثالثة"
                        : "السنة الرابعة",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

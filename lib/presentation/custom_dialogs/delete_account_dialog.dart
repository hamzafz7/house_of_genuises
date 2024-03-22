// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/widgets/custom_button.dart';

class DeleteProfileDialog extends StatelessWidget {
  const DeleteProfileDialog({super.key, required this.onPressed});
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text('حذف الحساب',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ksecondaryColor)),
        SizedBox(
          height: 30.h,
        ),
        Text('هل أنت متأكد من رغبتك في حذف حسابك؟',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: kDarkBlueColor)),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onTap: () {
                  Get.back();
                },
                borderRadius: 8.r,
                bottomColor: kthirdGreyColor,
                width: 140.w,
                height: 45.h,
                child: Text(
                  "الرجوع",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ksecondaryGreyColor),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              CustomButton(
                onTap: onPressed,
                borderRadius: 8.r,
                bottomColor: kprimaryBlueColor,
                width: 140.w,
                height: 45.h,
                child: Text(
                  "نعم",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

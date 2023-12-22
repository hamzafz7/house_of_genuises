import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/userinfo/widgets/profile_image_edit.dart';
import 'package:house_of_genuises/presentation/widgets/custom_appbar.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: "الملف الشخصي",
      ),
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 20.h,
            ),
            const ProfileImageEdit(),
            Text('طارق القاسم', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                children: [
                  Text('المعلومات الشخصية',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: kDarkBlueColor)),
                  const Spacer(),
                  Text('تعديل',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          color: kprimaryBlueColor,
                          decoration: TextDecoration.underline,
                          decorationColor: kprimaryBlueColor))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

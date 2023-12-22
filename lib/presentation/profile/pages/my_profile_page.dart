import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:house_of_genuises/presentation/custom_dialogs/log-out.dart';
import 'package:house_of_genuises/presentation/profile/controllers/profile_controller.dart';
import 'package:house_of_genuises/presentation/profile/widgets/my_profile_header.dart';
import 'package:house_of_genuises/presentation/profile/widgets/my_profile_image.dart';
import 'package:house_of_genuises/presentation/profile/widgets/profile_list_item.dart';

class MyProfilePage extends GetView<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyProfileController());
    return Scaffold(
      body: Column(
        children: [
          const MyProfileHeader(),
          SizedBox(
            height: 25.h,
          ),
          const MyProfileImage(),
          SizedBox(
            height: 10.h,
          ),
          Text('طارق القاسم', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(
            height: 45.h,
          ),
          ProfileListItem(
              svgUrl: "assets/icons/person.svg",
              onTap: () {
                Get.toNamed(AppRoute.userInfoPageRoute);
              },
              text: "الملف الشخصي"),
          SizedBox(
            height: 30.h,
          ),
          ProfileListItem(
              svgUrl: "assets/icons/settings.svg",
              onTap: () {},
              text: "الإعدادات"),
          SizedBox(
            height: 30.h,
          ),
          ProfileListItem(
              svgUrl: "assets/icons/log-out.svg",
              onTap: () {
                CustomDialog(context,
                    child: LogOutDialog(onPressed: () {}),
                    height: 250,
                    width: 390);
              },
              text: "تسجيل الخروج"),
          SizedBox(
            height: 30.h,
          ),
          ProfileListItem(
              svgUrl: "assets/icons/x.svg", onTap: () {}, text: "حذف الحساب")
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustomAppBar({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        title: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: kDarkBlueColor),
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            Get.back();
          },
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}

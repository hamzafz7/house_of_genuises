import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/profile/widgets/my_profile_image.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileImageEdit extends StatelessWidget {
  const ProfileImageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SizedBox(height: 130.h, child: const MyProfileImage()),
          IconButton(
              onPressed: () {},
              icon: Container(
                width: 31.w,
                height: 31.h,
                decoration: const ShapeDecoration(
                  color: kprimaryBlueColor,
                  shape: OvalBorder(),
                ),
                child: SvgPicture.asset("assets/icons/edit.svg"),
              ))
        ],
      ),
    );
  }
}

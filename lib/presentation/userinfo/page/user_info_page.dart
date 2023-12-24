import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/profile/controllers/profile_controller.dart';
import 'package:house_of_genuises/presentation/userinfo/widgets/profile_image_edit.dart';
import 'package:house_of_genuises/presentation/userinfo/widgets/profile_text_feild.dart';
import 'package:house_of_genuises/presentation/widgets/custom_appbar.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key});
  final controller = Get.find<MyProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        text: "الملف الشخصي",
        onPressed: () {
          controller.isEdited.value = false;
          Get.back();
        },
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
                  TextButton(
                    onPressed: () {
                      controller.changeIsEdit();
                    },
                    child: Text('تعديل',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14.sp,
                            color: kprimaryBlueColor,
                            decoration: TextDecoration.underline,
                            decorationColor: kprimaryBlueColor)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Obx(
              () => ProfileTextFeild(
                  isEdited: controller.isEdited.value,
                  titleText: "الاسم الكامل",
                  controller: controller.nameController,
                  onValidate: (val) {
                    return null;
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => ProfileTextFeild(
                  isEdited: controller.isEdited.value,
                  titleText: "رقم الهاتف",
                  controller: controller.phoneController,
                  onValidate: (val) {
                    return null;
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => ProfileTextFeild(
                  isEdited: controller.isEdited.value,
                  titleText: "العنوان",
                  controller: controller.addressController,
                  onValidate: (val) {
                    return null;
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

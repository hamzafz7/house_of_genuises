import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

CustomDialog(context, {Widget? child}) {
  return Get.defaultDialog(
      // contentPadding: EdgeInsets.all(16.r),
      title: "",
      titlePadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: SizedBox(height: 350.h, width: 374.w, child: child));
}

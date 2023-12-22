import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

CustomDialog(context,
    {Widget? child, double height = 350, double width = 374}) {
  return Get.defaultDialog(
      contentPadding: EdgeInsets.zero,
      title: "",
      titlePadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: SizedBox(height: height.h, width: width.w, child: child));
}

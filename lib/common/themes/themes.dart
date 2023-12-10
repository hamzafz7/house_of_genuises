import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var lighttheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 48.sp,
            fontFamily: 'Hacen Tunisia',
            fontWeight: FontWeight.w400),
        titleMedium: TextStyle(
            fontSize: 30.sp,
            fontFamily: 'Hacen Tunisia',
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Hacen Tunisia',
            fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(
            fontSize: 24.sp,
            fontFamily: 'Hacen Tunisia',
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Hacen Tunisia',
            fontWeight: FontWeight.w500)));

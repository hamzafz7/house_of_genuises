import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/common/themes/themes.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/presentation/mainpage/pages/main_page.dart';

void main() {
  runApp(const MyApp());
  CacheProvider.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: lighttheme,
              locale: const Locale('ar'),
              getPages: AppRoute.pages,
              home: const MainPage(),
            ));
  }
}

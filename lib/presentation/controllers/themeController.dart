import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';

class ThemeController extends GetxController {
  ThemeMode currentTheme =
      CacheProvider.getAppTheme() ? ThemeMode.dark : ThemeMode.light;

  // function to switch between themes
  void switchTheme() {
    currentTheme =
        currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    CacheProvider.setAppTheme(!CacheProvider.getAppTheme());
    update();
  }
}

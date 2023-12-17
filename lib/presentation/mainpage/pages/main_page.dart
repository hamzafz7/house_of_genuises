import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/colors.dart';
import 'package:house_of_genuises/presentation/mainpage/controller/main_page_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainPageController());
    return Obx(
      () => Scaffold(
        extendBody: true,
        // body: controller.screens[controller.currentPageIndex.value],
        body: PersistentTabView(
          context,
          screens: controller.screens,
          items: [
            PersistentBottomNavBarItem(
                // onPressed: (context) {
                //   controller.changeCurrentPage(0);
                // },
                icon: const Icon(Icons.home),
                title: "حسابي",
                activeColorPrimary: kprimaryBlueColor,
                inactiveColorPrimary: Colors.grey,
                inactiveColorSecondary: Colors.grey),
            PersistentBottomNavBarItem(
              // onSelectedTabPressWhenNoScreensPushed: () {
              //   controller.changeCurrentPage(1);
              // },
              // onPressed: (context) {
              //   controller.changeCurrentPage(1);
              // },
              icon: const Icon(Icons.search),
              title: "الرئيسية",
              activeColorPrimary: kprimaryBlueColor,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              // onPressed: (context) {
              //   controller.changeCurrentPage(2);
              // },
              icon: const Icon(Icons.message),
              title: "كورساتي",
              activeColorPrimary: kprimaryBlueColor,
              inactiveColorPrimary: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() => [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.purple),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: "Search",
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        title: "Messages",
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
      ),
    ];

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/search/controller/search_controller.dart';
import 'package:house_of_genuises/presentation/search/widgets/custom_seach_feild.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchPageController());
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            CustomSearchFeild(searchController: controller.searchController)
          ],
        ),
      ),
    );
  }
}

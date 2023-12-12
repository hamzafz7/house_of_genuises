import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/homepage/widgets/home_stack_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [SizedBox(width: Get.width, child: HomeStackHeader())],
          ),
        ),
      ),
    );
  }
}

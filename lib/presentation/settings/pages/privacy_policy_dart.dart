import 'package:flutter/material.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class PricyPolicy extends StatelessWidget {
  const PricyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "سياسة الخصوصية",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: kprimaryBlueColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Text("")],
        ),
      ),
    );
  }
}

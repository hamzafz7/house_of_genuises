import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:house_of_genuises/common/constants/colors.dart';

class CustomSearchFeild extends StatelessWidget {
  const CustomSearchFeild({super.key, required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(50),
          ),
      child: TextFormField(
        controller: searchController,
        onChanged: (value) {},
        cursorColor: kprimaryBlueColor,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '  ابحث عن ما تريد ما تريد من كوررسات',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: const Icon(
              Icons.search,
              color: kprimaryGreyColor,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

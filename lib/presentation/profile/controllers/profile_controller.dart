import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  RxBool isEdited = false.obs;
  changeIsEdit() {
    isEdited.value = !isEdited.value;
  }

  final TextEditingController nameController =
      TextEditingController(text: "طارق القسام");
  final TextEditingController phoneController =
      TextEditingController(text: "0964342112");
  final TextEditingController addressController =
      TextEditingController(text: "القزاز");
}

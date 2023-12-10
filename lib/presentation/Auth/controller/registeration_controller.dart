import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();

  var loginPageFormKey = GlobalKey<FormState>();
  var registerPageFormKey = GlobalKey<FormState>();

  RxBool isloginpasswordShown = false.obs;

  changeIsLoginPasswordShown() {
    isloginpasswordShown.value = !isloginpasswordShown.value;
  }
}

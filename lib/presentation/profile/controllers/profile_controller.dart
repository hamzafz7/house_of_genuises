import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/data/models/profile_model.dart';
import 'package:house_of_genuises/data/repositories/account_repo.dart';

class MyProfileController extends GetxController {
  @override
  void onInit() {
    getMyProfile();
    super.onInit();
  }

  RxBool isEdited = false.obs;
  changeIsEdit() {
    isEdited.value = !isEdited.value;
  }

  TextEditingController nameController = TextEditingController(text: "لا يوجد");
  TextEditingController phoneController =
      TextEditingController(text: "لا يوجد");
  TextEditingController addressController =
      TextEditingController(text: "لا يوجد");

  final getProfileStatus = RequestStatus.begin.obs;
  final logOutStatus = RequestStatus.begin.obs;
  updateGetProfileStatus(RequestStatus status) =>
      getProfileStatus.value = status;
  updateLogOutStatus(RequestStatus status) => logOutStatus.value = status;

  final AccountRepo _repo = AccountRepo();
  ProfileResponse? prfoileResponse;
  Future<void> getMyProfile() async {
    updateGetProfileStatus(RequestStatus.loading);
    var response = await _repo.getMyProfile();
    if (response.success) {
      print(response.data);
      prfoileResponse = ProfileResponse.fromJson(response.data);
      phoneController =
          TextEditingController(text: prfoileResponse!.data.phone ?? "لا يوجد");
      nameController = TextEditingController(
          text: prfoileResponse!.data.fullName ?? "لا يوجد");
      addressController = TextEditingController(
          text: prfoileResponse!.data.location ?? "لا يوجد");
      updateGetProfileStatus(RequestStatus.success);
    } else if (!response.success) {
      updateLogOutStatus(RequestStatus.onError);
      Get.snackbar("حدث خطأ", response.errorMessage!);
    }
  }

  Future<void> logOut() async {
    updateLogOutStatus(RequestStatus.loading);
    var response = await _repo.signOut();
    if (response.success) {
      updateLogOutStatus(RequestStatus.success);
      Get.offAllNamed(AppRoute.loginPageRoute);
    } else if (!response.success) {
      updateGetProfileStatus(RequestStatus.onError);
      Get.snackbar("حدث خطأ", response.errorMessage!);
    }
  }
}

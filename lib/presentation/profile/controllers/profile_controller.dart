import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/common/utils/utils.dart';
import 'package:house_of_genuises/data/models/profile_model.dart';
import 'package:house_of_genuises/data/models/user_model.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/data/repositories/account_repo.dart';
import 'package:image_picker/image_picker.dart';

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
  final updateProfileStatus = RequestStatus.begin.obs;
  updateGetProfileStatus(RequestStatus status) =>
      getProfileStatus.value = status;
  updateLogOutStatus(RequestStatus status) => logOutStatus.value = status;
  updateEditProfileStatus(RequestStatus status) =>
      updateProfileStatus.value = status;

  RxString imagePicked = "".obs;
  getImagePicked() async {
    imagePicked.value = await Utils.imagePicker(ImageSource.gallery) ?? "";
  }

  final AccountRepo _repo = AccountRepo();
  ProfileResponse? prfoileResponse;
  Future<void> getMyProfile() async {
    updateGetProfileStatus(RequestStatus.loading);
    var response = await _repo.getMyProfile();
    if (response.success) {
      prfoileResponse = ProfileResponse.fromJson(response.data);
      CacheProvider.setUserImage(prfoileResponse!.data.image);
      phoneController =
          TextEditingController(text: prfoileResponse!.data.phone ?? "لا يوجد");
      nameController = TextEditingController(
          text: prfoileResponse!.data.fullName ?? "لا يوجد");
      addressController = TextEditingController(
          text: prfoileResponse!.data.location ?? "لا يوجد");
      updateGetProfileStatus(RequestStatus.success);
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateGetProfileStatus(RequestStatus.noInternentt);
      } else {
        updateGetProfileStatus(RequestStatus.onError);
      }
      Get.snackbar("حدث خطأ", response.errorMessage!);
    }
  }

  Future<void> updateProfile() async {
    print("heelllo");
    updateEditProfileStatus(RequestStatus.loading);
    User user = User(
        id: CacheProvider.getUserId(),
        fullName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        image: imagePicked.value);
    print(user.updateUserToJSon());
    var response = await _repo.updateProfile(user);
    if (response.success) {
      updateEditProfileStatus(RequestStatus.success);
      prfoileResponse = ProfileResponse.fromJson(response.data);
      CacheProvider.setUserName(prfoileResponse!.data.fullName!);

      phoneController =
          TextEditingController(text: prfoileResponse!.data.phone ?? "لا يوجد");
      nameController = TextEditingController(
          text: prfoileResponse!.data.fullName ?? "لا يوجد");
      addressController = TextEditingController(
          text: prfoileResponse!.data.location ?? "لا يوجد");
      Get.back();
      getMyProfile();
    } else {
      Get.snackbar(
          "حدث خطأ", response.errorMessage ?? "حدث خطأ في الاتصال مع الانترنت");
    }
  }

  Future<void> logOut() async {
    updateLogOutStatus(RequestStatus.loading);
    var response = await _repo.signOut();
    if (response.success) {
      updateLogOutStatus(RequestStatus.success);
      CacheProvider.clearAppToken();
      Get.offAllNamed(AppRoute.loginPageRoute);
    } else if (!response.success) {
      updateLogOutStatus(RequestStatus.onError);
      Get.snackbar("حدث خطأ", response.errorMessage!);
    }
  }
}

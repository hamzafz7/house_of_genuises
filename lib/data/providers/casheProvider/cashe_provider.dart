import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';

class CacheProvider {
  static late GetStorage _getStorage;

  CacheProvider() {
    _getStorage = GetStorage();
  }
  static init() {
    _getStorage = GetStorage();
  }

  static getIsOnBoardingOpened() {
    return _getStorage.read("onboarding");
  }

  setIsOnBoardingOpened(bool value) {
    return _getStorage.write("onboarding", value);
  }

  static getAppToken() {
    return _getStorage.read("token");
  }

  static setUserName(String? name) {
    _getStorage.write("name", name);
  }

  static setUserId(int? id) {
    _getStorage.write("id", id);
  }

  static getUserId() {
    return _getStorage.read("id");
  }

  static setAppToken(String val) {
    _getStorage.write("token", val);
  }

  static getUserName() {
    return _getStorage.read("name");
  }

  static setUserPhone(String? val) {
    _getStorage.write("phone", val);
  }

  static getUserPhone() {
    return _getStorage.read("phone");
  }

  getDeviceId() {
    print(" from the method : ${_getStorage.read("device_id")}");
    return _getStorage.read("device_id");
  }

  Future<void> setDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _getStorage.write("device_id", androidInfo.id);
      print("device id : ${androidInfo.id}");
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _getStorage.write("device_id", iosInfo.identifierForVendor);
    }
  }
}

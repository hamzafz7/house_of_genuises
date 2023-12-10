import 'package:get_storage/get_storage.dart';

class CacheProvider {
  static late GetStorage _getStorage;

  CacheProvider() {
    _getStorage = GetStorage();
  }
  static init() {
    _getStorage = GetStorage();
  }

  getIsOnBoardingOpened() {
    return _getStorage.read("onboarding");
  }

  setIsOnBoardingOpened(bool value) {
    return _getStorage.write("onboarding", value);
  }

  getAppToken() {
    return _getStorage.read("token");
  }
}

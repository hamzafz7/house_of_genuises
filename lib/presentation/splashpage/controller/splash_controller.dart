import 'package:get/get.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      if (CacheProvider().getIsOnBoardingOpened() == null) {
        Get.toNamed(AppRoute.onboardingPageRoute);
      } else if (CacheProvider().getAppToken() == null) {
        Get.toNamed(AppRoute.loginPageRoute);
      } else {}
    });
    super.onInit();
  }
}

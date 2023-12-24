import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/Auth/pages/login_page.dart';
import 'package:house_of_genuises/presentation/Auth/pages/register_page.dart';
import 'package:house_of_genuises/presentation/onboarding/pages/on_boarding_page.dart';
import 'package:house_of_genuises/presentation/settings/pages/about_us_page.dart';
import 'package:house_of_genuises/presentation/settings/pages/settings_page.dart';
import 'package:house_of_genuises/presentation/userinfo/page/user_info_page.dart';

class AppRoute {
  static String onboardingPageRoute = '/onboarding';
  static String loginPageRoute = '/login';
  static String registerPageRoute = '/register';
  static String userInfoPageRoute = '/userinfo';
  static String settingsPageRoute = '/settings';
  static String aboutUsPageRoute = "/about_us";
  static List<GetPage> pages = [
    GetPage(name: onboardingPageRoute, page: () => const OnBoardingPage()),
    GetPage(name: loginPageRoute, page: () => const LoginPage()),
    GetPage(name: registerPageRoute, page: () => const RegisterPage()),
    GetPage(name: userInfoPageRoute, page: () => UserInfoPage()),
    GetPage(name: settingsPageRoute, page: () => const SettingsPage()),
    GetPage(name: aboutUsPageRoute, page: () => const AboutUsPage()),
  ];
}

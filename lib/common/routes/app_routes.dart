import 'package:get/get.dart';
import 'package:house_of_genuises/presentation/Auth/pages/login_page.dart';
import 'package:house_of_genuises/presentation/Auth/pages/register_page.dart';
import 'package:house_of_genuises/presentation/course_details/pages/course_details_page.dart';
import 'package:house_of_genuises/presentation/course_details/widgets/show_course_video.dart';
import 'package:house_of_genuises/presentation/mainpage/pages/main_page.dart';
import 'package:house_of_genuises/presentation/onboarding/pages/on_boarding_page.dart';
import 'package:house_of_genuises/presentation/quizzes/pages/quiz_page.dart';
import 'package:house_of_genuises/presentation/quizzes/pages/results_page.dart';
import 'package:house_of_genuises/presentation/settings/pages/about_us_page.dart';
import 'package:house_of_genuises/presentation/settings/pages/settings_page.dart';
import 'package:house_of_genuises/presentation/userinfo/page/user_info_page.dart';
import 'package:house_of_genuises/presentation/yearcoursespage/page/year_courses_page.dart';

class AppRoute {
  static String onboardingPageRoute = '/onboarding';
  static String loginPageRoute = '/login';
  static String registerPageRoute = '/register';
  static String userInfoPageRoute = '/userinfo';
  static String yearsPageRoute = '/years_page';
  static String settingsPageRoute = '/settings';
  static String aboutUsPageRoute = "/about_us";
  static String mainPageRoute = "/main_page";
  static String courseDetailsPageRoute = "/course_detail";
  static String showCourseVideoRoute = '/show_course_pdf';
  static String showCoursePdfRoute = '/show_course_pdf';
  static String showQuizResultRoute = '/show_result_page';
  static String quizzPageRoute = '/quizz_page';
  static List<GetPage> pages = [
    GetPage(name: onboardingPageRoute, page: () => const OnBoardingPage()),
    GetPage(name: loginPageRoute, page: () => const LoginPage()),
    GetPage(name: registerPageRoute, page: () => const RegisterPage()),
    GetPage(name: userInfoPageRoute, page: () => UserInfoPage()),
    GetPage(name: settingsPageRoute, page: () => const SettingsPage()),
    GetPage(name: aboutUsPageRoute, page: () => const AboutUsPage()),
    GetPage(name: mainPageRoute, page: () => const MainPage()),
    GetPage(name: yearsPageRoute, page: () => YearsCoursesPage()),
    GetPage(
        name: courseDetailsPageRoute, page: () => const CourseDetailsPage()),
    GetPage(name: showCourseVideoRoute, page: () => const ShowCourseVideo()),
    GetPage(name: showCourseVideoRoute, page: () => const ShowCourseVideo()),
    GetPage(name: showQuizResultRoute, page: () => ResultsPage()),
    GetPage(name: quizzPageRoute, page: () => const QuizzesPage()),
  ];
}

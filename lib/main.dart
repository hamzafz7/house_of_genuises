import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/common/themes/themes.dart';
import 'package:house_of_genuises/data/providers/apiProvider/api_provider.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:house_of_genuises/presentation/splashpage/page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await CacheProvider.init();
  await ApiProvider.init();
  secureScreen();
  if (CacheProvider().getDeviceId() == null) {
    await CacheProvider().setDeviceId();
    runApp(const MyApp());
  } else {
    runApp(const MyApp());
  }
}

Future<void> secureScreen() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lighttheme,
              darkTheme: darkTheme,
              themeMode: CacheProvider.getAppTheme()
                  ? ThemeMode.dark
                  : ThemeMode.light,
              locale: const Locale('ar'),
              getPages: AppRoute.pages,
              home: const SplashPage(),
            ));
  }
}

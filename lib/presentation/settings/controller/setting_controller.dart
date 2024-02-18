import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  void launchTelegramURL() async {
    const url =
        'https://t.me/Mk_0934'; // Replace with your actual Telegram link
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowCourseVideo extends StatefulWidget {
  const ShowCourseVideo({super.key, this.video});
  final String? video;

  @override
  State<ShowCourseVideo> createState() => _ShowCourseVideoState();
}

class _ShowCourseVideoState extends State<ShowCourseVideo> {
  late WebViewController webViewController;

  @override
  void initState() {
    webViewController = WebViewController()
      ..loadRequest(Uri.parse(widget.video!), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': " Bearer ${CacheProvider.getAppToken()}",
      })
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  void dispose() {
    // webViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}

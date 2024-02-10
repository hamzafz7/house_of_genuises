import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FileViewWidget extends StatefulWidget {
  final String imagePath;

  const FileViewWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<FileViewWidget> createState() => _FileViewWidgetState();
}

class _FileViewWidgetState extends State<FileViewWidget> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.imagePath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: PDF(
      //   swipeHorizontal: false,
      // ).cachedFromUrl(
      //   imagePath,
      //   placeholder: (progress) => Center(
      //       child: Text(
      //     '$progress %',
      //   )),
      //   errorWidget: (error) => Center(
      //     child: Text(
      //       error.toString(),
      //     ),
      //   ),
      // ),
      body: WebViewWidget(controller: controller),
    );
  }
}

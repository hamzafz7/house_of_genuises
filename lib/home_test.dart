// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:path_provider/path_provider.dart';

// class HomeTest extends StatefulWidget {
//   const HomeTest({super.key});

//   @override
//   State<HomeTest> createState() => _HomeTestState();
// }

// class _HomeTestState extends State<HomeTest> {
//   List<String> savedVideoPaths = [];
//   @override
//   void initState() {
//     try {
//       getApplicationDocumentsDirectory().then((value) {
//         var files = Directory(value.path).listSync();
//         savedVideoPaths = files
//             .where((file) => file.path.endsWith('.mp4'))
//             .map((file) => file.path)
//             .toList();
//         print(" this is : ${savedVideoPaths.length}");
//         // setState(() {});
//       });
//     } catch (e) {}

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // body: Center(
//         //   child: TextButton(
//         //       onPressed: () async {
//         //         if (savedVideoPaths.isNotEmpty) {
//         //           print("zzz");
//         //           Get.to(VideoPlayerScreen(
//         //             videoPath: savedVideoPaths[1],
//         //           ));
//         //         }
//         //       },
//         //       child: Text("press me")),
//         // ),
//         //   body: Center(
//         //       child: Math.tex(
//         //         r'\frac{2^2}{x} \cdot \frac{(5+1)}{2} + \left\{\left\{3,1\right\},\left\{2,6\right\}\right\}',
//         //         textStyle: TextStyle(fontSize: 20),
//         //       ),
//         // );
//         );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(Uri.parse(
          'https://api.houseofgeniuses.tech/api/watch//videos/902709114'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    // _downloadAndEncryptVideo(); // Download and encrypt the video when the widget initializes
  }

  // Future<void> _downloadAndEncryptVideo() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final savedVideoPath = '${directory.path}/encrypted_video.mp4';

  //   // Download the video file
  //   await FlutterDownloader.enqueue(
  //     url: 'your_video_url_here',
  //     savedDir: directory.path,
  //     fileName: 'video.mp4',
  //     showNotification: true,
  //     openFileFromNotification: true,
  //   );

  //   // Read the downloaded video file
  //   File videoFile = File('$directory/video.mp4');
  //   List<int> videoBytes = await videoFile.readAsBytes();

  //   // Perform encryption
  //   final key = encrypt.Key.fromUtf8('your_secret_key_here');
  //   final iv = encrypt.IV.fromLength(16);
  //   final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //   final encryptedBytes = encrypter.encryptBytes(videoBytes, iv: iv);

  //   // Write encrypted video to file
  //   File encryptedFile = File(savedVideoPath);
  //   // await encryptedFile.writeAsBytes(encryptedBytes);
  // }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}

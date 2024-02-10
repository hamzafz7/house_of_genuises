import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowCourseVideo extends StatefulWidget {
  const ShowCourseVideo({super.key, this.video});
  final String? video;

  @override
  State<ShowCourseVideo> createState() => _ShowCourseVideoState();
}

class _ShowCourseVideoState extends State<ShowCourseVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late FlickManager flickManager;
  late WebViewController controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          "https://vod-progressive.akamaized.net/exp=1707523444~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F1433%2F15%2F382169007%2F1603697582.mp4~hmac=f22209aadaa4dcf8af1ca67588167b4824248885005278014cea93ebaaf90ba5/vimeo-prod-skyfire-std-us/01/1433/15/382169007/1603697582.mp4"),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    flickManager = FlickManager(
      videoPlayerController: _controller,
    );

    // flickManager = FlickManager(videoPlayerController: _controller);
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..loadRequest(Uri.parse(widget.video!));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: FlickVideoPlayer(
                flickManager: flickManager,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      //     body: Column(
      //   children: [
      //     SizedBox(
      //         height: Get.height - 40.h,
      //         width: Get.width,
      //         child: WebViewWidget(
      //           controller: controller,
      //         )),
      //   ],
      // )),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   _controller.play();
      // }),
    ));
  }
}

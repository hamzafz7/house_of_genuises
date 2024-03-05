import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/data/models/video_model.dart';
import 'package:video_player/video_player.dart';

class downloadedVideoController extends GetxController {
  Video? video;
  @override
  void onInit() {
    video = Get.arguments;
    if (video != null) watchVideo();
    super.onInit();
  }

  var watchVideoStatus = RequestStatus.begin.obs;
  updateWatchVideoStatus(RequestStatus status) =>
      watchVideoStatus.value = status;
  VideoPlayerController? videoPlayerController;
  final _secureStorage = const FlutterSecureStorage();

  Future<void> watchVideo() async {
    updateWatchVideoStatus(RequestStatus.loading);
    if (video != null) {
      try {
        final key = 'video_${video?.courseName}-${video!.videoName}';
        final path = await _secureStorage.read(key: key);
        File file = File(path!);
        videoPlayerController = VideoPlayerController.file(file)..initialize();
        updateWatchVideoStatus(RequestStatus.success);
      } catch (e) {
        updateWatchVideoStatus(RequestStatus.success);
      }
    } else {
      updateWatchVideoStatus(RequestStatus.success);
    }
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}

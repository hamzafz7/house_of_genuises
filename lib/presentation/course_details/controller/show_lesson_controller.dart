import "package:get/get.dart";
import "package:house_of_genuises/common/constants/enums/request_enum.dart";
import "package:house_of_genuises/data/repositories/category_repo.dart";
import "package:video_player/video_player.dart";

class ShowLessonController extends GetxController {
  @override
  void onInit() {
    String link = Get.arguments;
    watchVideo(link);
    super.onInit();
  }

  final CategoryRepository _categoryRepository = CategoryRepository();
  VideoPlayerController? videoPlayerController;
  var watchVideoStatus = RequestStatus.begin.obs;
  updateWatchVideoStatus(RequestStatus status) =>
      watchVideoStatus.value = status;
  Future<void> watchVideo(String link) async {
    updateWatchVideoStatus(RequestStatus.loading);
    var response = await _categoryRepository.watchVideo(link);
    if (response.success) {
      print(response.data['link'].first['link']);
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(response.data['link'].first['link']))
        ..initialize();

      updateWatchVideoStatus(RequestStatus.success);
    } else {
      updateWatchVideoStatus(RequestStatus.onError);
      print(response.errorMessage);
    }
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}

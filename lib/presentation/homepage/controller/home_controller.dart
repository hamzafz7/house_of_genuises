import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/data/models/news_model.dart';
import 'package:house_of_genuises/data/repositories/home_repo..dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getNews();
    super.onInit();
  }

  NewsResponse? newsResponse;

  var getNewsStatus = RequestStatus.begin.obs;
  updateGetNewsStatus(RequestStatus status) => getNewsStatus.value = status;
  final HomeRepository _homeRepository = HomeRepository();
  Future<void> getNews() async {
    updateGetNewsStatus(RequestStatus.loading);
    var response = await _homeRepository.getNews();
    if (response.success) {
      newsResponse = NewsResponse.fromJson(response.data);
      if (newsResponse!.news.isEmpty) {
        updateGetNewsStatus(RequestStatus.noData);
      } else {
        updateGetNewsStatus(RequestStatus.success);
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateGetNewsStatus(RequestStatus.noInternentt);
      } else {
        updateGetNewsStatus(RequestStatus.onError);
      }
    }
  }
}

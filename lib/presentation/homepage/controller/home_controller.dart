import 'package:get/get.dart';
import 'package:house_of_genuises/common/constants/enums/request_enum.dart';
import 'package:house_of_genuises/data/models/categories_model.dart';
import 'package:house_of_genuises/data/models/news_model.dart';
import 'package:house_of_genuises/data/repositories/category_repo.dart';
import 'package:house_of_genuises/data/repositories/home_repo..dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getNews();
    getCategories();

    super.onInit();
  }

  NewsResponse? newsResponse;
  CategoriesModel? categoriesModel;
  RxInt currentCategoryIndex = 0.obs;

  changeCurrentIndex(int ind, int courseId) {
    currentCategoryIndex.value = ind;
    getCourses(courseId);
  }

  var getNewsStatus = RequestStatus.begin.obs;
  var categoriesStatus = RequestStatus.begin.obs;
  updateGetNewsStatus(RequestStatus status) => getNewsStatus.value = status;

  var courseStatus = RequestStatus.loading.obs;
  updatecourseStatus(RequestStatus status) => courseStatus.value = status;
  updateCategoriesStatus(RequestStatus status) =>
      categoriesStatus.value = status;
  final HomeRepository _homeRepository = HomeRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

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

  Future<void> getCategories() async {
    updateCategoriesStatus(RequestStatus.loading);
    var response = await _categoryRepository.getCategories();
    if (response.success) {
      categoriesModel = CategoriesModel.fromJson(response.data);
      if (categoriesModel!.categories == null ||
          categoriesModel!.categories!.isEmpty) {
        updateCategoriesStatus(RequestStatus.noData);
      } else {
        updateCategoriesStatus(RequestStatus.success);
        getCourses(categoriesModel!.categories![0].id!);
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateCategoriesStatus(RequestStatus.noInternentt);
      } else {
        updateCategoriesStatus(RequestStatus.onError);
      }
    }
  }

  Future<void> getCourses(int id) async {
    updatecourseStatus(RequestStatus.loading);
    var response = await _categoryRepository.getCourses(id);
    if (response.success) {
      categoriesModel = CategoriesModel.fromJson(response.data);
      // if (categoriesModel!.categories == null ||
      //     categoriesModel!.categories!.isEmpty) {
      //   updatecourseStatus(RequestStatus.noData);
      // } else {
      updatecourseStatus(RequestStatus.success);
      print(response.data);
      // }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updatecourseStatus(RequestStatus.noInternentt);
      } else {
        updatecourseStatus(RequestStatus.onError);
      }
    }
  }
}

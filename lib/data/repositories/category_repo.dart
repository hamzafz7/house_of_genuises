import 'package:dio/dio.dart';
import 'package:house_of_genuises/data/endpoints.dart';
import 'package:house_of_genuises/data/models/app_response.dart';
import 'package:house_of_genuises/data/providers/apiProvider/api_provider.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';

class CategoryRepository {
  Future<AppResponse> getCategories() async {
    try {
      var response = await ApiProvider.get(
          url: categoriesUrl, token: CacheProvider.getAppToken());
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> getCourses(int id) async {
    try {
      var response = await ApiProvider.get(
          url: "$coursesUrl/$id", token: CacheProvider.getAppToken());
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }
}

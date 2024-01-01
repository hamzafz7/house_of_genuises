import 'package:dio/dio.dart';
import 'package:house_of_genuises/data/endpoints.dart';
import 'package:house_of_genuises/data/models/app_response.dart';
import 'package:house_of_genuises/data/models/user_model.dart';
import 'package:house_of_genuises/data/providers/apiProvider/api_provider.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';

class AccountRepo {
  Future<AppResponse> userLogin(User model) async {
    try {
      var response = await ApiProvider.post(
        url: loginUrl,
        body: model.loginUserToJson(),
      );
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

  Future<AppResponse> userRegister(User model) async {
    try {
      var response = await ApiProvider.post(
        url: registerUrl,
        body: model.registerUserToJson(),
      );
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

  Future<AppResponse> signOut() async {
    try {
      final response = await ApiProvider.post(
        url: logOutUrl,
        token: CacheProvider.getAppToken(),
      );
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message ?? e.toString(),
        data: null,
        success: false,
      );
    }
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/data/repositories/account_repo.dart';
import '../../endpoints.dart';

class AppInterceptors extends Interceptor {
  final Dio? dio;
  final AccountRepo? repo;

  AppInterceptors({required this.dio, required this.repo});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("request is sending");
    debugPrint("REQUEST[${options.method}] => PATH: $baseUrl${options.path}");

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint("response is getting");

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(DioException(
          requestOptions: response.requestOptions, message: "no_internet"));
    }

    if (response.statusCode == 401) {
      debugPrint("hello from 401");
      // LoginModel model = LoginModel(
      //   email: Shared.getstring("email")!,
      //   password: Shared.getstring("password")!,
      // );
      // var appResponse = await repository.userLogin(model);
      // Shared.setstring("token", appResponse.data["token"]);
      // var options = response.requestOptions;
      // options.headers['Authorization'] = 'Bearer ${Shared.getstring("token")}';
      // await dio!.fetch(options);
      Get.snackbar("sorry".tr, "re_login".tr);
    }
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.message == "no_internet") {
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: 'no_internet'.tr,
        ),
      );
    }
    // if (err.error is SocketException) {
    //   return handler.next(
    //     DioException(
    //       requestOptions: err.requestOptions,
    //       message: 'no_internet'.tr,
    //     ),
    //   );
    // }
    else if (err.response?.statusCode == 401) {
      if (Get.currentRoute != '/login') {
        Get.offAllNamed(AppRoute.loginPageRoute);
      }
    } else if (err.response?.statusCode == 422) {
      String? error = err.response?.data['message'] ?? "wrong_request";
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: error!.tr,
        ),
      );
    } else if (err.response?.statusCode == 403) {
      try {
        String? error = err.response?.data['error'] ?? "wrong_request";
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: error!.tr,
          ),
        );
      } catch (e) {
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: 'wrong_request'.tr,
          ),
        );
      }
    } else {
      String? error = err.response?.data['message'] ?? "wrong_request";
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: error,
        ),
      );
    }
  }
}

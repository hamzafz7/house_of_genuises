import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:house_of_genuises/common/routes/app_routes.dart';
import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';
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
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(DioException(
          requestOptions: options, message: "لا يوجد اتصال بالانترنت"));
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint("response is getting");
    print(response.statusCode);

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(DioException(
          requestOptions: response.requestOptions,
          message: "لا يوجد اتصال بالانترنت"));
    }
    if (!response.requestOptions.persistentConnection) {
      return handler.reject(DioException(
          requestOptions: response.requestOptions,
          message: "لا يوجد اتصال بالانترنت"));
    }
    if ((response.statusCode != 200 &&
            response.statusCode != 201 &&
            response.statusCode != 401 &&
            response.statusCode != 403 &&
            response.statusCode != 422) ||
        response.statusCode == null) {
      handler.reject(DioException(
          requestOptions: response.requestOptions,
          message: "لا يوجد اتصال بالانترنت"));
    } else {
      return handler.next(response);
    }
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.data == null) {
      print("********");

      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: "لا يوجد اتصال بالانترنت".tr,
        ),
      );
    }
    if (err.message == "لا يوجد اتصال بالانترنت") {
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: "لا يوجد اتصال في الانترنت",
        ),
      );
    } else if (err.response?.statusCode == 404) {
      if (Get.currentRoute != '/login') {
        CacheProvider.clearAppToken();
        Get.offAllNamed(AppRoute.loginPageRoute);
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: "هذا الحساب لم يعد موجود",
          ),
        );
      } else if (Get.currentRoute == '/login') {
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: "هذا الحساب غير موجود",
          ),
        );
      }
    } else if (err.response?.statusCode == 401) {
      if (Get.currentRoute != '/login') {
        Get.offAllNamed(AppRoute.loginPageRoute);
      } else if (Get.currentRoute == '/login') {
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: err.response?.data['message'] ?? " حدث خطأ ما",
          ),
        );
      }
    } else if (err.response?.statusCode == 422) {
      String? error = err.response?.data['message'] ?? "حدث خطأ ما ";
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: error!.tr,
        ),
      );
    } else if (err.response?.statusCode == 403) {
      try {
        String? error = err.response?.data['message'] ?? "حدث خطأ ما ";
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
            message: 'حدث خطأ ما'.tr,
          ),
        );
      }
    } else {
      String? error = err.response?.data['message'] ?? "حدث خطأ ما";
      print(error);
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: error,
        ),
      );
    }
  }
}

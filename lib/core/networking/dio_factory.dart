import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';
import 'api_constants.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static Dio? refreshDio;

  // ===================== MAIN DIO =====================
  static Dio getDio() {
    const timeout = Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();

      dio!
        ..options.connectTimeout = timeout
        ..options.receiveTimeout = timeout;

      addDioHeaders();
      addDioInterceptor();
    }

    return dio!;
  }

  // ===================== REFRESH DIO =====================
  static Dio getRefreshDio() {
    const timeout = Duration(seconds: 30);

    if (refreshDio == null) {
      refreshDio = Dio();

      refreshDio!
        ..options.connectTimeout = timeout
        ..options.receiveTimeout = timeout
        ..options.headers = {
          "Accept": "application/json",
        };
    }

    return refreshDio!;
  }

  // ===================== HEADERS =====================
  static Future<void> addDioHeaders() async {
    String lang = await SharedPrefHelper.getString("app_lang");
    String? accessToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.accessToken,
    );

    dio?.options.headers = {
      "Accept": "application/json",
      "Accept-Language": lang.isEmpty ? "en" : lang,
      if (accessToken != null && accessToken.isNotEmpty)
        "Authorization": "Bearer $accessToken",
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers["Authorization"] = "Bearer $token";
  }

  // ===================== INTERCEPTOR =====================
  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) async {
          final isRefreshCall =
          error.requestOptions.path.contains("refreshToken");

          // ❌ منع loop
          if (error.response?.statusCode == 401 && !isRefreshCall) {
            debugPrint("🔄 401 detected → trying refresh token...");

            final refreshed = await _refreshAccessToken();

            if (refreshed) {
              final requestOptions = error.requestOptions;

              final newToken = await SharedPrefHelper.getSecuredString(
                SharedPrefKeys.accessToken,
              );

              requestOptions.headers["Authorization"] = "Bearer $newToken";

              debugPrint("🔁 Retrying request...");
              final retryResponse = await dio!.fetch(requestOptions);

              return handler.resolve(retryResponse);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  // ===================== REFRESH TOKEN =====================
  static Future<bool> _refreshAccessToken() async {
    try {
      final refreshToken = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.refreshToken,
      );

      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint("❌ No refresh token found");
        return false;
      }

      debugPrint("🔄 Refreshing token...");

      final response = await getRefreshDio().post(
        "${ApiConstants.apiBaseUrl}/refreshToken",
        data: {
          "refresh_token": refreshToken,
        },
      );

      if (response.statusCode != 200 || response.data["data"] == null) {
        debugPrint("❌ Refresh failed");
        return false;
      }

      final tokens = response.data["data"]?["tokens"];

      if (tokens == null) return false;

      final newAccess = tokens["access_token"];
      final newRefresh = tokens["refresh_token"];

      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.accessToken,
        newAccess,
      );

      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.refreshToken,
        newRefresh,
      );

      dio?.options.headers["Authorization"] = "Bearer $newAccess";

      debugPrint("✅ Token refreshed successfully");

      return true;
    } catch (e) {
      print(await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken));
      print(await SharedPrefHelper.getSecuredString(SharedPrefKeys.refreshToken));
      debugPrint("❌ Refresh error: $e");
      return false;
    }
  }
}
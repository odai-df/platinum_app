import 'package:platinum_app/core/networking/api_result.dart';
import 'package:platinum_app/core/networking/api_service.dart';
import '../networking/api_error_handler.dart';
import '../networking/api_response.dart';

class NotificationRepo {
  final ApiService _apiService;

  NotificationRepo(this._apiService);

  Future<ApiResult<ApiResponse>> registerDeviceToken({
    required String fcmToken,
    required String deviceType,
  }) async {
    try {
      final response = await _apiService.registerDeviceToken(
        {
          "fcm_token": fcmToken,
          "device_type": deviceType,
        },
      );

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<ApiResponse>> deleteDeviceToken(
      String token,
      ) async {
    try {
      final response = await _apiService.deleteDeviceToken(
        {
          "fcm_token": token,
        },
      );

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }
}
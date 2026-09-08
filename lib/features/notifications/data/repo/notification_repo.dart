import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_response.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/notifications_response.dart';
import '../models/unread_count_response.dart';

class NotificationsRepo {
  final ApiService _apiService;

  NotificationsRepo(
    this._apiService,
  );

  Future<ApiResult<NotificationsResponse>> getNotifications() async {
    try {
      final response = await _apiService.getNotifications();

      return ApiResult.success(
        response,
      );
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<UnreadCountResponse>> getUnreadCount() async {
    try {
      final response = await _apiService.getUnreadCount();

      return ApiResult.success(
        response,
      );
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<ApiResponse>> markNotificationAsRead(
      String id,
      ) async {
    try {
      final response = await _apiService.markNotificationAsRead(id);

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }


  Future<ApiResult<ApiResponse>> markAllNotificationsAsRead() async {
    try {
      final response =
      await _apiService.markAllNotificationsAsRead();

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }
}

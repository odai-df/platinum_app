import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

import '../models/chat_messages_response.dart';
import '../models/chat_room_response.dart';

class ChatRepo {
  final ApiService _apiService;

  ChatRepo(this._apiService);

  Future<ApiResult<ChatRoomResponse>> createRoom() async {
    try {
      final response = await _apiService.createChatRoom();

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<ChatMessagesResponse>>
  getRoomMessages(
      int roomId,
      ) async {
    try {
      final response =
      await _apiService.getRoomMessages(roomId);

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<dynamic>> sendMessage({
    required int roomId,
    required String content,
  }) async {
    try {
      final response =
      await _apiService.sendMessage({
        "chat_room_id": roomId,
        "content": content,
      });

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }






}
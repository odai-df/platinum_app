import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/faq_response.dart';

class FaqRepo {
  final ApiService _apiService;

  FaqRepo(this._apiService);

  Future<ApiResult<FaqResponse>> getFaqRoot() async {
    try {
      final response = await _apiService.getFaqRoot();

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<FaqResponse>> getFaqChildren(
      int id,
      ) async {
    try {
      final response = await _apiService.getFaqChildren(id);

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }
}
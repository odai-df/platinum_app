import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

import '../models/offers_response.dart';

class OffersRepo {
  final ApiService _apiService;

  OffersRepo(this._apiService);

  Future<ApiResult<OffersResponse>> getOffers() async {
    try {
      final response = await _apiService.getOffers();

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }
}
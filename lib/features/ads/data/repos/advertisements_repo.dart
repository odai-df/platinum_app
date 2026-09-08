import 'package:platinum_app/core/networking/api_error_handler.dart';
import 'package:platinum_app/core/networking/api_result.dart';
import 'package:platinum_app/core/networking/api_service.dart';

import '../models/advertisement_model.dart';
import '../models/advertisement_details_model.dart';

class AdvertisementsRepo {
  final ApiService _apiService;

  AdvertisementsRepo(this._apiService);

  /// Get active advertisements
  Future<ApiResult<List<AdvertisementModel>>> getActiveAds() async {
    try {
      final response = await _apiService.getActiveAdvertisements();

      return ApiResult.success(response.data);
    } catch (e, stack) {
      print("🔥 FULL ERROR:");
      print(e);
      print("📌 STACK:");
      print(stack);

      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /// Get advertisement details
  Future<ApiResult<AdvertisementDetailsModel>> getAdvertisementDetails(
    int id,
  ) async {
    try {
      final response = await _apiService.getAdvertisementDetails(id);

      return ApiResult.success(response.data);
    } catch (e, stack) {
      print("🔥 FULL ERROR:");
      print(e);
      print("📌 STACK:");
      print(stack);

      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}

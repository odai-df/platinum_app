import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/location_response.dart';
import '../models/search_request.dart';
import '../models/search_response.dart';

class SearchRepo {
  final ApiService _apiService;

  SearchRepo(this._apiService);

  Future<ApiResult<SearchResponse>> searchUnits(
      SearchRequest request,
      ) async {
    try {
      final response = await _apiService.searchUnits(
        request.toJson(),
      );

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<LocationResponse>> getLocations() async {
    try {
      final response =
      await _apiService.getLocations();

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }
}
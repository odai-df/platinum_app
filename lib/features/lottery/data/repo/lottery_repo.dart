import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/lottery_details_response.dart';
import '../models/lottery_response.dart';

class LotteryRepo {
  final ApiService _apiService;

  LotteryRepo(this._apiService);

  Future<ApiResult<LotteryResponse>> getLotteries() async {
    try {
      final response = await _apiService.getLotteries();

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }


  Future<ApiResult<LotteryDetailsResponse>>
  getLotteryDetails(int id) async {
    try {
      final response =
      await _apiService.getLotteryDetails(id);

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }
}
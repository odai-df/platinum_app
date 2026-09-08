import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/solution_details_model.dart';
import '../models/solution_model.dart';

class SolutionsRepo {
  final ApiService _apiService;

  SolutionsRepo(this._apiService);

  Future<ApiResult<List<SolutionModel>>> getSolutions() async {
    try {
      final response = await _apiService.getSolutions();

      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }


  Future<SolutionDetailsModel> getDetails(int id) async {
    final response = await _apiService.getSolutionDetails(id);
    return response.data;
  }
}
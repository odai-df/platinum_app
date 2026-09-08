import 'package:platinum_app/core/networking/api_error_handler.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/my_unit_model.dart';

class MyUnitsRepo {
  final ApiService apiService;

  MyUnitsRepo(this.apiService);

  Future<ApiResult<List<MyUnitModel>>> getMyUnits() async {
    try {
      final response = await apiService.getMyUnits();

      return ApiResult.success(
        response.data ?? [],
      );
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }
}

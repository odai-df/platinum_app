import 'package:dio/dio.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_error_model.dart';
import '../../../../core/networking/api_service.dart';
import '../models/contract_details_response.dart';
import '../models/contract_response.dart';

class ContractRepo {
  final ApiService _apiService;

  ContractRepo(this._apiService);

  Future<ApiResult<ContractResponse>> getContracts() async {
    try {
      final response = await _apiService.getContracts();

      print(
        "REPO RESPONSE SUCCESS",
      );

      return ApiResult.success(response);
    } catch (e, stack) {
      print(
        "REPO ERROR => $e",
      );

      print(stack);

      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<ContractDetailsResponse>> getContractDetails(int id) async {
    try {
      final response = await _apiService.getContractDetails(id);

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}

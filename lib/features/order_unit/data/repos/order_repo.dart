import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/create_order_request.dart';
import '../models/my_order_response.dart';
import '../models/my_solution_orders_response.dart';
import '../models/order_response.dart';

class OrderRepo {
  final ApiService _apiService;

  OrderRepo(this._apiService);

  Future<ApiResult<OrderResponse>> createOrder(
      CreateOrderRequest request,
      ) async {
    try {
      final response =
      await _apiService.createOrder(request.toMap());

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }


  Future<ApiResult<MyOrdersResponse>> getMyOrders() async {
    try {
      final response = await _apiService.getMyOrders();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<MySolutionOrdersResponse>>
  getMySolutionOrders() async {
    try {
      final response =
      await _apiService.getMySolutionOrders();

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }



}
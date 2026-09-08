import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/create_order_request.dart';
import '../data/repos/order_repo.dart';
import 'ordar_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;

  OrderCubit(this.orderRepo) : super(OrderInitial());

  Future<void> createUnitOrder(int unitId) async {
    emit(OrderLoading());

    final result = await orderRepo.createOrder(
      CreateOrderRequest(
        unitId: unitId,
      ),
    );

    result.when(
      success: (res) {
        emit(OrderSuccess(res.message));
      },
      failure: (error) {
        emit(
          OrderError(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  Future<void> createSolutionOrder(int solutionId) async {
    emit(OrderLoading());

    final result = await orderRepo.createOrder(
      CreateOrderRequest(
        solutionId: solutionId,
      ),
    );

    result.when(
      success: (res) {
        emit(OrderSuccess(res.message));
      },
      failure: (error) {
        emit(
          OrderError(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/order_repo.dart';
import 'my_order_stete.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrderRepo repo;

  OrdersCubit(this.repo) : super(OrdersInitial());

  Future<void> getMyOrders() async {
    emit(OrdersLoading());

    final result = await repo.getMyOrders();

    result.when(
      success: (res) {
        emit(OrdersSuccess(res.data)); // 👈 List<OrderModel>
      },
      failure: (error) {
        emit(
          OrdersError(error.apiErrorModel.message ?? "Error"),
        );
      },
    );
  }
}
import '../data/models/my_order_response.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders;

  OrdersSuccess(this.orders);
}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}
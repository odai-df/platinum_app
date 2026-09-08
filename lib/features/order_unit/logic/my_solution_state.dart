import '../data/models/my_solution_orders_response.dart';

abstract class SolutionOrdersState {}

class SolutionOrdersInitial extends SolutionOrdersState {}

class SolutionOrdersLoading extends SolutionOrdersState {}

class SolutionOrdersSuccess extends SolutionOrdersState {
  final List<SolutionOrderModel> orders;

  SolutionOrdersSuccess(this.orders);
}

class SolutionOrdersError extends SolutionOrdersState {
  final String message;

  SolutionOrdersError(this.message);
}
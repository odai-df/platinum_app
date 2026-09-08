import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/order_repo.dart';
import 'my_solution_state.dart';

class SolutionOrdersCubit
    extends Cubit<SolutionOrdersState> {

  final OrderRepo repo;

  SolutionOrdersCubit(this.repo)
      : super(SolutionOrdersInitial());

  Future<void> getMySolutionOrders() async {

    emit(SolutionOrdersLoading());

    final result =
    await repo.getMySolutionOrders();

    result.when(
      success: (res) {
        emit(
          SolutionOrdersSuccess(res.data),
        );
      },

      failure: (error) {
        emit(
          SolutionOrdersError(
            error.apiErrorModel.message ??
                "Something went wrong",
          ),
        );
      },
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/solution_repo.dart';
import 'solutions_state.dart';

class SolutionsCubit extends Cubit<SolutionsState> {
  final SolutionsRepo repo;

  SolutionsCubit(this.repo) : super(const SolutionsState.initial());

  Future<void> getSolutions() async {
    emit(const SolutionsState.loading());

    final result = await repo.getSolutions();

    result.when(
      success: (data) => emit(SolutionsState.success(data)),
      failure: (error) => emit(SolutionsState.error(error.apiErrorModel.message)),
    );
  }
}
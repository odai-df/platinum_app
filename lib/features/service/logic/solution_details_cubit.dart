import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/solution_repo.dart';
import 'solution_details_state.dart';

class SolutionDetailsCubit extends Cubit<SolutionDetailsState> {
  final SolutionsRepo repo;

  SolutionDetailsCubit(this.repo) : super(const SolutionDetailsState.initial());

  Future<void> getDetails(int id) async {
    emit(const SolutionDetailsState.loading());

    try {
      final data = await repo.getDetails(id);
      emit(SolutionDetailsState.success(data));
    } catch (e) {
      emit(SolutionDetailsState.error(e.toString()));
    }
  }
}
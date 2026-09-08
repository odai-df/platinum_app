import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/features/units_details/logic/unit_details_state.dart';

import '../data/repos/unit_details_repos.dart';

class UnitDetailCubit extends Cubit<UnitDetailState> {
  final UnitDetailRepo repo;

  UnitDetailCubit(this.repo) : super(UnitDetailInitial());

  Future<void> getUnitDetails(int id) async {
    emit(UnitDetailLoading());

    try {
      final data = await repo.getUnitDetails(id);
      emit(UnitDetailSuccess(data));
    } catch (e) {
      emit(UnitDetailFailure(e.toString()));
    }
  }
}
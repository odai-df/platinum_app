import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/features/units/logic/units_state.dart';

import '../data/models/unit_model.dart';
import '../data/repos/units_repo.dart';

class UnitsCubit extends Cubit<UnitsState> {
  final UnitsRepo repo;

  UnitsCubit(this.repo) : super(UnitsInitial());

  int _currentPage = 1;
  bool _isLastPage = false;
  List<UnitModel> _units = [];

  Future<void> fetchUnits() async {
    print("🚀 fetchUnits CALLED");

    emit(UnitsLoading());
    print("📡 State: UnitsLoading emitted");

    _currentPage = 1;
    _isLastPage = false;
    _units.clear();

    try {
      final response = await repo.getUnits(page: _currentPage);

      print("✅ API SUCCESS");
      print("📦 Units received: ${response.data.length}");
      print("📄 currentPage: ${response.meta.currentPage}");
      print("📄 lastPage: ${response.meta.lastPage}");

      _units = response.data;

      _isLastPage = _currentPage >= response.meta.lastPage;

      emit(
        UnitsSuccess(
          units: _units,
          isLastPage: _isLastPage,
        ),
      );

      print("🎯 State: UnitsSuccess emitted");
    } catch (e) {
      print("❌ ERROR in fetchUnits: $e");
      emit(UnitsFailure(e.toString()));
    }
  }
  Future<void> loadMore() async {
    print("⬇️ loadMore CALLED");

    if (_isLastPage) {
      print("⚠️ Already last page - STOP");
      return;
    }

    try {
      emit(UnitsLoadingMore());
      print("📡 State: UnitsLoadingMore emitted");

      _currentPage++;

      print("📄 Requesting page: $_currentPage");

      final response = await repo.getUnits(page: _currentPage);

      print("✅ loadMore SUCCESS");
      print("📦 New units: ${response.data.length}");

      _units.addAll(response.data);

      _isLastPage = _currentPage >= response.meta.lastPage;

      emit(
        UnitsSuccess(
          units: _units,
          isLastPage: _isLastPage,
        ),
      );

      print("🎯 State: UnitsSuccess (after loadMore)");
    } catch (e) {
      print("❌ ERROR in loadMore: $e");
      emit(UnitsFailure(e.toString()));
    }
  }



  void toggleLocalFavorite(int unitId) {
    if (state is UnitsSuccess) {
      final currentState = state as UnitsSuccess;

      final updatedUnits = currentState.units.map((unit) {
        if (unit.id == unitId) {
          return unit.copyWith(
            isFavorite: !unit.isFavorite,
          );
        }
        return unit;
      }).toList();

      emit(UnitsSuccess(
        units: updatedUnits,
        isLastPage: currentState.isLastPage,
      ));
    }
  }
}
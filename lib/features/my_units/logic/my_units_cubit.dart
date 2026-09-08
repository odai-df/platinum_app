import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_result.dart';
import '../data/repo/my_units_repo.dart';
import 'my_units_state.dart';

class MyUnitsCubit extends Cubit<MyUnitsState> {
  final MyUnitsRepo myUnitsRepo;

  MyUnitsCubit(this.myUnitsRepo) : super(const MyUnitsState.initial());

  Future<void> getMyUnits() async {
    emit(const MyUnitsState.loading());

    final result = await myUnitsRepo.getMyUnits();

    result.when(
      success: (units) {
        emit(
          MyUnitsState.success(units),
        );
      },
      failure: (error) {
        emit(
          MyUnitsState.error(
            error.toString(),
          ),
        );
      },
    );
  }
}

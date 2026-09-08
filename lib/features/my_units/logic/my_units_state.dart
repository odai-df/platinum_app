import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/my_unit_model.dart';

part 'my_units_state.freezed.dart';

@freezed
class MyUnitsState with _$MyUnitsState {
  const factory MyUnitsState.initial() = _Initial;

  const factory MyUnitsState.loading() = _Loading;

  const factory MyUnitsState.success(
      List<MyUnitModel> units,
      ) = _Success;

  const factory MyUnitsState.error(
      String message,
      ) = _Error;
}
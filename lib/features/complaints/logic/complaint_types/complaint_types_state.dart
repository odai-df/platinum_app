import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/complaint_type_model.dart';

part 'complaint_types_state.freezed.dart';

@freezed
class ComplaintTypesState with _$ComplaintTypesState {
  const factory ComplaintTypesState.initial() = ComplaintTypesInitial;

  const factory ComplaintTypesState.loading() = ComplaintTypesLoading;

  const factory ComplaintTypesState.success(
    List<ComplaintTypeModel> types,
  ) = ComplaintTypesSuccess;

  const factory ComplaintTypesState.error(
    String message,
  ) = ComplaintTypesError;
}

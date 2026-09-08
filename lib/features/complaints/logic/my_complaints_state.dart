import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/complaint_model.dart';

part 'my_complaints_state.freezed.dart';

@freezed
class MyComplaintsState with _$MyComplaintsState {
  const factory MyComplaintsState.initial() = _Initial;

  const factory MyComplaintsState.loading() = _Loading;

  const factory MyComplaintsState.success(
      List<ComplaintModel> complaints,
      ) = _Success;

  const factory MyComplaintsState.error(
      String message,
      ) = _Error;
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_complaint_state.freezed.dart';

@freezed
class CreateComplaintState with _$CreateComplaintState {
  const factory CreateComplaintState.initial() = CreateComplaintInitial;

  const factory CreateComplaintState.loading() = CreateComplaintLoading;

  const factory CreateComplaintState.success(
    String message,
  ) = CreateComplaintSuccess;

  const factory CreateComplaintState.error(
    String message,
  ) = CreateComplaintError;
}

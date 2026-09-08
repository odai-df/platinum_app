import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_appointment_state.freezed.dart';

@freezed
class CancelAppointmentState with _$CancelAppointmentState {
  const factory CancelAppointmentState.initial() = CancelAppointmentInitial;

  const factory CancelAppointmentState.loading(
    int appointmentId,
  ) = CancelAppointmentLoading;

  const factory CancelAppointmentState.success(
    int appointmentId,
    String message,
  ) = CancelAppointmentSuccess;

  const factory CancelAppointmentState.error(
    String message,
  ) = CancelAppointmentError;
}

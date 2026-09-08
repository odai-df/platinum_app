import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/appointment_model.dart';

part 'appointment_state.freezed.dart';

@freezed
class AppointmentState with _$AppointmentState {
  const factory AppointmentState.initial() = _Initial;

  const factory AppointmentState.loading() = _Loading;

  const factory AppointmentState.success(
      List<AppointmentModel> appointments,
      ) = _Success;

  const factory AppointmentState.error(
      String message,
      ) = _Error;
}
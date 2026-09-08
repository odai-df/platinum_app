import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/appointment_repo.dart';
import 'cancel_appointment_state.dart';

class CancelAppointmentCubit extends Cubit<CancelAppointmentState> {
  final AppointmentRepo _repo;

  CancelAppointmentCubit(this._repo)
      : super(const CancelAppointmentState.initial());

  Future<void> cancelAppointment(
    int appointmentId,
  ) async {
    emit(
      CancelAppointmentState.loading(
        appointmentId,
      ),
    );

    final result = await _repo.cancelAppointment(
      appointmentId,
    );

    result.when(
      success: (response) {
        emit(
          CancelAppointmentState.success(
            appointmentId,
            response.message,
          ),
        );
      },
      failure: (error) {
        emit(
          CancelAppointmentState.error(
            error.apiErrorModel.message ?? "Failed to cancel appointment",
          ),
        );
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/appointment_model.dart';
import '../data/repos/appointment_repo.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo _repo;

  AppointmentCubit(this._repo) : super(const AppointmentState.initial());

  List<AppointmentModel> appointments = [];

  Future<void> getMyAppointments() async {
    emit(const AppointmentState.loading());

    final result = await _repo.getMyAppointments();

    result.when(
      success: (data) {
        appointments = data;

        emit(
          AppointmentState.success(data),
        );
      },
      failure: (error) {
        emit(
          AppointmentState.error(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }
}
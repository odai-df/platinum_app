import 'package:flutter_bloc/flutter_bloc.dart';


import '../data/models/create_appointment_request.dart';
import '../data/repos/appointment_repo.dart';
import 'create_appointment_state.dart';

class CreateAppointmentCubit extends Cubit<CreateAppointmentState> {
  final AppointmentRepo appointmentRepo;

  CreateAppointmentCubit(this.appointmentRepo)
      : super(CreateAppointmentInitial());

  Future<void> createAppointment({
    required int slotId,
    required String type,
    required String notes,
  }) async {
    emit(CreateAppointmentLoading());

    final result = await appointmentRepo.createAppointment(
      CreateAppointmentRequest(
        avSlotId: slotId,
        type: type,
        notes: notes,
      ),
    );

    result.when(
      success: (appointment) {
        emit(
          CreateAppointmentSuccess(appointment),
        );
      },
      failure: (error) {
        emit(
          CreateAppointmentError(
            error.apiErrorModel.message ?? 'Something went wrong',
          ),
        );
      },
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/available_slot_model.dart';
import '../data/repos/appointment_repo.dart';
import 'available_slots_state.dart';

class AvailableSlotsCubit extends Cubit<AvailableSlotsState> {
  final AppointmentRepo appointmentRepo;

  AvailableSlotsCubit(this.appointmentRepo)
      : super(AvailableSlotsInitial());

  List<AvailableSlotModel> slots = [];

  Future<void> getAvailableSlots() async {
    emit(AvailableSlotsLoading());

    final result = await appointmentRepo.getAvailableSlots();

    result.when(
      success: (data) {
        slots = data;

        emit(
          AvailableSlotsSuccess(data),
        );
      },
      failure: (error) {
        emit(
          AvailableSlotsError(
            error.apiErrorModel.message ?? 'Something went wrong',
          ),
        );
      },
    );
  }
}
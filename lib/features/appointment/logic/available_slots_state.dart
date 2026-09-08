
import '../data/models/available_slot_model.dart';

abstract class AvailableSlotsState  {
  const AvailableSlotsState();

  @override
  List<Object?> get props => [];
}

class AvailableSlotsInitial extends AvailableSlotsState {}

class AvailableSlotsLoading extends AvailableSlotsState {}

class AvailableSlotsSuccess extends AvailableSlotsState {
  final List<AvailableSlotModel> slots;

  const AvailableSlotsSuccess(this.slots);

  @override
  List<Object?> get props => [slots];
}

class AvailableSlotsError extends AvailableSlotsState {
  final String message;

  const AvailableSlotsError(this.message);

  @override
  List<Object?> get props => [message];
}
// sales
// general

import '../data/models/create_appointment_response.dart';

abstract class CreateAppointmentState  {
  const CreateAppointmentState();

  @override
  List<Object?> get props => [];
}

class CreateAppointmentInitial extends CreateAppointmentState {}

class CreateAppointmentLoading extends CreateAppointmentState {}

class CreateAppointmentSuccess extends CreateAppointmentState {
  final CreateAppointmentData appointment;

  const CreateAppointmentSuccess(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class CreateAppointmentError extends CreateAppointmentState {
  final String message;

  const CreateAppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}
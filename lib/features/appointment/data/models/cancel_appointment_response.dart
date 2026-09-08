import 'package:json_annotation/json_annotation.dart';

part 'cancel_appointment_response.g.dart';

@JsonSerializable()
class CancelAppointmentResponse {
  final String status;
  final String message;

  CancelAppointmentResponse({
    required this.status,
    required this.message,
  });

  factory CancelAppointmentResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CancelAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CancelAppointmentResponseToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

import 'appointment_note_model.dart';

part 'create_appointment_response.g.dart';

@JsonSerializable()
class CreateAppointmentResponse {
  final String status;
  final String message;
  final CreateAppointmentData data;

  const CreateAppointmentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateAppointmentResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CreateAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateAppointmentResponseToJson(this);
}

@JsonSerializable()
class CreateAppointmentData {
  final int id;
  final String status;
  final String type;

  @JsonKey(name: 'created_at')
  final String createdAt;

  final List<AppointmentNoteModel> notes;

  const CreateAppointmentData({
    required this.id,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.notes,
  });

  factory CreateAppointmentData.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CreateAppointmentDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateAppointmentDataToJson(this);
}
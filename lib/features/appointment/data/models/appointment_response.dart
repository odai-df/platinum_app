import 'package:json_annotation/json_annotation.dart';

import 'appointment_model.dart';

part 'appointment_response.g.dart';

@JsonSerializable()
class AppointmentResponse {
  final String? status;
  final String? message;
  final List<AppointmentModel>? data;

  const AppointmentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppointmentResponseToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelAppointmentResponse _$CancelAppointmentResponseFromJson(
        Map<String, dynamic> json) =>
    CancelAppointmentResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CancelAppointmentResponseToJson(
        CancelAppointmentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

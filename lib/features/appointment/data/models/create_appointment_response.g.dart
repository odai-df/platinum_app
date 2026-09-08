// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAppointmentResponse _$CreateAppointmentResponseFromJson(
        Map<String, dynamic> json) =>
    CreateAppointmentResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data:
          CreateAppointmentData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateAppointmentResponseToJson(
        CreateAppointmentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CreateAppointmentData _$CreateAppointmentDataFromJson(
        Map<String, dynamic> json) =>
    CreateAppointmentData(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      type: json['type'] as String,
      createdAt: json['created_at'] as String,
      notes: (json['notes'] as List<dynamic>)
          .map((e) => AppointmentNoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateAppointmentDataToJson(
        CreateAppointmentData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'type': instance.type,
      'created_at': instance.createdAt,
      'notes': instance.notes,
    };

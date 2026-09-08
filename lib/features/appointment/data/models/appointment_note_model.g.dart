// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentNoteModel _$AppointmentNoteModelFromJson(
        Map<String, dynamic> json) =>
    AppointmentNoteModel(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      createdBy: json['created_by'] == null
          ? null
          : AppointmentUserModel.fromJson(
              json['created_by'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AppointmentNoteModelToJson(
        AppointmentNoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
    };

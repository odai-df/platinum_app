// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: (json['id'] as num?)?.toInt(),
      order: json['order'] == null
          ? null
          : AppointmentOrderModel.fromJson(
              json['order'] as Map<String, dynamic>),
      slot: json['slot'] == null
          ? null
          : AppointmentSlotModel.fromJson(json['slot'] as Map<String, dynamic>),
      status: json['status'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => AppointmentNoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'slot': instance.slot,
      'status': instance.status,
      'type': instance.type,
      'created_at': instance.createdAt,
      'notes': instance.notes,
    };

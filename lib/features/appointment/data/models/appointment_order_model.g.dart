// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentOrderModel _$AppointmentOrderModelFromJson(
        Map<String, dynamic> json) =>
    AppointmentOrderModel(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$AppointmentOrderModelToJson(
        AppointmentOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

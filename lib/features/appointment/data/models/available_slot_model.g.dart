// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotModel _$AvailableSlotModelFromJson(Map<String, dynamic> json) =>
    AvailableSlotModel(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      status: json['status'] as String,
      batchId: json['batch_id'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$AvailableSlotModelToJson(AvailableSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'start_time': instance.startTime,
      'status': instance.status,
      'batch_id': instance.batchId,
      'created_at': instance.createdAt,
    };

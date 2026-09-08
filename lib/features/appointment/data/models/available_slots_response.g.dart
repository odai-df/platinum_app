// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotsResponse _$AvailableSlotsResponseFromJson(
        Map<String, dynamic> json) =>
    AvailableSlotsResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => AvailableSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvailableSlotsResponseToJson(
        AvailableSlotsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

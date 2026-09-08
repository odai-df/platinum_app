// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitDetailResponse _$UnitDetailResponseFromJson(Map<String, dynamic> json) =>
    UnitDetailResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: UnitDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitDetailResponseToJson(UnitDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

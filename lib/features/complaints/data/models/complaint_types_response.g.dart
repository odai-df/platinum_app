// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintTypesResponse _$ComplaintTypesResponseFromJson(
        Map<String, dynamic> json) =>
    ComplaintTypesResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ComplaintTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComplaintTypesResponseToJson(
        ComplaintTypesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

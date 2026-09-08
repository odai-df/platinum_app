// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_complaint_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateComplaintResponse _$CreateComplaintResponseFromJson(
        Map<String, dynamic> json) =>
    CreateComplaintResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] as List<dynamic>?,
    );

Map<String, dynamic> _$CreateComplaintResponseToJson(
        CreateComplaintResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_complaints_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyComplaintsResponse _$MyComplaintsResponseFromJson(
        Map<String, dynamic> json) =>
    MyComplaintsResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ComplaintModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyComplaintsResponseToJson(
        MyComplaintsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

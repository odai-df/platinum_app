// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_units_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUnitsResponse _$MyUnitsResponseFromJson(Map<String, dynamic> json) =>
    MyUnitsResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyUnitModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyUnitsResponseToJson(MyUnitsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

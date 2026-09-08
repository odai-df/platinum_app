// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solutions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolutionsResponseImpl _$$SolutionsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SolutionsResponseImpl(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => SolutionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SolutionsResponseImplToJson(
        _$SolutionsResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

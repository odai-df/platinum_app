// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solution_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolutionDetailsResponseImpl _$$SolutionDetailsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SolutionDetailsResponseImpl(
      status: json['status'] as String,
      message: json['message'] as String,
      data: SolutionDetailsModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SolutionDetailsResponseImplToJson(
        _$SolutionDetailsResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

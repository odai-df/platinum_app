// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractDetailsResponse _$ContractDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ContractDetailsResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ContractDetailsModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractDetailsResponseToJson(
        ContractDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

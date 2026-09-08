// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractClient _$ContractClientFromJson(Map<String, dynamic> json) =>
    ContractClient(
      account: json['account'] == null
          ? null
          : ContractAccount.fromJson(json['account'] as Map<String, dynamic>),
      additionalInfo: json['additional_info'] == null
          ? null
          : ContractAdditionalInfo.fromJson(
              json['additional_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractClientToJson(ContractClient instance) =>
    <String, dynamic>{
      'account': instance.account,
      'additional_info': instance.additionalInfo,
    };

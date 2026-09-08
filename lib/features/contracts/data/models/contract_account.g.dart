// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractAccount _$ContractAccountFromJson(Map<String, dynamic> json) =>
    ContractAccount(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$ContractAccountToJson(ContractAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };

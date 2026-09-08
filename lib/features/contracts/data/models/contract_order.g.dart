// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractOrder _$ContractOrderFromJson(Map<String, dynamic> json) =>
    ContractOrder(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ContractOrderToJson(ContractOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

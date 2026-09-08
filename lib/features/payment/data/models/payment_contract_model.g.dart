// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentContractModel _$PaymentContractModelFromJson(
        Map<String, dynamic> json) =>
    PaymentContractModel(
      contractId: (json['contract_id'] as num?)?.toInt(),
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaymentContractModelToJson(
        PaymentContractModel instance) =>
    <String, dynamic>{
      'contract_id': instance.contractId,
      'payments': instance.payments,
    };

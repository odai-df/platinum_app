// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractPayment _$ContractPaymentFromJson(Map<String, dynamic> json) =>
    ContractPayment(
      id: (json['id'] as num?)?.toInt(),
      employee: json['employee'] as String?,
      amount: json['amount'] as String?,
      paymentDate: json['payment_date'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentType: json['payment_type'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ContractPaymentToJson(ContractPayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee': instance.employee,
      'amount': instance.amount,
      'payment_date': instance.paymentDate,
      'payment_method': instance.paymentMethod,
      'payment_type': instance.paymentType,
      'status': instance.status,
      'created_at': instance.createdAt,
    };

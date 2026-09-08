// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_contract_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentContractDetailsModel _$PaymentContractDetailsModelFromJson(
        Map<String, dynamic> json) =>
    PaymentContractDetailsModel(
      id: (json['id'] as num?)?.toInt(),
      totalPrice: json['total_price'] as String?,
      downPaymentAmount: json['down_payment_amount'] as num?,
      installmentsCount: (json['installments_count'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$PaymentContractDetailsModelToJson(
        PaymentContractDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_price': instance.totalPrice,
      'down_payment_amount': instance.downPaymentAmount,
      'installments_count': instance.installmentsCount,
      'status': instance.status,
      'created_at': instance.createdAt,
    };

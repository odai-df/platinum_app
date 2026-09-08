// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractModel _$ContractModelFromJson(Map<String, dynamic> json) =>
    ContractModel(
      id: (json['id'] as num?)?.toInt(),
      order: json['order'] == null
          ? null
          : ContractOrder.fromJson(json['order'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : ContractClient.fromJson(json['client'] as Map<String, dynamic>),
      totalPrice: json['total_price'] as String?,
      downPaymentAmount: (json['down_payment_amount'] as num?)?.toDouble(),
      installmentsCount: (json['installments_count'] as num?)?.toInt(),
      payments: (json['payments'] as List<dynamic>?)
          ?.map((e) => ContractPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContractModelToJson(ContractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'client': instance.client,
      'total_price': instance.totalPrice,
      'down_payment_amount': instance.downPaymentAmount,
      'installments_count': instance.installmentsCount,
      'payments': instance.payments,
      'created_at': instance.createdAt,
      'attachments': instance.attachments,
    };

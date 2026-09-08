// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      id: (json['id'] as num?)?.toInt(),
      contract: json['contract'] == null
          ? null
          : PaymentContractDetailsModel.fromJson(
              json['contract'] as Map<String, dynamic>),
      employee: json['employee'] as String?,
      amount: json['amount'] as String?,
      paymentDate: json['payment_date'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentType: json['payment_type'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) =>
                  PaymentAttachmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contract': instance.contract,
      'employee': instance.employee,
      'amount': instance.amount,
      'payment_date': instance.paymentDate,
      'payment_method': instance.paymentMethod,
      'payment_type': instance.paymentType,
      'status': instance.status,
      'created_at': instance.createdAt,
      'attachments': instance.attachments,
    };

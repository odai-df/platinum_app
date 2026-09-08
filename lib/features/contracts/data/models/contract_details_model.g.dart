// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractDetailsModel _$ContractDetailsModelFromJson(
        Map<String, dynamic> json) =>
    ContractDetailsModel(
      id: (json['id'] as num?)?.toInt(),
      order: json['order'] == null
          ? null
          : ContractOrder.fromJson(json['order'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : ContractClient.fromJson(json['client'] as Map<String, dynamic>),
      employee: json['employee'] == null
          ? null
          : ContractEmployee.fromJson(json['employee'] as Map<String, dynamic>),
      totalPrice: json['total_price'] as String?,
      downPaymentAmount: json['down_payment_amount'] as num?,
      installmentsCount: (json['installments_count'] as num?)?.toInt(),
      status: json['status'] as String?,
      payments: (json['payments'] as List<dynamic>?)
          ?.map(
              (e) => ContractDetailsPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ContractDetailsModelToJson(
        ContractDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'client': instance.client,
      'employee': instance.employee,
      'total_price': instance.totalPrice,
      'down_payment_amount': instance.downPaymentAmount,
      'installments_count': instance.installmentsCount,
      'status': instance.status,
      'payments': instance.payments,
      'created_at': instance.createdAt,
    };

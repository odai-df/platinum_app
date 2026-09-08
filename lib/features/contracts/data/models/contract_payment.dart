import 'package:json_annotation/json_annotation.dart';

part 'contract_payment.g.dart';

@JsonSerializable()
class ContractPayment {
  final int? id;

  final String? employee;

  final String? amount;

  @JsonKey(name: 'payment_date')
  final String? paymentDate;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @JsonKey(name: 'payment_type')
  final String? paymentType;

  final String? status;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  ContractPayment({
    this.id,
    this.employee,
    this.amount,
    this.paymentDate,
    this.paymentMethod,
    this.paymentType,
    this.status,
    this.createdAt,
  });

  factory ContractPayment.fromJson(
      Map<String, dynamic> json) =>
      _$ContractPaymentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ContractPaymentToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'payment_contract_details_model.g.dart';

@JsonSerializable()
class PaymentContractDetailsModel {
  final int? id;

  @JsonKey(name: 'total_price')
  final String? totalPrice;

  @JsonKey(name: 'down_payment_amount')
  final num? downPaymentAmount;

  @JsonKey(name: 'installments_count')
  final int? installmentsCount;

  final String? status;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const PaymentContractDetailsModel({
    this.id,
    this.totalPrice,
    this.downPaymentAmount,
    this.installmentsCount,
    this.status,
    this.createdAt,
  });

  factory PaymentContractDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaymentContractDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentContractDetailsModelToJson(this);
}

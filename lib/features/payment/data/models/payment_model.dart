import 'package:json_annotation/json_annotation.dart';

import 'payment_attachment_model.dart';
import 'payment_contract_details_model.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  final int? id;

  final PaymentContractDetailsModel? contract;

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

  @JsonKey(defaultValue: [])
  final List<PaymentAttachmentModel>? attachments;

  const PaymentModel({
    this.id,
    this.contract,
    this.employee,
    this.amount,
    this.paymentDate,
    this.paymentMethod,
    this.paymentType,
    this.status,
    this.createdAt,
    this.attachments,
  });

  factory PaymentModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}

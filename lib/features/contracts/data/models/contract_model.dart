import 'package:json_annotation/json_annotation.dart';

import '../../../profile/data/models/profile_model.dart';
import '../../../units/data/models/attachment_model.dart';
import 'contract_client.dart';
import 'contract_order.dart';
import 'contract_payment.dart';

part 'contract_model.g.dart';

@JsonSerializable()
class ContractModel {
  final int? id;

  final ContractOrder? order;

  final ContractClient? client;

  @JsonKey(name: 'total_price')
  final String? totalPrice;

  @JsonKey(name: 'down_payment_amount')
  final double? downPaymentAmount;

  @JsonKey(name: 'installments_count')
  final int? installmentsCount;

  final List<ContractPayment>? payments;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  final List<AttachmentModel>? attachments;

  ContractModel({
    this.id,
    this.order,
    this.client,
    this.totalPrice,
    this.downPaymentAmount,
    this.installmentsCount,
    this.payments,
    this.createdAt,
    this.attachments,
  });

  factory ContractModel.fromJson(
      Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ContractModelToJson(this);
}
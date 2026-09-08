import 'package:json_annotation/json_annotation.dart';

import 'payment_model.dart';

part 'payment_contract_model.g.dart';

@JsonSerializable()
class PaymentContractModel {
  @JsonKey(name: 'contract_id')
  final int? contractId;

  @JsonKey(defaultValue: [])
  final List<PaymentModel>? payments;

  const PaymentContractModel({
    this.contractId,
    this.payments,
  });

  factory PaymentContractModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$PaymentContractModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentContractModelToJson(this);
}
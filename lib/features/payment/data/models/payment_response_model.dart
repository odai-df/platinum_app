import 'package:json_annotation/json_annotation.dart';

import 'payment_contract_model.dart';

part 'payment_response_model.g.dart';

@JsonSerializable()
class PaymentResponse {
  final String? status;
  final String? message;

  final List<PaymentContractModel>? data;

  const PaymentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PaymentResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentResponseToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

import 'contract_model.dart';

part 'contract_response.g.dart';

@JsonSerializable()
class ContractResponse {
  final String? status;
  final String? message;
  final List<ContractModel>? data;

  ContractResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ContractResponse.fromJson(
      Map<String, dynamic> json) =>
      _$ContractResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ContractResponseToJson(this);
}
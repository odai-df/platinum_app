import 'package:json_annotation/json_annotation.dart';

part 'contract_order.g.dart';

@JsonSerializable()
class ContractOrder {
  final int? id;

  final String? status;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  ContractOrder({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ContractOrder.fromJson(
      Map<String, dynamic> json) =>
      _$ContractOrderFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ContractOrderToJson(this);
}
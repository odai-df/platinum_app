import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/unit_model.dart';
import '../../../units/data/models/attachment_model.dart';

part 'my_unit_model.g.dart';

@JsonSerializable()
class MyUnitModel {
  final UnitModel unit;

  @JsonKey(name: 'purchase_price')
  final double? purchasePrice;

  final String? status;

  @JsonKey(name: 'owned_at')
  final String? ownedAt;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  final List<AttachmentModel>? attachments;

  const MyUnitModel({
    required this.unit,
    this.purchasePrice,
    this.status,
    this.ownedAt,
    this.createdAt,
    this.attachments,
  });

  factory MyUnitModel.fromJson(Map<String, dynamic> json) =>
      _$MyUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyUnitModelToJson(this);
}
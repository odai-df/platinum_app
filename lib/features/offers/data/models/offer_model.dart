import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/unit_model.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  final int? id;

  @JsonKey(name: 'item_type')
  final String? itemType;

  final UnitModel? item;

  @JsonKey(name: 'discount_percentage')
  final num? discountPercentage;

  @JsonKey(name: 'old_price')
  final num? oldPrice;

  @JsonKey(name: 'new_price')
  final num? newPrice;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const OfferModel({
    this.id,
    this.itemType,
    this.item,
    this.discountPercentage,
    this.oldPrice,
    this.newPrice,
    this.startDate,
    this.endDate,
    this.isActive,
    this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OfferModelToJson(this);
}
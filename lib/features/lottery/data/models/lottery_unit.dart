import 'package:json_annotation/json_annotation.dart';

part 'lottery_unit.g.dart';

@JsonSerializable()
class LotteryUnit {
  final int? id;

  @JsonKey(name: 'building_id')
  final int? buildingId;

  @JsonKey(name: 'unit_number')
  final String? unitNumber;

  final String? description;

  final String? type;

  final int? floor;

  final String? area;

  @JsonKey(name: 'rooms_count')
  final int? roomsCount;

  @JsonKey(name: 'original_price')
  final num? originalPrice;

  @JsonKey(name: 'current_price')
  final num? currentPrice;

  @JsonKey(name: 'has_active_offer')
  final bool? hasActiveOffer;

  @JsonKey(name: 'discount_percentage')
  final num? discountPercentage;

  final String? status;

  final dynamic location;

  final dynamic offer;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  const LotteryUnit({
    this.id,
    this.buildingId,
    this.unitNumber,
    this.description,
    this.type,
    this.floor,
    this.area,
    this.roomsCount,
    this.originalPrice,
    this.currentPrice,
    this.hasActiveOffer,
    this.discountPercentage,
    this.status,
    this.location,
    this.offer,
    this.createdAt,
    this.startDate,
    this.endDate,
  });

  factory LotteryUnit.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LotteryUnitFromJson(json);

  Map<String, dynamic> toJson() => _$LotteryUnitToJson(this);
}

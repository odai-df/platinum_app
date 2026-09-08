import 'package:json_annotation/json_annotation.dart';
import 'package:platinum_app/features/units/data/models/attachment_model.dart';

part 'unit_model.g.dart';

@JsonSerializable()
class UnitModel {
  final int id;

  @JsonKey(name: 'building_id')
  final int buildingId;

  @JsonKey(name: 'unit_number')
  final String unitNumber;

  final String? description;

  final String type;

  final int floor;

  final String area;

  @JsonKey(name: 'rooms_count')
  final int roomsCount;

  @JsonKey(name: 'original_price')
  final int originalPrice;

  @JsonKey(name: 'current_price')
  final int currentPrice;

  @JsonKey(name: 'has_active_offer')
  final bool hasActiveOffer;

  @JsonKey(name: 'discount_percentage')
  final int discountPercentage;

  final String status;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'is_favorite')
  final bool isFavorite;

  final List<AttachmentModel>? attachments;

  UnitModel({
    required this.id,
    required this.buildingId,
    required this.unitNumber,
    this.description,
    required this.type,
    required this.floor,
    required this.area,
    required this.roomsCount,
    required this.originalPrice,
    required this.currentPrice,
    required this.hasActiveOffer,
    required this.discountPercentage,
    required this.status,
    required this.createdAt,
    required this.isFavorite,
    this.attachments,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitModelToJson(this);

  UnitModel copyWith({
    int? id,
    int? buildingId,
    String? unitNumber,
    String? description,
    String? type,
    int? floor,
    String? area,
    int? roomsCount,
    int? originalPrice,
    int? currentPrice,
    bool? hasActiveOffer,
    int? discountPercentage,
    String? status,
    String? createdAt,
    bool? isFavorite,
    List<AttachmentModel>? attachments,
  }) {
    return UnitModel(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      unitNumber: unitNumber ?? this.unitNumber,
      description: description ?? this.description,
      type: type ?? this.type,
      floor: floor ?? this.floor,
      area: area ?? this.area,
      roomsCount: roomsCount ?? this.roomsCount,
      originalPrice: originalPrice ?? this.originalPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      hasActiveOffer: hasActiveOffer ?? this.hasActiveOffer,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      attachments: attachments ?? this.attachments,
    );
  }
}
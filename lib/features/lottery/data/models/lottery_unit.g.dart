// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryUnit _$LotteryUnitFromJson(Map<String, dynamic> json) => LotteryUnit(
      id: (json['id'] as num?)?.toInt(),
      buildingId: (json['building_id'] as num?)?.toInt(),
      unitNumber: json['unit_number'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      floor: (json['floor'] as num?)?.toInt(),
      area: json['area'] as String?,
      roomsCount: (json['rooms_count'] as num?)?.toInt(),
      originalPrice: json['original_price'] as num?,
      currentPrice: json['current_price'] as num?,
      hasActiveOffer: json['has_active_offer'] as bool?,
      discountPercentage: json['discount_percentage'] as num?,
      status: json['status'] as String?,
      location: json['location'],
      offer: json['offer'],
      createdAt: json['created_at'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$LotteryUnitToJson(LotteryUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'building_id': instance.buildingId,
      'unit_number': instance.unitNumber,
      'description': instance.description,
      'type': instance.type,
      'floor': instance.floor,
      'area': instance.area,
      'rooms_count': instance.roomsCount,
      'original_price': instance.originalPrice,
      'current_price': instance.currentPrice,
      'has_active_offer': instance.hasActiveOffer,
      'discount_percentage': instance.discountPercentage,
      'status': instance.status,
      'location': instance.location,
      'offer': instance.offer,
      'created_at': instance.createdAt,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };

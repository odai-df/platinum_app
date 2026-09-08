// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
      id: (json['id'] as num).toInt(),
      buildingId: (json['building_id'] as num).toInt(),
      unitNumber: json['unit_number'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      floor: (json['floor'] as num).toInt(),
      area: json['area'] as String,
      roomsCount: (json['rooms_count'] as num).toInt(),
      originalPrice: (json['original_price'] as num).toInt(),
      currentPrice: (json['current_price'] as num).toInt(),
      hasActiveOffer: json['has_active_offer'] as bool,
      discountPercentage: (json['discount_percentage'] as num).toInt(),
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      isFavorite: json['is_favorite'] as bool,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
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
      'created_at': instance.createdAt,
      'is_favorite': instance.isFavorite,
      'attachments': instance.attachments,
    };

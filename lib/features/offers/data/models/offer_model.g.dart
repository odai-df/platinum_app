// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: (json['id'] as num?)?.toInt(),
      itemType: json['item_type'] as String?,
      item: json['item'] == null
          ? null
          : UnitModel.fromJson(json['item'] as Map<String, dynamic>),
      discountPercentage: json['discount_percentage'] as num?,
      oldPrice: json['old_price'] as num?,
      newPrice: json['new_price'] as num?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_type': instance.itemType,
      'item': instance.item,
      'discount_percentage': instance.discountPercentage,
      'old_price': instance.oldPrice,
      'new_price': instance.newPrice,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };

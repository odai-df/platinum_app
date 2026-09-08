// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solution_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolutionDetailsModelImpl _$$SolutionDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SolutionDetailsModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      originalPrice: json['original_price'] as num,
      currentPrice: json['current_price'] as num,
      hasActiveOffer: json['has_active_offer'] as bool,
      discountPercentage: json['discount_percentage'] as num,
      createdAt: json['created_at'] as String,
      createdFrom: json['created_from'] as String,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SolutionDetailsModelImplToJson(
        _$SolutionDetailsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'original_price': instance.originalPrice,
      'current_price': instance.currentPrice,
      'has_active_offer': instance.hasActiveOffer,
      'discount_percentage': instance.discountPercentage,
      'created_at': instance.createdAt,
      'created_from': instance.createdFrom,
      'attachments': instance.attachments,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUnitModel _$MyUnitModelFromJson(Map<String, dynamic> json) => MyUnitModel(
      unit: UnitModel.fromJson(json['unit'] as Map<String, dynamic>),
      purchasePrice: (json['purchase_price'] as num?)?.toDouble(),
      status: json['status'] as String?,
      ownedAt: json['owned_at'] as String?,
      createdAt: json['created_at'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyUnitModelToJson(MyUnitModel instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'purchase_price': instance.purchasePrice,
      'status': instance.status,
      'owned_at': instance.ownedAt,
      'created_at': instance.createdAt,
      'attachments': instance.attachments,
    };

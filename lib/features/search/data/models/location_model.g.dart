// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'],
      type: json['type'] as String?,
      parentId: (json['parent_id'] as num?)?.toInt(),
      parent: json['parent'],
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'parent_id': instance.parentId,
      'parent': instance.parent,
      'created_at': instance.createdAt,
    };

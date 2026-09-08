// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      id: (json['id'] as num).toInt(),
      projectId: (json['project_id'] as num).toInt(),
      buildingNumber: json['building_number'] as String,
      coordinates: json['coordinates'] == null
          ? null
          : CoordinatesModel.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      description: json['description'] as String?,
      floorsCount: (json['floors_count'] as num).toInt(),
      locationId: (json['location_id'] as num?)?.toInt(),
      status: json['status'] as String,
      project: json['project'] == null
          ? null
          : ProjectModel.fromJson(json['project'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'building_number': instance.buildingNumber,
      'coordinates': instance.coordinates,
      'description': instance.description,
      'floors_count': instance.floorsCount,
      'location_id': instance.locationId,
      'status': instance.status,
      'project': instance.project,
      'attachments': instance.attachments,
    };

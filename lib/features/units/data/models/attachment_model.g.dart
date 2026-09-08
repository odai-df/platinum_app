// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'] as String,
      fileName: json['file_name'] as String,
      originalName: json['original_name'] as String,
      url: json['url'] as String,
      type: json['type'] as String,
      extension: json['extension'] as String,
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'file_name': instance.fileName,
      'original_name': instance.originalName,
      'url': instance.url,
      'type': instance.type,
      'extension': instance.extension,
    };

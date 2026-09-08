// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAttachmentModel _$PaymentAttachmentModelFromJson(
        Map<String, dynamic> json) =>
    PaymentAttachmentModel(
      id: (json['id'] as num?)?.toInt(),
      uuid: json['uuid'] as String?,
      fileName: json['file_name'] as String?,
      originalName: json['original_name'] as String?,
      mediableId: (json['mediable_id'] as num?)?.toInt(),
      mediableType: json['mediable_type'] as String?,
      url: json['url'] as String?,
      path: json['path'] as String?,
      type: json['type'] as String?,
      extension: json['extension'] as String?,
    );

Map<String, dynamic> _$PaymentAttachmentModelToJson(
        PaymentAttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'file_name': instance.fileName,
      'original_name': instance.originalName,
      'mediable_id': instance.mediableId,
      'mediable_type': instance.mediableType,
      'url': instance.url,
      'path': instance.path,
      'type': instance.type,
      'extension': instance.extension,
    };

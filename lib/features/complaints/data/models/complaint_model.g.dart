// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintModel _$ComplaintModelFromJson(Map<String, dynamic> json) =>
    ComplaintModel(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] == null
          ? null
          : ComplaintTypeModel.fromJson(json['type'] as Map<String, dynamic>),
      title: json['title'] as String?,
      body: json['body'] as String?,
      status: json['status'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ComplaintModelToJson(ComplaintModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'status': instance.status,
      'attachments': instance.attachments,
      'created_at': instance.createdAt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintTypeModel _$ComplaintTypeModelFromJson(Map<String, dynamic> json) =>
    ComplaintTypeModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] == null
          ? null
          : ComplaintTypeTitle.fromJson(json['title'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ComplaintTypeModelToJson(ComplaintTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.createdAt,
    };

ComplaintTypeTitle _$ComplaintTypeTitleFromJson(Map<String, dynamic> json) =>
    ComplaintTypeTitle(
      ar: json['ar'] as String?,
      en: json['en'] as String?,
    );

Map<String, dynamic> _$ComplaintTypeTitleToJson(ComplaintTypeTitle instance) =>
    <String, dynamic>{
      'ar': instance.ar,
      'en': instance.en,
    };

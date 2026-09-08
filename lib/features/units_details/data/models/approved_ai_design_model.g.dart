// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approved_ai_design_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovedAiDesignModel _$ApprovedAiDesignModelFromJson(
        Map<String, dynamic> json) =>
    ApprovedAiDesignModel(
      id: (json['id'] as num?)?.toInt(),
      uuid: json['uuid'] as String?,
      style: json['style'] as String?,
      prompt: json['prompt'] as String?,
      generatedImages: (json['generated_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mainImageUrl: json['main_image_url'] as String?,
      isPublished: json['is_published'] as bool?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ApprovedAiDesignModelToJson(
        ApprovedAiDesignModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'style': instance.style,
      'prompt': instance.prompt,
      'generated_images': instance.generatedImages,
      'main_image_url': instance.mainImageUrl,
      'is_published': instance.isPublished,
      'created_at': instance.createdAt,
    };

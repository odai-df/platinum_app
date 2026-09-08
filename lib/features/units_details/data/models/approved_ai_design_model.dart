import 'package:json_annotation/json_annotation.dart';

part 'approved_ai_design_model.g.dart';

@JsonSerializable()
class ApprovedAiDesignModel {
  final int? id;

  final String? uuid;

  final String? style;

  final String? prompt;

  @JsonKey(name: 'generated_images')
  final List<String>? generatedImages;

  @JsonKey(name: 'main_image_url')
  final String? mainImageUrl;

  @JsonKey(name: 'is_published')
  final bool? isPublished;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const ApprovedAiDesignModel({
    this.id,
    this.uuid,
    this.style,
    this.prompt,
    this.generatedImages,
    this.mainImageUrl,
    this.isPublished,
    this.createdAt,
  });

  factory ApprovedAiDesignModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ApprovedAiDesignModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovedAiDesignModelToJson(this);
}

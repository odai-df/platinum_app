import 'package:json_annotation/json_annotation.dart';

part 'attachment_model.g.dart';

@JsonSerializable()
class AttachmentModel {
  final int id;

  final String uuid;

  @JsonKey(name: 'file_name')
  final String fileName;

  @JsonKey(name: 'original_name')
  final String originalName;

  final String url;
  final String type;
  final String extension;

  AttachmentModel({
    required this.id,
    required this.uuid,
    required this.fileName,
    required this.originalName,
    required this.url,
    required this.type,
    required this.extension,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}
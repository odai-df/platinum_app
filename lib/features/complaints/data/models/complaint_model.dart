import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/attachment_model.dart';
import 'complaint_type_model.dart';

part 'complaint_model.g.dart';

@JsonSerializable()
class ComplaintModel {
  final int? id;

  final ComplaintTypeModel? type;

  final String? title;

  final String? body;

  final String? status;

  @JsonKey(defaultValue: [])
  final List<AttachmentModel>? attachments;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const ComplaintModel({
    this.id,
    this.type,
    this.title,
    this.body,
    this.status,
    this.attachments,
    this.createdAt,
  });

  factory ComplaintModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ComplaintModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComplaintModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'payment_attachment_model.g.dart';

@JsonSerializable()
class PaymentAttachmentModel {
  final int? id;
  final String? uuid;

  @JsonKey(name: 'file_name')
  final String? fileName;

  @JsonKey(name: 'original_name')
  final String? originalName;

  @JsonKey(name: 'mediable_id')
  final int? mediableId;

  @JsonKey(name: 'mediable_type')
  final String? mediableType;

  final String? url;
  final String? path;
  final String? type;
  final String? extension;

  const PaymentAttachmentModel({
    this.id,
    this.uuid,
    this.fileName,
    this.originalName,
    this.mediableId,
    this.mediableType,
    this.url,
    this.path,
    this.type,
    this.extension,
  });

  factory PaymentAttachmentModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$PaymentAttachmentModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentAttachmentModelToJson(this);
}
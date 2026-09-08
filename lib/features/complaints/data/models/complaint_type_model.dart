import 'package:json_annotation/json_annotation.dart';

part 'complaint_type_model.g.dart';

@JsonSerializable()
class ComplaintTypeModel {
  final int? id;

  final ComplaintTypeTitle? title;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const ComplaintTypeModel({
    this.id,
    this.title,
    this.createdAt,
  });

  factory ComplaintTypeModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ComplaintTypeModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComplaintTypeModelToJson(this);
}

@JsonSerializable()
class ComplaintTypeTitle {
  final String? ar;
  final String? en;

  const ComplaintTypeTitle({
    this.ar,
    this.en,
  });

  factory ComplaintTypeTitle.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ComplaintTypeTitleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComplaintTypeTitleToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  final int? id;

  final dynamic name;

  final String? type;

  @JsonKey(name: "parent_id")
  final int? parentId;

  final dynamic parent;

  @JsonKey(name: "created_at")
  final String? createdAt;

  LocationModel({
    this.id,
    this.name,
    this.type,
    this.parentId,
    this.parent,
    this.createdAt,
  });

  factory LocationModel.fromJson(
      Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocationModelToJson(this);

  String get displayName {
    if (name is String) {
      return name;
    }

    if (name is List && (name as List).isNotEmpty) {
      final first = (name as List).first;

      if (first is Map<String, dynamic>) {
        return first.values.first.toString();
      }
    }

    return "";
  }
}
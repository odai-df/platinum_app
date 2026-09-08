import 'package:json_annotation/json_annotation.dart';

import 'coordinates_model.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel {
  final int id;

  final String name;

  final String? description;

  final CoordinatesModel? coordinates;

  final String status;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  ProjectModel({
    required this.id,
    required this.name,
    this.description,
    this.coordinates,
    required this.status,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  factory ProjectModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}

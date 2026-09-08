import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/attachment_model.dart';
import 'coordinates_model.dart';
import 'project_model.dart';

part 'building_model.g.dart';

@JsonSerializable()
class BuildingModel {
  final int id;

  @JsonKey(name: 'project_id')
  final int projectId;

  @JsonKey(name: 'building_number')
  final String buildingNumber;

  final CoordinatesModel? coordinates;

  final String? description;

  @JsonKey(name: 'floors_count')
  final int floorsCount;

  @JsonKey(name: 'location_id')
  final int? locationId;

  final String status;

  final ProjectModel? project;

  final List<AttachmentModel> attachments;

  BuildingModel({
    required this.id,
    required this.projectId,
    required this.buildingNumber,
    this.coordinates,
    this.description,
    required this.floorsCount,
    this.locationId,
    required this.status,
    this.project,
    required this.attachments,
  });

  factory BuildingModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BuildingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);
}

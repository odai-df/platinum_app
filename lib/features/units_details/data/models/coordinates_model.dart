import 'package:json_annotation/json_annotation.dart';

part 'coordinates_model.g.dart';

@JsonSerializable()
class CoordinatesModel {
  final double latitude;
  final double longitude;
  final double radius;

  CoordinatesModel({
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}
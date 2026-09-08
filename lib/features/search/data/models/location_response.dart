import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';

part 'location_response.g.dart';

@JsonSerializable()
class LocationResponse {
  final String? status;

  final String? message;

  final List<LocationModel>? data;

  LocationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LocationResponse.fromJson(
      Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocationResponseToJson(this);
}
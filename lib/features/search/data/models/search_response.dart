import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/unit_model.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  final String? status;
  final String? message;

  final List<UnitModel>? data;

  SearchResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SearchResponse.fromJson(
      Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SearchResponseToJson(this);
}
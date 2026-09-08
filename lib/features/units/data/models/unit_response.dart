import 'package:json_annotation/json_annotation.dart';
import 'meta.dart';
import 'unit_model.dart';

part 'unit_response.g.dart';

@JsonSerializable()
class UnitsResponse {
  final List<UnitModel> data;
  final Meta meta;

  UnitsResponse({
    required this.data,
    required this.meta,
  });

  factory UnitsResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnitsResponseToJson(this);
}
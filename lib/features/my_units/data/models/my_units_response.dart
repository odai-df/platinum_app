import 'package:json_annotation/json_annotation.dart';

import 'my_unit_model.dart';

part 'my_units_response.g.dart';

@JsonSerializable()
class MyUnitsResponse {
  final String? status;
  final String? message;
  final List<MyUnitModel>? data;

  const MyUnitsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory MyUnitsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyUnitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyUnitsResponseToJson(this);
}

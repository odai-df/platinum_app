import 'package:json_annotation/json_annotation.dart';
import 'package:platinum_app/features/units_details/data/models/unit_detail_model.dart';

part 'unit_detail_response.g.dart';

@JsonSerializable()
class UnitDetailResponse {
  final String status;
  final String message;
  final UnitDetailModel data;

  UnitDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UnitDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnitDetailResponseToJson(this);
}
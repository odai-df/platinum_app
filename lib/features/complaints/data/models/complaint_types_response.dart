import 'package:json_annotation/json_annotation.dart';

import 'complaint_type_model.dart';

part 'complaint_types_response.g.dart';

@JsonSerializable()
class ComplaintTypesResponse {
  final String? status;
  final String? message;
  final List<ComplaintTypeModel>? data;

  const ComplaintTypesResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ComplaintTypesResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ComplaintTypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintTypesResponseToJson(this);
}

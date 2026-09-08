import 'package:json_annotation/json_annotation.dart';

import 'complaint_model.dart';

part 'my_complaints_response.g.dart';

@JsonSerializable()
class MyComplaintsResponse {
  final String? status;

  final String? message;

  final List<ComplaintModel>? data;

  const MyComplaintsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory MyComplaintsResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$MyComplaintsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MyComplaintsResponseToJson(this);
}
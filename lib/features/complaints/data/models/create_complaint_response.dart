import 'package:json_annotation/json_annotation.dart';

part 'create_complaint_response.g.dart';

@JsonSerializable()
class CreateComplaintResponse {
  final String? status;
  final String? message;
  final List<dynamic>? data;

  const CreateComplaintResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CreateComplaintResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CreateComplaintResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateComplaintResponseToJson(this);
}
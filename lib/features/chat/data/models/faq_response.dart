import 'package:json_annotation/json_annotation.dart';

import 'faq_model.dart';

part 'faq_response.g.dart';

@JsonSerializable()
class FaqResponse {
  final String? status;
  final String? message;
  final List<FaqModel>? data;

  FaqResponse({
    this.status,
    this.message,
    this.data,
  });

  factory FaqResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$FaqResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FaqResponseToJson(this);
}
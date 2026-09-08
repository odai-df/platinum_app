import 'package:json_annotation/json_annotation.dart';

import 'lottery_model.dart';

part 'lottery_response.g.dart';

@JsonSerializable()
class LotteryResponse {
  final String? status;
  final String? message;
  final List<LotteryModel>? data;

  LotteryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LotteryResponse.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryResponseToJson(this);
}
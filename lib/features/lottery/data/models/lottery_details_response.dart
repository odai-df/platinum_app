import 'package:json_annotation/json_annotation.dart';

import 'lottery_model.dart';

part 'lottery_details_response.g.dart';

@JsonSerializable()
class LotteryDetailsResponse {
  final String? status;
  final String? message;
  final LotteryModel? data;

  LotteryDetailsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LotteryDetailsResponse.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryDetailsResponseToJson(this);
}
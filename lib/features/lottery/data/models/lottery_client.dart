import 'package:json_annotation/json_annotation.dart';

import 'lottery_account.dart';
import 'lottery_additional_info.dart';

part 'lottery_client.g.dart';

@JsonSerializable()
class LotteryClient {
  final LotteryAccount? account;

  @JsonKey(name: "additional_info")
  final LotteryAdditionalInfo? additionalInfo;

  LotteryClient({
    this.account,
    this.additionalInfo,
  });

  factory LotteryClient.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryClientFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryClientToJson(this);
}
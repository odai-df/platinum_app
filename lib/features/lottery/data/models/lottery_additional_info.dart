import 'package:json_annotation/json_annotation.dart';

part 'lottery_additional_info.g.dart';

@JsonSerializable()
class LotteryAdditionalInfo {
  @JsonKey(name: "client_id")
  final int? clientId;

  @JsonKey(name: "birth_date")
  final String? birthDate;

  @JsonKey(name: "job_title")
  final String? jobTitle;

  @JsonKey(name: "social_status")
  final String? socialStatus;

  @JsonKey(name: "national_id")
  final String? nationalId;

  LotteryAdditionalInfo({
    this.clientId,
    this.birthDate,
    this.jobTitle,
    this.socialStatus,
    this.nationalId,
  });

  factory LotteryAdditionalInfo.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryAdditionalInfoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryAdditionalInfoToJson(this);
}
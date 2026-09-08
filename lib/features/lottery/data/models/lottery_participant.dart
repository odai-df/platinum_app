import 'package:json_annotation/json_annotation.dart';

import 'lottery_client.dart';

part 'lottery_participant.g.dart';

@JsonSerializable()
class LotteryParticipant {
  final int? id;

  final LotteryClient? client;

  @JsonKey(name: "entry_date")
  final String? entryDate;

  @JsonKey(name: "is_winner")
  final bool? isWinner;

  @JsonKey(name: "created_at")
  final String? createdAt;

  LotteryParticipant({
    this.id,
    this.client,
    this.entryDate,
    this.isWinner,
    this.createdAt,
  });

  factory LotteryParticipant.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryParticipantFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryParticipantToJson(this);
}
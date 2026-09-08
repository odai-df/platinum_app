import 'package:json_annotation/json_annotation.dart';

import 'lottery_rule.dart';
import 'lottery_unit.dart';
import 'lottery_participant.dart';

part 'lottery_model.g.dart';

@JsonSerializable()
class LotteryModel {
  final int? id;

  final String? title;

  final String? status;

  final LotteryUnit? unit;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: "participants")
  final List<LotteryParticipant>? participants;

  final List<LotteryRule>? rules;

  LotteryModel({
    this.id,
    this.title,
    this.status,
    this.unit,
    this.createdAt,
    this.rules,
    this.participants
  });

  factory LotteryModel.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'lottery_rule.g.dart';

@JsonSerializable()
class LotteryRule {
  final int? id;

  @JsonKey(name: 'rule_key')
  final String? ruleKey;

  final String? operator;

  @JsonKey(name: 'rule_value')
  final String? ruleValue;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  LotteryRule({
    this.id,
    this.ruleKey,
    this.operator,
    this.ruleValue,
    this.createdAt,
  });

  factory LotteryRule.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryRuleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryRuleToJson(this);
}
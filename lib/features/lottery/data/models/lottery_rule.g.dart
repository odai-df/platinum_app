// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryRule _$LotteryRuleFromJson(Map<String, dynamic> json) => LotteryRule(
      id: (json['id'] as num?)?.toInt(),
      ruleKey: json['rule_key'] as String?,
      operator: json['operator'] as String?,
      ruleValue: json['rule_value'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$LotteryRuleToJson(LotteryRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rule_key': instance.ruleKey,
      'operator': instance.operator,
      'rule_value': instance.ruleValue,
      'created_at': instance.createdAt,
    };

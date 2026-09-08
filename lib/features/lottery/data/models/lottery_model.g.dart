// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryModel _$LotteryModelFromJson(Map<String, dynamic> json) => LotteryModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      status: json['status'] as String?,
      unit: json['unit'] == null
          ? null
          : LotteryUnit.fromJson(json['unit'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      rules: (json['rules'] as List<dynamic>?)
          ?.map((e) => LotteryRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => LotteryParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LotteryModelToJson(LotteryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'unit': instance.unit,
      'created_at': instance.createdAt,
      'participants': instance.participants,
      'rules': instance.rules,
    };

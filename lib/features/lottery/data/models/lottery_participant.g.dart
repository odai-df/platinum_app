// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryParticipant _$LotteryParticipantFromJson(Map<String, dynamic> json) =>
    LotteryParticipant(
      id: (json['id'] as num?)?.toInt(),
      client: json['client'] == null
          ? null
          : LotteryClient.fromJson(json['client'] as Map<String, dynamic>),
      entryDate: json['entry_date'] as String?,
      isWinner: json['is_winner'] as bool?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$LotteryParticipantToJson(LotteryParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'entry_date': instance.entryDate,
      'is_winner': instance.isWinner,
      'created_at': instance.createdAt,
    };

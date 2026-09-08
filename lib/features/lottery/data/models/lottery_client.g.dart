// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryClient _$LotteryClientFromJson(Map<String, dynamic> json) =>
    LotteryClient(
      account: json['account'] == null
          ? null
          : LotteryAccount.fromJson(json['account'] as Map<String, dynamic>),
      additionalInfo: json['additional_info'] == null
          ? null
          : LotteryAdditionalInfo.fromJson(
              json['additional_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LotteryClientToJson(LotteryClient instance) =>
    <String, dynamic>{
      'account': instance.account,
      'additional_info': instance.additionalInfo,
    };

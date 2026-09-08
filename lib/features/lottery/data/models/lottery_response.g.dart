// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryResponse _$LotteryResponseFromJson(Map<String, dynamic> json) =>
    LotteryResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LotteryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LotteryResponseToJson(LotteryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

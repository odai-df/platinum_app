// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryDetailsResponse _$LotteryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    LotteryDetailsResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LotteryModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LotteryDetailsResponseToJson(
        LotteryDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

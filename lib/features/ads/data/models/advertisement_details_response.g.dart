// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementDetailsResponse _$AdvertisementDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    AdvertisementDetailsResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: AdvertisementDetailsModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvertisementDetailsResponseToJson(
        AdvertisementDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisements_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementsResponse _$AdvertisementsResponseFromJson(
        Map<String, dynamic> json) =>
    AdvertisementsResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => AdvertisementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvertisementsResponseToJson(
        AdvertisementsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

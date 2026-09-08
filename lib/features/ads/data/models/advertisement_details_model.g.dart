// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementDetailsModel _$AdvertisementDetailsModelFromJson(
        Map<String, dynamic> json) =>
    AdvertisementDetailsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      startsAt: json['starts_at'] as String,
      endsAt: json['ends_at'] as String,
      durationDays: (json['duration_days'] as num).toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      offer: json['offer'] == null
          ? null
          : OfferModel.fromJson(json['offer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvertisementDetailsModelToJson(
        AdvertisementDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'duration_days': instance.durationDays,
      'attachments': instance.attachments,
      'offer': instance.offer,
    };

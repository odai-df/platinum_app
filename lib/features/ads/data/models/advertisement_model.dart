import 'package:json_annotation/json_annotation.dart';

import 'attachment_model.dart';
import 'offer_model.dart';

part 'advertisement_model.g.dart';

@JsonSerializable()
class AdvertisementModel {
  final int id;

  final String title;

  final String description;

  @JsonKey(name: 'starts_at')
  final String startsAt;

  @JsonKey(name: 'ends_at')
  final String endsAt;

  @JsonKey(name: 'duration_days')
  final int durationDays;

  @JsonKey(
    name: 'is_active',
    fromJson: _boolFromDynamic,
  )
  final bool isActive;

  @JsonKey(defaultValue: [])
  final List<OfferModel> offers;

  @JsonKey(defaultValue: [])
  final List<AttachmentModel> attachments;

  static bool _boolFromDynamic(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == "true";
    if (value is int) return value == 1;
    return false;
  }

  AdvertisementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    required this.durationDays,
    required this.isActive,
    required this.offers,
    required this.attachments,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdvertisementModelToJson(this);
}
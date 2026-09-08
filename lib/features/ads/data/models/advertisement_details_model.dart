import 'package:json_annotation/json_annotation.dart';

import 'attachment_model.dart';
import 'offer_model.dart';

part 'advertisement_details_model.g.dart';

@JsonSerializable()
class AdvertisementDetailsModel {
  final int id;

  final String title;

  final String description;


  @JsonKey(name: 'starts_at')
  final String startsAt;

  @JsonKey(name: 'ends_at')
  final String endsAt;

  @JsonKey(name: 'duration_days')
  final int durationDays;

  @JsonKey(defaultValue: [])
  final List<AttachmentModel> attachments;

  final OfferModel? offer;



  const AdvertisementDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    required this.durationDays,
    required this.attachments,
    required this.offer,

  });

  factory AdvertisementDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AdvertisementDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisementDetailsModelToJson(this);
}

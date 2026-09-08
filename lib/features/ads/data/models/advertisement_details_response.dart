import 'package:json_annotation/json_annotation.dart';

import 'advertisement_details_model.dart';

part 'advertisement_details_response.g.dart';

@JsonSerializable()
class AdvertisementDetailsResponse {
  final String status;

  final String message;

  final AdvertisementDetailsModel data;

  const AdvertisementDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AdvertisementDetailsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AdvertisementDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisementDetailsResponseToJson(this);
}

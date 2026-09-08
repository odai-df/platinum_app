import 'package:json_annotation/json_annotation.dart';
import 'advertisement_model.dart';

part 'advertisements_response.g.dart';

@JsonSerializable()
class AdvertisementsResponse {
  final String status;
  final String message;
  final List<AdvertisementModel> data;

  AdvertisementsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AdvertisementsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdvertisementsResponseToJson(this);
}
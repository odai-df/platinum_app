import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/meta.dart';
import 'offer_model.dart';


part 'offers_response.g.dart';

@JsonSerializable()
class OffersResponse {
  final String? status;

  final String? message;

  final List<OfferModel>? data;

  // final PaginationLinks? links;
  //
  // final Meta? meta;

  const OffersResponse({
    this.status,
    this.message,
    this.data,
    // this.links,
    // this.meta,
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) =>
      _$OffersResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OffersResponseToJson(this);
}
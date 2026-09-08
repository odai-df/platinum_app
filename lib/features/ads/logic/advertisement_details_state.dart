import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/advertisement_details_model.dart';

part 'advertisement_details_state.freezed.dart';

@freezed
class AdvertisementDetailsState with _$AdvertisementDetailsState {
  const factory AdvertisementDetailsState.initial() = _Initial;

  const factory AdvertisementDetailsState.loading() = _Loading;

  const factory AdvertisementDetailsState.success(
    AdvertisementDetailsModel data,
  ) = _Success;

  const factory AdvertisementDetailsState.error(
    String message,
  ) = _Error;
}

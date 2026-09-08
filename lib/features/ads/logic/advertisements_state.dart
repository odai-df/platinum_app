import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/advertisement_model.dart';

part 'advertisements_state.freezed.dart';

@freezed
class AdvertisementsState with _$AdvertisementsState {
  const factory AdvertisementsState.initial() = _Initial;

  const factory AdvertisementsState.loading() = _Loading;

  const factory AdvertisementsState.success(
      List<AdvertisementModel> ads,
      ) = _Success;

  const factory AdvertisementsState.error(
      String message,
      ) = _Error;
}
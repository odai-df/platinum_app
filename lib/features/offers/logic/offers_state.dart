import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/offer_model.dart';

part 'offers_state.freezed.dart';

@freezed
class OffersState with _$OffersState {
  const factory OffersState.initial() = _Initial;

  const factory OffersState.loading() = OffersLoading;

  const factory OffersState.success(
    List<OfferModel> offers,
  ) = OffersSuccess;

  const factory OffersState.error(
    String message,
  ) = OffersError;
}

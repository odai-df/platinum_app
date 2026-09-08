import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/favorite_model.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState with _$FavoriteState {

  const factory FavoriteState.initial() = _Initial;

  const factory FavoriteState.loading() = _Loading;

  const factory FavoriteState.success() = _Success;

  const factory FavoriteState.error(String error) = _Error;

  const factory FavoriteState.loaded(
      List<FavoriteModel> favorites,
      ) = _Loaded;
}
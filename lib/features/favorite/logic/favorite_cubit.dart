import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/favorite_model.dart';
import '../data/repos/favorite_repo.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {

  final FavoriteRepo repo;
  List<FavoriteModel> favorites = [];

  FavoriteCubit(this.repo)
      : super(const FavoriteState.initial());

  /// GET FAVORITES
  Future<void> getFavorites() async {
    emit(const FavoriteState.loading());

    try {
      final data = await repo.getMyFavorites();

      favorites = data;

      emit(FavoriteState.loaded(List.from(favorites)));
    } catch (e) {
      emit(FavoriteState.error(e.toString()));
    }
  }

  /// ADD FAVORITE (optimistic)
  Future<void> toggleFavorite(int unitId) async {
    try {
      await repo.toggleFavorite(unitId);

      // 🔥 add locally instead of refetch
      // optional: if backend returns unit, add it here

      // await getFavorites(); // 👈 خليها فقط إذا لازم sync كامل

    } catch (e) {
      emit(FavoriteState.error(e.toString()));
    }
  }

  /// REMOVE FAVORITE (optimized)
  Future<void> removeFavorite(int unitId) async {
    try {
      await repo.removeFavorite(unitId);

      favorites.removeWhere((e) => e.unit.id == unitId);

      emit(FavoriteState.loaded(List.from(favorites)));
    } catch (e) {
      // لا emit error
      debugPrint(e.toString());

      // مهم: ارجع error للـ UI بطريقة واضحة
      throw Exception("REMOVE_FAILED");
    }
  }
}
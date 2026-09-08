import '../../../../core/networking/api_service.dart';
import '../models/favorite_model.dart';

class FavoriteRepo {
  final ApiService api;

  FavoriteRepo(this.api);

  Future<void> toggleFavorite(int unitId) async {
    await api.toggleFavorite(unitId);
  }

  Future<void> removeFavorite(int unitId) async {
    await api.deleteFavorite(unitId);
  }

  Future<List<FavoriteModel>> getMyFavorites() async {

    final response = await api.getMyFavorites();

    return response.data;
  }
}
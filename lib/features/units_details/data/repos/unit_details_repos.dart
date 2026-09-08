import '../../../../core/networking/api_service.dart';
import '../models/unit_detail_model.dart';

abstract class UnitDetailRepo {
  Future<UnitDetailModel> getUnitDetails(int id);
}

class UnitDetailRepoImpl implements UnitDetailRepo {
  final ApiService api;

  UnitDetailRepoImpl(this.api);

  @override
  Future<UnitDetailModel> getUnitDetails(int id) async {
    final response = await api.getUnitDetails(id);
    return response.data;
  }
}
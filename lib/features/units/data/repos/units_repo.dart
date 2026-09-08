import '../../../../core/networking/api_service.dart';
import '../models/unit_response.dart';




class UnitsRepo {
  final ApiService apiService;

  UnitsRepo(this.apiService);

  Future<UnitsResponse> getUnits({required int page}) {
    return apiService.getUnits(page);
  }




}
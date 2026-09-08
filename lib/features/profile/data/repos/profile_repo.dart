import 'package:platinum_app/core/networking/api_error_handler.dart';
import 'package:platinum_app/core/networking/api_result.dart';
import 'package:platinum_app/core/networking/api_service.dart';
import 'package:platinum_app/features/profile/data/models/profile_model.dart';

import '../models/edit_profile_request.dart';
import '../models/edit_profile_response.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  Future<ApiResult<ProfileModel>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }


  Future<ApiResult<EditProfileResponse>> editProfile(
      EditProfileRequest request,
      ) async {
    try {
      final response =
      await _apiService.editProfile(request.toMap());

      return ApiResult.success(response);

    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

}
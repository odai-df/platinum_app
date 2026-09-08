import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

import '../models/sign_up_request_body.dart';
import '../models/sign_up_response.dart';

class SignupRepo {
  final Dio _dio;

  SignupRepo(this._dio);

  Future<ApiResult<SignupResponse>> signup(SignupRequestBody body,
      {File? photo}) async {
    try {
      final formData = FormData.fromMap({
        ...body.toJson(),
        if (photo != null) 'photo': await MultipartFile.fromFile(photo.path),
      });
      print("Signup Request Body: ${formData.fields}");
      print("Signup Request Files: ${formData.files}");
      final response = await _dio.post(
        '${ApiConstants.apiBaseUrl}/client',
        data: formData,
      );

      return ApiResult.success(SignupResponse.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}

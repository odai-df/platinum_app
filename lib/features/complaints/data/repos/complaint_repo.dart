import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

import '../models/complaint_model.dart';
import '../models/complaint_type_model.dart';
import '../models/create_complaint_response.dart';

class ComplaintRepo {
  final ApiService _apiService;

  ComplaintRepo(this._apiService);

  Future<ApiResult<List<ComplaintModel>>> getMyComplaints() async {
    try {
      final response = await _apiService.getMyComplaints();

      return ApiResult.success(
        response.data ?? [],
      );
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }

  Future<ApiResult<List<ComplaintTypeModel>>> getComplaintTypes() async {
    try {
      final response = await _apiService.getComplaintTypes();

      return ApiResult.success(
        response.data ?? [],
      );
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }

  Future<ApiResult<CreateComplaintResponse>> createComplaint({
    required int complaintTypeId,
    required String title,
    required String body,
    required int unitId,
    required List<File> attachments,
  }) async {
    try {
      final formData = FormData();

      formData.fields.addAll([
        MapEntry(
          'complaint_type_id',
          complaintTypeId.toString(),
        ),
        MapEntry(
          'title',
          title,
        ),
        MapEntry(
          'body',
          body,
        ),
        MapEntry(
          'unit_id',
          unitId.toString(),
        ),
      ]);

      for (final file in attachments) {
        final fileName = file.path.split('/').last;

        formData.files.add(
          MapEntry(
            'attachments[]',
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          ),
        );
      }

      final response = await _apiService.createComplaint(
        formData,
      );

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }

}

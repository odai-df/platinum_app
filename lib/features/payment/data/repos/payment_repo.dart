import 'dart:io';

import 'package:dio/dio.dart';
import 'package:platinum_app/core/networking/api_error_handler.dart';
import 'package:platinum_app/core/networking/api_result.dart';
import 'package:platinum_app/core/networking/api_service.dart';

import '../models/payment_contract_model.dart';
import '../models/payment_upload_response.dart';

class PaymentRepo {
  final ApiService _apiService;

  PaymentRepo(this._apiService);

  Future<ApiResult<List<PaymentContractModel>>> getPayments() async {
    try {
      final response = await _apiService.getPayments();

      return ApiResult.success(
        response.data ?? [],
      );
    } catch (e, stack) {
      print("🔥 PAYMENT ERROR:");
      print(e);
      print(stack);

      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }



  Future<ApiResult<PaymentUploadData>> uploadPaymentFiles({
    required int paymentId,
    required List<File> files,
  }) async {
    try {
      if (files.isEmpty) {
        return ApiResult.failure(
          ErrorHandler.handle(
            Exception('No files selected'),
          ),
        );
      }

      final formData = FormData();

      for (int i = 0; i < files.length; i++) {
        final file = files[i];

        formData.files.add(
          MapEntry(
            'attachments[$i]',
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split(Platform.pathSeparator).last,
            ),
          ),
        );
      }

      final response = await _apiService.uploadPaymentFiles(
        paymentId,
        formData,
      );

      final data = response.data;

      if (data == null) {
        return ApiResult.failure(
          ErrorHandler.handle(
            Exception(
              response.message ?? 'Upload failed',
            ),
          ),
        );
      }

      return ApiResult.success(data);
    } catch (error, stackTrace) {
      print('🔥 UPLOAD PAYMENT FILES ERROR');
      print(error);
      print(stackTrace);

      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }


}
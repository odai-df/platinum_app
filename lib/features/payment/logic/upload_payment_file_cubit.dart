import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/payment_repo.dart';
import 'upload_payment_file_state.dart';

class UploadPaymentFileCubit
    extends Cubit<UploadPaymentFileState> {
  final PaymentRepo _repo;

  UploadPaymentFileCubit(this._repo)
      : super(const UploadPaymentFileState.initial());

  Future<void> uploadFiles({
    required int paymentId,
    required List<File> files,
  }) async {
    if (files.isEmpty) {
      emit(
        UploadPaymentFileState.error(
          paymentId,
          'Please select at least one file',
        ),
      );
      return;
    }

    emit(
      UploadPaymentFileState.loading(paymentId),
    );

    final result = await _repo.uploadPaymentFiles(
      paymentId: paymentId,
      files: files,
    );

    result.when(
      success: (data) {
        emit(
          UploadPaymentFileState.success(
            paymentId,
            data,
          ),
        );
      },
      failure: (error) {
        emit(
          UploadPaymentFileState.error(
            paymentId,
            error.apiErrorModel.message ??
                'Failed to upload payment files',
          ),
        );
      },
    );
  }
}
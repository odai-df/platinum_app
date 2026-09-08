import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/payment_upload_response.dart';

part 'upload_payment_file_state.freezed.dart';

@freezed
class UploadPaymentFileState with _$UploadPaymentFileState {
  const factory UploadPaymentFileState.initial() = UploadPaymentFileInitial;

  const factory UploadPaymentFileState.loading(
    int paymentId,
  ) = UploadPaymentFileLoading;

  const factory UploadPaymentFileState.success(
    int paymentId,
    PaymentUploadData data,
  ) = UploadPaymentFileSuccess;

  const factory UploadPaymentFileState.error(
    int paymentId,
    String message,
  ) = UploadPaymentFileError;
}

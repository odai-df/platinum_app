import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/payment_contract_model.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = PaymentInitial;

  const factory PaymentState.loading() = PaymentLoading;

  const factory PaymentState.success(
      List<PaymentContractModel> payments,
      ) = PaymentSuccess;

  const factory PaymentState.error(
      String message,
      ) = PaymentError;
}
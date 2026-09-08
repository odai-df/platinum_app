import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/payment_contract_model.dart';
import '../data/repos/payment_repo.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  PaymentCubit(this.paymentRepo) : super(const PaymentInitial());

  List<PaymentContractModel> payments = [];

  Future<void> getPayments() async {
    emit(const PaymentLoading());

    final result = await paymentRepo.getPayments();

    result.when(
      success: (data) {
        payments = data;
        emit(PaymentSuccess(data));
      },
      failure: (error) {
        emit(
          PaymentError(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }
}
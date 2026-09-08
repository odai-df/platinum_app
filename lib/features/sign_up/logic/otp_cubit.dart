import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';
import '../data/repos/otp_repo.dart';
import '../data/models/otp_request_body.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepo otpRepo;

  OtpCubit(this.otpRepo) : super(OtpInitial());

  Future<void> verifyOtp(String code, String email) async {
    emit(OtpLoading());

    try {
      final response = await otpRepo.verifyOtp(
        OtpRequestBody(code: code, email: email),
      );

      if (response.data == true) {
        emit(OtpSuccess(response.message ?? "OTP Verified"));
      } else {
        emit(OtpError(response.message ?? 'حدث خطأ'));
      }
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }

  Future<void> resendCode(String email) async {
    emit(OtpLoading());

    try {
      final message = await otpRepo.resendCode(email);
      emit(OtpResent(message));
    } catch (e) {
      emit(OtpError('Failed to resend code: $e'));
    }
  }
}
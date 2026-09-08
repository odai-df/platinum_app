import '../../../../core/networking/api_service.dart';
import '../models/otp_request_body.dart';
import '../models/otp_response.dart';

class OtpRepo {
  final ApiService apiService;
  OtpRepo(this.apiService);

  Future<OtpResponse> verifyOtp(OtpRequestBody body) async {
    return await apiService.verifyOtp(body);
  }



  Future<String> resendCode(String email) async {
    final response = await apiService.sendCode({'email': email});
    print(response);

    return response['message'] ?? 'Code sent successfully';
  }
}

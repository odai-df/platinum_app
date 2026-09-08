class OtpRequestBody {
  final String code;
  final String email;

  OtpRequestBody({required this.code, required this.email});

  Map<String, dynamic> toJson() => {
    'code': code,
    'email': email,
  };
}

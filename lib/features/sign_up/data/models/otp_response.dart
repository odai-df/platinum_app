class OtpResponse {
  final String? status;
  final String? message;
  final bool? data;

  OtpResponse({
    this.status,
    this.message,
    this.data,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
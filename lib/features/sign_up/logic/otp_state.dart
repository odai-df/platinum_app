abstract class OtpState  {
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String token;

  OtpSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class OtpError extends OtpState {
  final String message;

  OtpError(this.message);

  @override
  List<Object?> get props => [message];
}

class OtpResent extends OtpState {
  final String message;

  OtpResent(this.message);

  @override
  List<Object?> get props => [message];
}

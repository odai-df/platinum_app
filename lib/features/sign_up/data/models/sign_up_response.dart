import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignupResponse {
  String? status;
  String? message;
  SignupData? data;

  SignupResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SignupResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

@JsonSerializable()
class SignupData {
  SignupUser? user;

  int? otp;

  SignupData({
    this.user,
    this.otp,
  });

  factory SignupData.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SignupDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignupDataToJson(this);
}

@JsonSerializable()
class SignupUser {
  Account? account;

  SignupUser({this.account});

  factory SignupUser.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SignupUserFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserToJson(this);
}

@JsonSerializable()
class Account {
  int? id;

  @JsonKey(name: 'full_name')
  String? fullName;

  String? email;

  String? phone;

  String? type;

  String? address;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'created_from')
  String? createdFrom;

  @JsonKey(name: 'verified_at')
  String? verifiedAt;

  List<String>? roles;

  Account({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.type,
    this.address,
    this.createdAt,
    this.createdFrom,
    this.verifiedAt,
    this.roles,
  });

  factory Account.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

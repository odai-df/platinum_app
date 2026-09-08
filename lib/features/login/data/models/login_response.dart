import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? status;
  String? message;
  LoginData? data;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}


@JsonSerializable()
class LoginData {
  UserWrapper? user;

  @JsonKey(name: 'tokens')
  TokenData? tokens;

  List<String>? permissions;

  LoginData({
    this.user,
    this.tokens,
    this.permissions,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class UserWrapper {
  Account? account;

  @JsonKey(name: 'additional_info')
  AdditionalInfo? additionalInfo;

  UserWrapper({
    this.account,
    this.additionalInfo,
  });

  factory UserWrapper.fromJson(Map<String, dynamic> json) =>
      _$UserWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$UserWrapperToJson(this);
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

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class AdditionalInfo {
  @JsonKey(name: 'client_id')
  int? clientId;

  @JsonKey(name: 'birth_date')
  String? birthDate;

  @JsonKey(name: 'job_title')
  String? jobTitle;

  @JsonKey(name: 'social_status')
  String? socialStatus;

  @JsonKey(name: 'national_id')
  String? nationalId;

  AdditionalInfo({
    this.clientId,
    this.birthDate,
    this.jobTitle,
    this.socialStatus,
    this.nationalId,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoToJson(this);
}

@JsonSerializable()
class TokenData {
  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  TokenData({
    this.accessToken,
    this.refreshToken,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDataToJson(this);
}
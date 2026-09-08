// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      user: json['user'] == null
          ? null
          : UserWrapper.fromJson(json['user'] as Map<String, dynamic>),
      tokens: json['tokens'] == null
          ? null
          : TokenData.fromJson(json['tokens'] as Map<String, dynamic>),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'user': instance.user,
      'tokens': instance.tokens,
      'permissions': instance.permissions,
    };

UserWrapper _$UserWrapperFromJson(Map<String, dynamic> json) => UserWrapper(
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      additionalInfo: json['additional_info'] == null
          ? null
          : AdditionalInfo.fromJson(
              json['additional_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserWrapperToJson(UserWrapper instance) =>
    <String, dynamic>{
      'account': instance.account,
      'additional_info': instance.additionalInfo,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      createdFrom: json['created_from'] as String?,
      verifiedAt: json['verified_at'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'type': instance.type,
      'address': instance.address,
      'created_at': instance.createdAt,
      'created_from': instance.createdFrom,
      'verified_at': instance.verifiedAt,
      'roles': instance.roles,
    };

AdditionalInfo _$AdditionalInfoFromJson(Map<String, dynamic> json) =>
    AdditionalInfo(
      clientId: (json['client_id'] as num?)?.toInt(),
      birthDate: json['birth_date'] as String?,
      jobTitle: json['job_title'] as String?,
      socialStatus: json['social_status'] as String?,
      nationalId: json['national_id'] as String?,
    );

Map<String, dynamic> _$AdditionalInfoToJson(AdditionalInfo instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'birth_date': instance.birthDate,
      'job_title': instance.jobTitle,
      'social_status': instance.socialStatus,
      'national_id': instance.nationalId,
    };

TokenData _$TokenDataFromJson(Map<String, dynamic> json) => TokenData(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

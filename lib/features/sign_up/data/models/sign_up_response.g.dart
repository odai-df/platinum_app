// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : SignupData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

SignupData _$SignupDataFromJson(Map<String, dynamic> json) => SignupData(
      user: json['user'] == null
          ? null
          : SignupUser.fromJson(json['user'] as Map<String, dynamic>),
      otp: (json['otp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SignupDataToJson(SignupData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'otp': instance.otp,
    };

SignupUser _$SignupUserFromJson(Map<String, dynamic> json) => SignupUser(
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupUserToJson(SignupUser instance) =>
    <String, dynamic>{
      'account': instance.account,
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

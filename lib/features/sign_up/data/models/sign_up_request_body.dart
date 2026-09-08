import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String address;

  @JsonKey(name: 'birth_date')
  final String birthDate;

  final String email;

  final String phone;

  final String password;

  @JsonKey(name: 'password_confirmation')
  final String passwordConfirmation;

  final String gender;

  @JsonKey(name: 'job_title')
  final String jobTitle;

  @JsonKey(name: 'social_status')
  final String socialStatus;

  @JsonKey(name: 'national_id')
  final String nationalId;

  @JsonKey(ignore: true)
  final File? photo;

  SignupRequestBody({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.birthDate,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    required this.gender,
    required this.jobTitle,
    required this.socialStatus,
    required this.nationalId,
    this.photo,
  });

  factory SignupRequestBody.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$SignupRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SignupRequestBodyToJson(this);
}
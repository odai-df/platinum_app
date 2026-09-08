import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/unit_model.dart';

part 'my_order_response.g.dart';

/// ==========================
/// ROOT RESPONSE
/// ==========================
@JsonSerializable()
class MyOrdersResponse {
  final String status;
  final String message;
  final List<OrderModel> data;

  MyOrdersResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrdersResponseToJson(this);
}

/// ==========================
/// ORDER
/// ==========================
@JsonSerializable()
class OrderModel {
  final int id;
  final UnitModel? unit;
  final String status;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  OrderModel({
    required this.id,
    required this.unit,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

/// ==========================
/// CLIENT
/// ==========================
@JsonSerializable()
class ClientModel {
  final AccountModel account;

  @JsonKey(name: 'additional_info')
  final AdditionalInfoModel additionalInfo;

  ClientModel({
    required this.account,
    required this.additionalInfo,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}

/// ==========================
/// ACCOUNT
/// ==========================
@JsonSerializable()
class AccountModel {
  final int id;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;
  final String phone;
  final String type;
  final String address;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'created_from')
  final String createdFrom;

  @JsonKey(name: 'verified_at')
  final String verifiedAt;

  final List<String> roles;

  AccountModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.type,
    required this.address,
    required this.createdAt,
    required this.createdFrom,
    required this.verifiedAt,
    required this.roles,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}

/// ==========================
/// ADDITIONAL INFO
/// ==========================
@JsonSerializable()
class AdditionalInfoModel {
  @JsonKey(name: 'client_id')
  final int clientId;

  @JsonKey(name: 'birth_date')
  final String birthDate;

  @JsonKey(name: 'job_title')
  final String jobTitle;

  @JsonKey(name: 'social_status')
  final String socialStatus;

  @JsonKey(name: 'national_id')
  final String nationalId;

  AdditionalInfoModel({
    required this.clientId,
    required this.birthDate,
    required this.jobTitle,
    required this.socialStatus,
    required this.nationalId,
  });

  factory AdditionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoModelToJson(this);
}

/// ==========================
/// UNIT
/// ==========================



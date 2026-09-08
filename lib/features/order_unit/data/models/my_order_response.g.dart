// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersResponse _$MyOrdersResponseFromJson(Map<String, dynamic> json) =>
    MyOrdersResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyOrdersResponseToJson(MyOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: (json['id'] as num).toInt(),
      unit: json['unit'] == null
          ? null
          : UnitModel.fromJson(json['unit'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit': instance.unit,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) => ClientModel(
      account: AccountModel.fromJson(json['account'] as Map<String, dynamic>),
      additionalInfo: AdditionalInfoModel.fromJson(
          json['additional_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientModelToJson(ClientModel instance) =>
    <String, dynamic>{
      'account': instance.account,
      'additional_info': instance.additionalInfo,
    };

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      type: json['type'] as String,
      address: json['address'] as String,
      createdAt: json['created_at'] as String,
      createdFrom: json['created_from'] as String,
      verifiedAt: json['verified_at'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
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

AdditionalInfoModel _$AdditionalInfoModelFromJson(Map<String, dynamic> json) =>
    AdditionalInfoModel(
      clientId: (json['client_id'] as num).toInt(),
      birthDate: json['birth_date'] as String,
      jobTitle: json['job_title'] as String,
      socialStatus: json['social_status'] as String,
      nationalId: json['national_id'] as String,
    );

Map<String, dynamic> _$AdditionalInfoModelToJson(
        AdditionalInfoModel instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'birth_date': instance.birthDate,
      'job_title': instance.jobTitle,
      'social_status': instance.socialStatus,
      'national_id': instance.nationalId,
    };

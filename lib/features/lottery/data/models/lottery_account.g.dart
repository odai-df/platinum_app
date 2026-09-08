// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryAccount _$LotteryAccountFromJson(Map<String, dynamic> json) =>
    LotteryAccount(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$LotteryAccountToJson(LotteryAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };

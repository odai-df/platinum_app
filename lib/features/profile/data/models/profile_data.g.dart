// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      account: AccountModel.fromJson(json['account'] as Map<String, dynamic>),
      additionalInfo: AdditionalInfoModel.fromJson(
          json['additional_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'account': instance.account,
      'additional_info': instance.additionalInfo,
    };

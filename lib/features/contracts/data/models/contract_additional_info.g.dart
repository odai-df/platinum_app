// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_additional_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractAdditionalInfo _$ContractAdditionalInfoFromJson(
        Map<String, dynamic> json) =>
    ContractAdditionalInfo(
      clientId: (json['client_id'] as num?)?.toInt(),
      birthDate: json['birth_date'] as String?,
      jobTitle: json['job_title'] as String?,
      socialStatus: json['social_status'] as String?,
      nationalId: json['national_id'] as String?,
    );

Map<String, dynamic> _$ContractAdditionalInfoToJson(
        ContractAdditionalInfo instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'birth_date': instance.birthDate,
      'job_title': instance.jobTitle,
      'social_status': instance.socialStatus,
      'national_id': instance.nationalId,
    };

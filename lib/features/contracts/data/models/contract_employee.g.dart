// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractEmployee _$ContractEmployeeFromJson(Map<String, dynamic> json) =>
    ContractEmployee(
      account: json['account'] == null
          ? null
          : ContractAccount.fromJson(json['account'] as Map<String, dynamic>),
      additionalInfo: json['additional_info'] == null
          ? null
          : EmployeeAdditionalInfo.fromJson(
              json['additional_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractEmployeeToJson(ContractEmployee instance) =>
    <String, dynamic>{
      'account': instance.account,
      'additional_info': instance.additionalInfo,
    };

EmployeeAdditionalInfo _$EmployeeAdditionalInfoFromJson(
        Map<String, dynamic> json) =>
    EmployeeAdditionalInfo(
      employeeId: (json['employee_id'] as num?)?.toInt(),
      position: json['position'] as String?,
    );

Map<String, dynamic> _$EmployeeAdditionalInfoToJson(
        EmployeeAdditionalInfo instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'position': instance.position,
    };

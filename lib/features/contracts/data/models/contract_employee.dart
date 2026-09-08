import 'package:json_annotation/json_annotation.dart';

import 'contract_account.dart';

part 'contract_employee.g.dart';


@JsonSerializable()
class ContractEmployee {


  final ContractAccount? account;


  @JsonKey(name:"additional_info")
  final EmployeeAdditionalInfo? additionalInfo;



  ContractEmployee({
    this.account,
    this.additionalInfo,
  });



  factory ContractEmployee.fromJson(
      Map<String,dynamic> json)
  =>
      _$ContractEmployeeFromJson(json);


  Map<String,dynamic> toJson()
  =>
      _$ContractEmployeeToJson(this);


}



@JsonSerializable()
class EmployeeAdditionalInfo {


  @JsonKey(name:"employee_id")
  final int? employeeId;


  final String? position;



  EmployeeAdditionalInfo({
    this.employeeId,
    this.position,
  });



  factory EmployeeAdditionalInfo.fromJson(
      Map<String,dynamic> json)
  =>
      _$EmployeeAdditionalInfoFromJson(json);



  Map<String,dynamic> toJson()
  =>
      _$EmployeeAdditionalInfoToJson(this);

}
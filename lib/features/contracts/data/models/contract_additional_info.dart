import 'package:json_annotation/json_annotation.dart';

part 'contract_additional_info.g.dart';



@JsonSerializable()
class ContractAdditionalInfo {


  @JsonKey(name:"client_id")
  final int? clientId;


  @JsonKey(name:"birth_date")
  final String? birthDate;


  @JsonKey(name:"job_title")
  final String? jobTitle;


  @JsonKey(name:"social_status")
  final String? socialStatus;


  @JsonKey(name:"national_id")
  final String? nationalId;



  ContractAdditionalInfo({
    this.clientId,
    this.birthDate,
    this.jobTitle,
    this.socialStatus,
    this.nationalId,
  });



  factory ContractAdditionalInfo.fromJson(
      Map<String,dynamic> json)
  =>
      _$ContractAdditionalInfoFromJson(json);


  Map<String,dynamic> toJson()
  =>
      _$ContractAdditionalInfoToJson(this);

}
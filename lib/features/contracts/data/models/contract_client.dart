import 'package:json_annotation/json_annotation.dart';

import 'contract_account.dart';
import 'contract_additional_info.dart';


part 'contract_client.g.dart';


@JsonSerializable()
class ContractClient {

  final ContractAccount? account;


  @JsonKey(name: "additional_info")
  final ContractAdditionalInfo? additionalInfo;



  ContractClient({
    this.account,
    this.additionalInfo,
  });



  factory ContractClient.fromJson(
      Map<String,dynamic> json
      )
  =>
      _$ContractClientFromJson(json);



  Map<String,dynamic> toJson()
  =>
      _$ContractClientToJson(this);

}
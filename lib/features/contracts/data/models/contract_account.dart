import 'package:json_annotation/json_annotation.dart';

part 'contract_account.g.dart';


@JsonSerializable()
class ContractAccount {


  final int? id;


  @JsonKey(name:"full_name")
  final String? fullName;


  final String? email;


  final String? phone;


  final String? address;



  ContractAccount({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
  });



  factory ContractAccount.fromJson(
      Map<String,dynamic> json)
  =>
      _$ContractAccountFromJson(json);



  Map<String,dynamic> toJson()
  =>
      _$ContractAccountToJson(this);

}
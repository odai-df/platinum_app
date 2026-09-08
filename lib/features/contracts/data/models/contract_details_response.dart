import 'package:json_annotation/json_annotation.dart';
import 'contract_details_model.dart';

part 'contract_details_response.g.dart';


@JsonSerializable()
class ContractDetailsResponse {


  final String? status;

  final String? message;

  final ContractDetailsModel? data;


  ContractDetailsResponse({
    this.status,
    this.message,
    this.data,
  });


  factory ContractDetailsResponse.fromJson(
      Map<String,dynamic> json
      )
  =>
      _$ContractDetailsResponseFromJson(json);



  Map<String,dynamic> toJson()
  =>
      _$ContractDetailsResponseToJson(this);

}
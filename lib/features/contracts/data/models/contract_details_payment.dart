import 'package:json_annotation/json_annotation.dart';

part 'contract_details_payment.g.dart';


@JsonSerializable()
class ContractDetailsPayment {


  final int? id;


  final String? amount;


  @JsonKey(name:"payment_date")
  final String? paymentDate;


  @JsonKey(name:"payment_method")
  final String? paymentMethod;


  @JsonKey(name:"payment_type")
  final String? paymentType;


  final String? status;


  @JsonKey(name:"created_at")
  final String? createdAt;



  ContractDetailsPayment({

    this.id,
    this.amount,
    this.paymentDate,
    this.paymentMethod,
    this.paymentType,
    this.status,
    this.createdAt,

  });



  factory ContractDetailsPayment.fromJson(
      Map<String,dynamic> json)
  =>
      _$ContractDetailsPaymentFromJson(json);



  Map<String,dynamic> toJson()
  =>
      _$ContractDetailsPaymentToJson(this);


}
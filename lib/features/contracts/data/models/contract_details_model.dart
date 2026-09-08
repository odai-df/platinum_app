import 'package:json_annotation/json_annotation.dart';

import 'contract_details_payment.dart';
import 'contract_order.dart';
import 'contract_client.dart';
import 'contract_employee.dart';

part 'contract_details_model.g.dart';



@JsonSerializable()
class ContractDetailsModel {


  final int? id;


  final ContractOrder? order;


  final ContractClient? client;


  final ContractEmployee? employee;


  @JsonKey(name:"total_price")
  final String? totalPrice;


  @JsonKey(name:"down_payment_amount")
  final num? downPaymentAmount;


  @JsonKey(name:"installments_count")
  final int? installmentsCount;


  final String? status;


  final List<ContractDetailsPayment>? payments;


  @JsonKey(name:"created_at")
  final String? createdAt;



  ContractDetailsModel({

    this.id,
    this.order,
    this.client,
    this.employee,
    this.totalPrice,
    this.downPaymentAmount,
    this.installmentsCount,
    this.status,
    this.payments,
    this.createdAt,

  });



  factory ContractDetailsModel.fromJson(
      Map<String,dynamic> json)
  =>
      _$ContractDetailsModelFromJson(json);



  Map<String,dynamic> toJson()
  =>
      _$ContractDetailsModelToJson(this);


}
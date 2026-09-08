// import 'package:json_annotation/json_annotation.dart';
// import 'package:platinum_app/features/profile/data/models/account_model.dart';
// import 'package:platinum_app/features/units/data/models/unit_model.dart';
//
// import '../../../profile/data/models/additional_info_model.dart';
//
// part 'order_model.g.dart';
//
// @JsonSerializable()
// class OrderModel {
//   final int id;
//
//   final ClientModel client;
//
//   final UnitModel unit;
//
//   final String status;
//
//   @JsonKey(name: 'created_at')
//   final String createdAt;
//
//   @JsonKey(name: 'updated_at')
//   final String updatedAt;
//
//   OrderModel({
//     required this.id,
//     required this.client,
//     required this.unit,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory OrderModel.fromJson(Map<String, dynamic> json) =>
//       _$OrderModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OrderModelToJson(this);
// }
//
// @JsonSerializable()
// class ClientModel {
//   final AccountModel account;
//
//   final AdditionalInfoModel additionalInfo;
//
//   ClientModel({
//     required this.account,
//     required this.additionalInfo,
//   });
//
//   factory ClientModel.fromJson(Map<String, dynamic> json) =>
//       _$ClientModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ClientModelToJson(this);
// }
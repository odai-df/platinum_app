import 'package:json_annotation/json_annotation.dart';

part 'lottery_account.g.dart';

@JsonSerializable()
class LotteryAccount {
  final int? id;

  @JsonKey(name: "full_name")
  final String? fullName;

  final String? email;

  final String? phone;

  final String? address;

  LotteryAccount({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
  });

  factory LotteryAccount.fromJson(
      Map<String, dynamic> json) =>
      _$LotteryAccountFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LotteryAccountToJson(this);
}
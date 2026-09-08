import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel {
  final int id;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;
  final String phone;
  final String type;
  final String address;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'created_from')
  final String createdFrom;

  @JsonKey(name: 'verified_at')
  final String? verifiedAt;

  final List<String> roles;

  AccountModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.type,
    required this.address,
    required this.createdAt,
    required this.createdFrom,
    this.verifiedAt,
    required this.roles,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
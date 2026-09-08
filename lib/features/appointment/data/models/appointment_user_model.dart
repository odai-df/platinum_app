import 'package:json_annotation/json_annotation.dart';

part 'appointment_user_model.g.dart';

@JsonSerializable()
class AppointmentUserModel {
  final int? id;

  @JsonKey(name: 'full_name')
  final String? fullName;

  final String? email;
  final String? phone;
  final String? type;
  final String? address;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'created_from')
  final String? createdFrom;

  @JsonKey(name: 'verified_at')
  final String? verifiedAt;

  final List<String>? roles;

  @JsonKey(name: 'available_roles')
  final List<AppointmentRoleModel>? availableRoles;

  const AppointmentUserModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.type,
    this.address,
    this.createdAt,
    this.createdFrom,
    this.verifiedAt,
    this.roles,
    this.availableRoles,
  });

  factory AppointmentUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentUserModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppointmentUserModelToJson(this);
}

@JsonSerializable()
class AppointmentRoleModel {
  final int? id;
  final String? name;

  const AppointmentRoleModel({
    this.id,
    this.name,
  });

  factory AppointmentRoleModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRoleModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppointmentRoleModelToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentUserModel _$AppointmentUserModelFromJson(
        Map<String, dynamic> json) =>
    AppointmentUserModel(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      createdFrom: json['created_from'] as String?,
      verifiedAt: json['verified_at'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      availableRoles: (json['available_roles'] as List<dynamic>?)
          ?.map((e) => AppointmentRoleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppointmentUserModelToJson(
        AppointmentUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'type': instance.type,
      'address': instance.address,
      'created_at': instance.createdAt,
      'created_from': instance.createdFrom,
      'verified_at': instance.verifiedAt,
      'roles': instance.roles,
      'available_roles': instance.availableRoles,
    };

AppointmentRoleModel _$AppointmentRoleModelFromJson(
        Map<String, dynamic> json) =>
    AppointmentRoleModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AppointmentRoleModelToJson(
        AppointmentRoleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

import 'package:json_annotation/json_annotation.dart';

part 'appointment_order_model.g.dart';

@JsonSerializable()
class AppointmentOrderModel {
  final int? id;
  final String? type;
  final String? status;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const AppointmentOrderModel({
    this.id,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AppointmentOrderModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentOrderModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppointmentOrderModelToJson(this);
}
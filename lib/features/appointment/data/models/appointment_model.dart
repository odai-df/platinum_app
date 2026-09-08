import 'package:json_annotation/json_annotation.dart';

import 'appointment_note_model.dart';
import 'appointment_order_model.dart';
import 'appointment_slot_model.dart';

part 'appointment_model.g.dart';

@JsonSerializable()
class AppointmentModel {
  final int? id;

  final AppointmentOrderModel? order;

  final AppointmentSlotModel? slot;

  final String? status;

  final String? type;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  final List<AppointmentNoteModel>? notes;

  const AppointmentModel({
    this.id,
    this.order,
    this.slot,
    this.status,
    this.type,
    this.createdAt,
    this.notes,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppointmentModelToJson(this);
}
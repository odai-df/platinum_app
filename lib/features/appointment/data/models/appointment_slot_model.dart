import 'package:json_annotation/json_annotation.dart';

part 'appointment_slot_model.g.dart';

@JsonSerializable()
class AppointmentSlotModel {
  final int? id;
  final String? date;

  @JsonKey(name: 'start_time')
  final String? startTime;

  final String? status;

  @JsonKey(name: 'batch_id')
  final String? batchId;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const AppointmentSlotModel({
    this.id,
    this.date,
    this.startTime,
    this.status,
    this.batchId,
    this.createdAt,
  });

  factory AppointmentSlotModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentSlotModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentSlotModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'available_slot_model.g.dart';

@JsonSerializable()
class AvailableSlotModel {
  final int id;

  final String date;

  @JsonKey(name: 'start_time')
  final String startTime;

  final String status;

  @JsonKey(name: 'batch_id')
  final String batchId;

  @JsonKey(name: 'created_at')
  final String createdAt;

  const AvailableSlotModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.status,
    required this.batchId,
    required this.createdAt,
  });

  factory AvailableSlotModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AvailableSlotModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableSlotModelToJson(this);
}

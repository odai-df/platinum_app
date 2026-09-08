import 'package:json_annotation/json_annotation.dart';

import 'available_slot_model.dart';

part 'available_slots_response.g.dart';

@JsonSerializable()
class AvailableSlotsResponse {
  final String status;
  final String message;
  final List<AvailableSlotModel> data;

  const AvailableSlotsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AvailableSlotsResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AvailableSlotsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AvailableSlotsResponseToJson(this);
}
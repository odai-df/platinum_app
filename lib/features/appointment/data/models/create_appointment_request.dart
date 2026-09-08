class CreateAppointmentRequest {
  final int avSlotId;
  final String type;
  final String notes;

  const CreateAppointmentRequest({
    required this.avSlotId,
    required this.type,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'av_slot_id': avSlotId,
      'type': type,
      'notes': notes,
    };
  }
}
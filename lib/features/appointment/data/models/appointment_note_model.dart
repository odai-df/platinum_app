import 'package:json_annotation/json_annotation.dart';

import 'appointment_user_model.dart';

part 'appointment_note_model.g.dart';

@JsonSerializable()
class AppointmentNoteModel {
  final int? id;
  final String? text;

  @JsonKey(name: 'created_by')
  final AppointmentUserModel? createdBy;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const AppointmentNoteModel({
    this.id,
    this.text,
    this.createdBy,
    this.createdAt,
  });

  factory AppointmentNoteModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentNoteModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppointmentNoteModelToJson(this);
}
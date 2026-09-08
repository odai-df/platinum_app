import 'package:json_annotation/json_annotation.dart';

part 'chat_room_response.g.dart';

@JsonSerializable()
class ChatRoomResponse {
  final String? status;
  final String? message;
  final ChatRoomData? data;

  ChatRoomResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ChatRoomResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ChatRoomResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChatRoomResponseToJson(this);
}

@JsonSerializable()
class ChatRoomData {
  final int? id;

  @JsonKey(name: 'client_id')
  final int? clientId;

  @JsonKey(name: 'employee_id')
  final int? employeeId;

  final String? status;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  ChatRoomData({
    this.id,
    this.clientId,
    this.employeeId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatRoomData.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ChatRoomDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChatRoomDataToJson(this);
}
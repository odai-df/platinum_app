import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  final int? id;

  @JsonKey(name: 'room_id')
  final int? roomId;

  @JsonKey(name: 'sender_id')
  final int? senderId;

  @JsonKey(name: 'sender_type')
  final String? senderType;

  final String? content;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  ChatMessage({
    this.id,
    this.roomId,
    this.senderId,
    this.senderType,
    this.content,
    this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}


Map<String, dynamic> normalizeMessage(Map<String, dynamic> json) {
  return {
    ...json,
    "room_id": json["room_id"] ?? json["chat_room_id"],
  };
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: (json['id'] as num?)?.toInt(),
      roomId: (json['room_id'] as num?)?.toInt(),
      senderId: (json['sender_id'] as num?)?.toInt(),
      senderType: json['sender_type'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'sender_id': instance.senderId,
      'sender_type': instance.senderType,
      'content': instance.content,
      'created_at': instance.createdAt,
    };

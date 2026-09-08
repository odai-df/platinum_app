import 'package:json_annotation/json_annotation.dart';

import 'chat_message.dart';

part 'chat_messages_response.g.dart';

@JsonSerializable()
class ChatMessagesResponse {
  final String? status;
  final String? message;
  final List<ChatMessage>? data;

  ChatMessagesResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ChatMessagesResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ChatMessagesResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChatMessagesResponseToJson(this);
}
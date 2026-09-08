abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatRoomReady extends ChatState {}

class ChatSendingMessage extends ChatState {}

class ChatMessageReceived extends ChatState {}

class ChatMessageSent extends ChatState {}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
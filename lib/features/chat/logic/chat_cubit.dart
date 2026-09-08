import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/chat_message.dart';
import '../data/repo/chat_repo.dart';
import '../data/services/chat_pusher_service.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  final ChatPusherService pusherService;

  ChatCubit(this.chatRepo, this.pusherService) : super(ChatInitial());

  int? roomId;
  List<ChatMessage> messages = [];

  bool _isSubscribed = false;

  /// ================= INIT CHAT =================
  Future<void> initChat() async {
    emit(ChatLoading());

    final roomResult = await chatRepo.createRoom();

    roomResult.when(
      success: (roomResponse) async {
        roomId = roomResponse.data?.id;

        if (roomId == null) {
          emit(ChatError("Room not found"));
          return;
        }

        await loadMessages();
        await _initPusher();

        emit(ChatRoomReady());
      },
      failure: (error) {
        emit(ChatError(error.apiErrorModel.message ?? "Error"));
      },
    );
  }

  /// ================= LOAD MESSAGES =================
  Future<void> loadMessages() async {
    if (roomId == null) return;

    final result = await chatRepo.getRoomMessages(roomId!);

    result.when(
      success: (response) {
        messages = response.data ?? [];

        emit(ChatRoomReady());
      },
      failure: (error) {
        emit(ChatError(error.apiErrorModel.message ?? "Error"));
      },
    );
  }

  /// ================= PUSHER =================
  Future<void> _initPusher() async {
    await pusherService.init();

    if (_isSubscribed) return;

    _isSubscribed = true;

    await pusherService.subscribeToRoom(
      roomId: roomId!,
      onMessage: (data) {
        try {
          final jsonData = Map<String, dynamic>.from(data);

          final message = ChatMessage.fromJson(jsonData);

          if (messages.any((e) => e.id == message.id)) {
            return;
          }

          messages.insert(0, message);

          emit(ChatMessageReceived());
        } catch (e) {
          print("ERROR => $e");
        }
      },
    );
  }

  /// ================= SEND MESSAGE =================
  Future<void> sendMessage(String content) async {
    if (roomId == null) return;

    final result = await chatRepo.sendMessage(
      roomId: roomId!,
      content: content,
    );

    result.when(
      success: (_) {
        // لا تعمل insert
        // لا تعمل ChatMessage.fromJson

        emit(ChatMessageSent());
      },
      failure: (error) {
        emit(
          ChatError(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  /// ================= CLEANUP =================
  @override
  Future<void> close() async {
    if (roomId != null) {
      await pusherService.unsubscribe(roomId!);
    }

    await pusherService.disconnect();

    return super.close();
  }
}
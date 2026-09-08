import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:platinum_app/core/networking/api_constants.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';

class ChatPusherService {
  final PusherChannelsFlutter pusher =
  PusherChannelsFlutter.getInstance();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    await pusher.init(
      apiKey: "2e531002c977039de473",
      cluster: "us3",

      onConnectionStateChange: (
          currentState,
          previousState,
          ) {
        print(
          "PUSHER STATE => $previousState -> $currentState",
        );
      },

      onError: (
          message,
          code,
          error,
          ) {
        print(
          "PUSHER ERROR => $message",
        );

        print(
          "PUSHER CODE => $code",
        );

        print(
          "PUSHER DETAILS => $error",
        );
      },

      onAuthorizer: (
          String channelName,
          String socketId,
          dynamic options,
          ) async {
        print(
          "AUTH REQUEST => $channelName",
        );

        print(
          "SOCKET ID => $socketId",
        );

        final token =
        await SharedPrefHelper.getSecuredString(
          SharedPrefKeys.accessToken,
        );

        final response = await Dio().post(
          "${ApiConstants.apiBaseUrl}/broadcasting/auth",
          data: {
            "channel_name": channelName,
            "socket_id": socketId,
          },
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json",
            },
          ),
        );

        print(
          "AUTH RESPONSE => ${response.data}",
        );

        return response.data;
      },
    );

    await pusher.connect();

    print("PUSHER CONNECT CALLED");

    _initialized = true;
  }

  Future<void> subscribeToRoom({
    required int roomId,
    required Function(dynamic) onMessage,
  }) async {
    print(
      "SUBSCRIBING TO => private-chat.$roomId",
    );

    await pusher.subscribe(
      channelName: "private-chat.$roomId",

      onSubscriptionSucceeded: (data) {
        print(
          "SUBSCRIPTION SUCCESS => $data",
        );
      },

      onSubscriptionError: (
          message,
          error,
          ) {
        print(
          "SUBSCRIPTION ERROR => $message",
        );

        print(
          "SUBSCRIPTION DETAILS => $error",
        );
      },

      onEvent: (event) {
        print("EVENT NAME => ${event.eventName}");
        print("EVENT DATA => ${event.data}");

        if (event.eventName !=  "message.new") return;

        try {
          dynamic data = event.data;

          Map<String, dynamic> jsonData;

          if (data is String) {
            jsonData = jsonDecode(data);
          } else if (data is Map) {
            jsonData = Map<String, dynamic>.from(data);
          } else {
            print("UNKNOWN DATA TYPE => ${data.runtimeType}");
            return;
          }

          onMessage(jsonData);
        } catch (e) {
          print("JSON ERROR => $e");
        }
      },
    );
  }
  Future<void> unsubscribe(
      int roomId,
      ) async {
    await pusher.unsubscribe(
      channelName: "private-chat.$roomId",
    );
  }

  Future<void> disconnect() async {
    await pusher.disconnect();
  }
}
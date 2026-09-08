import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {

  const factory NotificationState.initial() = _Initial;

  const factory NotificationState.loading() = _Loading;

  const factory NotificationState.loaded() = _Loaded;

  const factory NotificationState.unreadCountLoaded(
      int count,
      ) = _UnreadCountLoaded;

  const factory NotificationState.error(
      String message,
      ) = _Error;

  const factory NotificationState.notificationRead(
      String id,
      ) = _NotificationRead;


  const factory NotificationState.allNotificationsRead() =
  _AllNotificationsRead;
}
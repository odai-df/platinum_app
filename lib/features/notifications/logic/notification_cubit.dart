import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/notification_model.dart';
import '../data/repo/notification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationsRepo notificationRepo;

  NotificationCubit(
    this.notificationRepo,
  ) : super(
          const NotificationState.initial(),
        );

  List<NotificationModel> notifications = [];

  Future<void> getNotifications() async {
    emit(
      const NotificationState.loading(),
    );

    final result = await notificationRepo.getNotifications();

    result.when(
      success: (response) {
        notifications = response.data ?? [];

        emit(
          const NotificationState.loaded(),
        );
      },
      failure: (error) {
        emit(
          NotificationState.error(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }

  int unreadCount = 0;

  Future<void> getUnreadCount() async {
    final result = await notificationRepo.getUnreadCount();

    result.when(
      success: (response) {
        unreadCount = response.data?.unreadCount ?? 0;

        emit(
          NotificationState.unreadCountLoaded(
            unreadCount,
          ),
        );
      },
      failure: (error) {
        emit(
          NotificationState.error(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  Future<void> markAsRead(String id) async {
    final result = await notificationRepo.markNotificationAsRead(id);

    result.when(
      success: (_) {
        print("NOTIFICATION MARKED AS READ => $id");

        final index = notifications.indexWhere(
          (notification) => notification.id == id,
        );

        print("INDEX => $index");

        if (index != -1 && notifications[index].readAt == null) {
          notifications[index] = notifications[index].copyWith(
            readAt: DateTime.now().toIso8601String(),
          );

          if (unreadCount > 0) {
            unreadCount--;
          }

          print(
            "UPDATED READ AT => ${notifications[index].readAt}",
          );

          print(
            "UPDATED UNREAD COUNT => $unreadCount",
          );
        }

        emit(
          NotificationState.notificationRead(id),
        );
      },
      failure: (error) {
        emit(
          NotificationState.error(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  Future<void> markAllAsRead() async {
    final result = await notificationRepo.markAllNotificationsAsRead();

    result.when(
      success: (_) {
        print("ALL NOTIFICATIONS MARKED AS READ");

        notifications = notifications.map((notification) {
          if (notification.readAt == null) {
            return notification.copyWith(
              readAt: DateTime.now().toIso8601String(),
            );
          }

          return notification;
        }).toList();

        unreadCount = 0;

        emit(
          const NotificationState.allNotificationsRead(),
        );
      },
      failure: (error) {
        emit(
          NotificationState.error(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }
}

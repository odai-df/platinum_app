import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/theme_extension.dart';
import '../../data/models/notification_model.dart';
import '../../logic/notification_cubit.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = notification.readAt != null;
    final isUnread = !isRead;

    return GestureDetector(
      onTap: () async {
        if (!notification.isRead) {
          await context
              .read<NotificationCubit>()
              .markAsRead(notification.id);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnread
              ? (context.isDark
                  ? Colors.blue.withOpacity(.08)
                  : Colors.blue.withOpacity(.035))
              : context.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: isUnread
              ? Border.all(
                  color: Colors.blue.withOpacity(.18),
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                context.isDark ? .25 : .06,
              ),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Notification icon
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isUnread
                        ? Icons.notifications_active
                        : Icons.notifications_none,
                    color: Colors.blue,
                  ),
                ),

                /// Unread indicator
                if (isUnread)
                  Positioned(
                    right: -1,
                    top: -1,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.cardColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight:
                          isUnread ? FontWeight.bold : FontWeight.normal,
                      color: context.textColor,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Body
                  Text(
                    notification.body,
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Date
                  Text(
                    notification.createdAt,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.subTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';

import '../../../core/theming/app_colors.dart';
import '../logic/notification_cubit.dart';
import '../logic/notification_state.dart';
import 'widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final cubit = context.read<NotificationCubit>();
        final notifications = cubit.notifications;
        final unreadCount = cubit.unreadCount;

        return Scaffold(
          backgroundColor: context.bgColor,

          /// ================= APP BAR =================
          appBar: AppBar(
            backgroundColor: context.bgColor,
            centerTitle: true,
            title: Text(
              "Notifications".tr(),
            ),
            actions: [
              /// Mark all as read
              if (unreadCount > 0)
                IconButton(
                  tooltip: "Mark all as read".tr(),
                  icon: const Icon(
                    Icons.done_all,
                  ),
                  onPressed: () {
                    cubit.markAllAsRead();
                  },
                ),

              const SizedBox(width: 8),
            ],
          ),

          /// ================= BODY =================
          body: state.maybeWhen(
            loading: () {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const _NotificationLoadingCard();
                },
              );
            },
            error: (message) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 52,
                        color: Colors.red.shade300,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.textColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 18),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await cubit.getNotifications();
                          await cubit.getUnreadCount();
                        },
                        icon: const Icon(
                          Icons.refresh_rounded,
                        ),
                        label: Text(
                          "Retry".tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            orElse: () {
              if (notifications.isEmpty) {
                return Center(
                  child: Text(
                    "No notifications".tr(),
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 14,
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await cubit.getNotifications();
                  await cubit.getUnreadCount();
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                      notification: notifications[index],
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _NotificationLoadingCard extends StatelessWidget {
  const _NotificationLoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.isDark
              ? Colors.white.withOpacity(.06)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON SKELETON
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: context.isDark
                  ? Colors.white.withOpacity(.08)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
          ),

          const SizedBox(width: 12),

          /// CONTENT SKELETON
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 13,
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? Colors.white.withOpacity(.08)
                        : Colors.grey.shade200,
                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),

                const SizedBox(height: 9),

                Container(
                  width: double.infinity,
                  height: 12,
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? Colors.white.withOpacity(.06)
                        : Colors.grey.shade200,
                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),

                const SizedBox(height: 7),

                Container(
                  width: 180,
                  height: 12,
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? Colors.white.withOpacity(.06)
                        : Colors.grey.shade200,
                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: 80,
                  height: 10,
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? Colors.white.withOpacity(.05)
                        : Colors.grey.shade200,
                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
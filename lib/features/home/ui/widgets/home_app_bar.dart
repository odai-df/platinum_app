import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/theme_extension.dart';
import '../../../notifications/logic/notification_cubit.dart';
import '../../../notifications/logic/notification_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bg = context.cardColor;
    final iconColor = context.textColor;
    final hintColor = context.subTextColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          /// ================= MENU =================
          Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: context.isDark
                      ? Colors.black.withOpacity(0.4)
                      : Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.menu, color: iconColor),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),

          const SizedBox(width: 12),

          /// ================= SEARCH =================
          Expanded(
            child: InkWell(
              onTap: () {
                context.pushNamed(Routes.search);
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: context.isDark
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.blue,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        "Search by ...".tr(),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey.shade100,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Icon(
                    //     Icons.tune_rounded,
                    //     color: Colors.grey.shade700,
                    //     size: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// ================= NOTIFICATION =================
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {

              int count = 0;

              state.whenOrNull(
                unreadCountLoaded: (value) {
                  count = value;
                },
              );

              return Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: context.isDark
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [

                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: iconColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.notificationsScreen,
                        );
                      },
                    ),

                    if (count > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            count > 9 ? "9+".tr() : count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
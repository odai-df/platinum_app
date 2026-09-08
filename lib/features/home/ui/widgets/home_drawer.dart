import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';

import 'drawer_item.dart';
import 'logout_dialog.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Drawer(
      backgroundColor: context.bgColor,
      elevation: 0,
      child: SafeArea(
        child: Column(
          children: [
            /// ============================================================
            /// HEADER
            /// ============================================================

            FutureBuilder<List<String>>(
              future: _getUserInfo(),
              builder: (context, snapshot) {
                final userName = snapshot.data?[0] ?? '';
                final email = snapshot.data?[1] ?? '';

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    22,
                    20,
                    20,
                  ),
                  decoration: BoxDecoration(
                    gradient: isDark
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF1E293B),
                              Color(0xFF111827),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [
                              AppColors.primary,
                              Color(0xFF229ED9),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(.20)
                            : AppColors.primary.withOpacity(.16),
                        blurRadius: 18,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          /// AVATAR
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(.35),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),

                          const SizedBox(width: 14),

                          /// USER INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome back".tr(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.70),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  userName.isNotEmpty ? userName : "User".tr(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  email.isNotEmpty ? email : "-",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.72),
                                    fontSize: 11.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              color: Colors.white.withOpacity(.85),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Client Account".tr(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(.9),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            /// ============================================================
            /// CONTENT
            /// ============================================================

            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 10,
                ),
                children: [
                  _SectionTitle(
                    title: "My Account".tr(),
                  ),
                  DrawerItem(
                    icon: Icons.date_range_outlined,
                    color: AppColors.primary,
                    title: "appointments".tr(),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        Routes.appointmentsScreen,
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.real_estate_agent_outlined,
                    color: AppColors.primary,
                    title: "my units".tr(),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        Routes.myUnits,
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.description_outlined,
                    color: Colors.indigo,
                    title: "contracts".tr(),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        Routes.contracts,
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.report_problem_outlined,
                    color: AppColors.primary,
                    title: "My Complaints".tr(),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        Routes.myComplaints,
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.payments_outlined,
                    color: Colors.green,
                    title: "payments".tr(),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        Routes.paymentScreen,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _SectionTitle(
                    title: "Services".tr(),
                  ),
                  DrawerItem(
                    icon: Icons.chat_outlined,
                    title: "Customer service".tr(),
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        Routes.chat,
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.emoji_events_outlined,
                    title: "Lottery".tr(),
                    color: Colors.amber.shade700,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        Routes.lottery,
                      );
                    },
                  ),
                ],
              ),
            ),

            /// ============================================================
            /// LOGOUT
            /// ============================================================

            Container(
              padding: const EdgeInsets.fromLTRB(
                12,
                8,
                12,
                12,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(.06)
                        : Colors.black.withOpacity(.05),
                  ),
                ),
              ),
              child: DrawerItem(
                icon: Icons.logout_rounded,
                title: "Logout".tr(),
                color: Colors.red,
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (_) => const LogoutDialog(),
                  );

                  if (result == true) {
                    if (!context.mounted) return;

                    Navigator.of(context).pop();

                    await SharedPrefHelper.clearAllData();
                    await SharedPrefHelper.clearAllSecuredData();

                    isLoggedInUser = false;

                    if (!context.mounted) return;

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      (route) => false,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> _getUserInfo() async {
    final userName = await SharedPrefHelper.getString(
      SharedPrefKeys.userName,
    );

    final email = await SharedPrefHelper.getString(
      SharedPrefKeys.email,
    );

    return [
      userName ?? '',
      email ?? '',
    ];
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        5,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: context.subTextColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: .3,
        ),
      ),
    );
  }
}

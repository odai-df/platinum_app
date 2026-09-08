import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/theme_extension.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../core/routing/routes.dart';

import '../logic/profile_cubit.dart';
import '../logic/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final t = context;

    return Scaffold(
      backgroundColor: t.bgColor,

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: t.textColor),
              ),
            );
          }

          if (state is ProfileLoaded) {
            final profile = state.profile.data;
            final account = profile.account;
            final info = profile.additionalInfo;

            return Stack(
              children: [
                /// ================= HEADER =================
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                ),

                /// ================= CONTENT =================
                SafeArea(
                  child: Column(
                    children: [
                      /// TOP BAR
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [

                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () async {
                                final result = await Navigator.pushNamed(
                                  context,
                                  Routes.editProfile,
                                  arguments: profile,
                                );

                                if (result == true) {
                                  context.read<ProfileCubit>().getProfile();
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// AVATAR
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        account.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        account.email,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// ================= INFO CARD =================
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: t.cardColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: ListView(
                            children: [
                              _card(Icons.phone, "Phone".tr(),
                                  account.phone, context),
                              _card(Icons.location_on, "Address".tr(),
                                  account.address, context),
                              _card(Icons.work, "Job".tr(),
                                  info.jobTitle, context),
                              _card(Icons.favorite, "Status".tr(),
                                  info.socialStatus, context),
                              _card(Icons.badge, "National ID".tr(),
                                  info.nationalId, context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _card(
      IconData icon,
      String title,
      String value,
      BuildContext context,
      ) {
    final t = context;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: t.isDark
            ?AppColors.darkContainer.withOpacity(0.1)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: t.isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: t.subTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.textColor,
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:platinum_app/features/home/ui/widgets/home_app_bar.dart';
import 'package:platinum_app/features/home/ui/widgets/home_drawer.dart';
import 'package:platinum_app/features/home/ui/widgets/units_section.dart';

import '../../../../core/theming/theme_extension.dart';
import '../../ads/logic/advertisements_cubit.dart';
import '../../ads/logic/advertisements_state.dart';
import '../../ads/ui/ads_section.dart';
import '../../notifications/logic/notification_cubit.dart';
import '../../service/logic/solutions_cubit.dart';
import '../../service/logic/solutions_state.dart';
import '../../service/ui/solutions_section.dart';
import '../../units/logic/units_cubit.dart';
import '../../units/logic/units_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<UnitsCubit>().fetchUnits();
    context.read<NotificationCubit>().getUnreadCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      drawer: const HomeDrawer(),
      body: SafeArea(
        child: _buildHomeContent(),
      ),
    );
  }

  Widget _buildHomeContent() {
    return BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
      builder: (context, adsState) {
        return BlocBuilder<SolutionsCubit, SolutionsState>(
          builder: (context, solutionsState) {
            return BlocBuilder<UnitsCubit, UnitsState>(
              builder: (context, unitsState) {
                // ─────────────────────────────
                // ADS ERROR
                // ─────────────────────────────

                final adsError = adsState.maybeWhen(
                  error: (message) => message,
                  orElse: () => null,
                );

                // ─────────────────────────────
                // SERVICES ERROR
                // ─────────────────────────────

                final solutionsError = solutionsState.maybeWhen(
                  error: (message) => message,
                  orElse: () => null,
                );

                // ─────────────────────────────
                // UNITS ERROR
                // ─────────────────────────────

                String? unitsError;

                if (unitsState is UnitsFailure) {
                  unitsError = unitsState.message;
                }

                // ─────────────────────────────
                // ANY HOME API ERROR
                // ─────────────────────────────

                final errorMessage = adsError ?? solutionsError ?? unitsError;

                if (errorMessage != null) {
                  return _buildErrorView(errorMessage);
                }

                // ─────────────────────────────
                // NORMAL HOME
                // ─────────────────────────────

                return Column(
                  children: [
                    const HomeAppBar(),
                    SizedBox(height: 10.h),
                    const AdsSection(),
                    SizedBox(height: 10.h),
                    const ServicesSection(),
                    SizedBox(height: 10.h),
                    const Expanded(
                      child: UnitsSection(),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildErrorView(String message) {
    return Column(
      children: [
        const HomeAppBar(),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_off_rounded,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Something went wrong',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AdvertisementsCubit>().getAds();

                      context.read<SolutionsCubit>().getSolutions();

                      context.read<UnitsCubit>().fetchUnits();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

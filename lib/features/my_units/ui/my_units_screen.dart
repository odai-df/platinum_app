import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../logic/my_units_cubit.dart';
import '../logic/my_units_state.dart';
import 'widgets/my_unit_card.dart';

class MyUnitsScreen extends StatelessWidget {
  const MyUnitsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyUnitsCubit>()..getMyUnits(),
      child: const _MyUnitsView(),
    );
  }
}

class _MyUnitsView extends StatelessWidget {
  const _MyUnitsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.bgColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Properties'.tr(),
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocBuilder<MyUnitsCubit, MyUnitsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            error: (message) => _ErrorView(
              message: message,
              onRetry: () {
                context.read<MyUnitsCubit>().getMyUnits();
              },
            ),
            success: (units) {
              if (units.isEmpty) {
                return const _EmptyMyUnits();
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () {
                  return context.read<MyUnitsCubit>().getMyUnits();
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    10,
                    16,
                    30,
                  ),
                  itemCount: units.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    return MyUnitCard(
                      myUnit: units[index],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptyMyUnits extends StatelessWidget {
  const _EmptyMyUnits();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.home_work_outlined,
                size: 42,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No Properties Yet'.tr(),
              style: TextStyle(
                color: context.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You don't own any properties yet.".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text('Retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/features/lottery/data/models/lottery_model.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../logic/lottery_cubit.dart';
import '../logic/lottery_state.dart';

class LotteryScreen extends StatefulWidget {
  const LotteryScreen({super.key});

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  @override
  void initState() {
    super.initState();

    context.read<LotteryCubit>().getLotteries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Lottery".tr(),
          style: TextStyle(
            color: context.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<LotteryCubit, LotteryState>(
        builder: (context, state) {
          final cubit = context.read<LotteryCubit>();

          if (state is LotteryLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state is LotteryError) {
            return _ErrorState(
              message: state.message,
              onRetry: () {
                cubit.getLotteries();
              },
            );
          }

          if (cubit.lotteries.isEmpty) {
            return const _EmptyLotteryState();
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () {
              return cubit.getLotteries();
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                30,
              ),
              itemCount: cubit.lotteries.length,
              separatorBuilder: (_, __) {
                return const SizedBox(height: 16);
              },
              itemBuilder: (context, index) {
                final lottery = cubit.lotteries[index];

                return _LotteryCard(
                  lottery: lottery,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.lotteryDetails,
                      arguments: lottery.id,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// LOTTERY CARD
// ============================================================

class _LotteryCard extends StatelessWidget {
  final LotteryModel lottery;
  final VoidCallback onTap;

  const _LotteryCard({
    required this.lottery,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = lottery.status == "completed";

    final statusColor = isCompleted ? Colors.green : Colors.orange;

    return Material(
      color: context.cardColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: context.isDark
                  ? Colors.white.withOpacity(.06)
                  : Colors.grey.withOpacity(.10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  context.isDark ? .18 : .045,
                ),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================================================
                // HEADER
                // ==================================================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.10),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lottery".tr(),
                            style: TextStyle(
                              color: context.subTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lottery.title ?? "Untitled Lottery".tr(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _StatusBadge(
                      text: lottery.status ?? "-",
                      color: statusColor,
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // ==================================================
                // DIVIDER
                // ==================================================

                Divider(
                  height: 1,
                  color: context.isDark
                      ? Colors.white.withOpacity(.06)
                      : Colors.grey.withOpacity(.10),
                ),

                const SizedBox(height: 16),

                // ==================================================
                // UNIT HEADER
                // ==================================================

                Row(
                  children: [
                    Icon(
                      Icons.apartment_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      "Property Details".tr(),
                      style: TextStyle(
                        color: context.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ==================================================
                // PROPERTY INFO
                // ==================================================

                Row(
                  children: [
                    Expanded(
                      child: _InfoBox(
                        icon: Icons.home_work_outlined,
                        title: "Unit".tr(),
                        value: lottery.unit?.unitNumber ?? "-",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _InfoBox(
                        icon: Icons.layers_outlined,
                        title: "Floor".tr(),
                        value: "${lottery.unit?.floor ?? "-"}",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _InfoBox(
                        icon: Icons.square_foot_rounded,
                        title: "Area".tr(),
                        value: "${lottery.unit?.area ?? "-"} " + "m²".tr(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _InfoBox(
                        icon: Icons.meeting_room_outlined,
                        title: "Rooms".tr(),
                        value: "${lottery.unit?.roomsCount ?? "-"}",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ==================================================
                // PRICE
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.06),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(.10),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(
                          Icons.payments_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price".tr(),
                              style: TextStyle(
                                color: context.subTextColor,
                                fontSize: 11,
                              ),
                            ),

                            const SizedBox(height: 2),

                            if (lottery.unit?.hasActiveOffer == true)
                              Text(
                                "${lottery.unit?.originalPrice ?? "-"}",
                                style: TextStyle(
                                  color: context.subTextColor,
                                  fontSize: 11,
                                  decoration:
                                  TextDecoration.lineThrough,
                                ),
                              ),

                            Text(
                              "${lottery.unit?.currentPrice ?? "-"}",
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (lottery.unit?.hasActiveOffer == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "-${lottery.unit?.discountPercentage ?? 0}%",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      const SizedBox(width: 8),

                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: context.subTextColor,
                      ),
                    ],
                  ),
                ),

                // ==================================================
                // RULES
                // ==================================================

                if (lottery.rules != null && lottery.rules!.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  Text(
                    "Eligibility Rules".tr(),
                    style: TextStyle(
                      color: context.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: lottery.rules!.map<Widget>(
                      (rule) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: context.isDark
                                ? Colors.white.withOpacity(.05)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_outlined,
                                size: 15,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${rule.ruleKey} "
                                "${rule.operator} "
                                "${rule.ruleValue}",
                                style: TextStyle(
                                  color: context.textColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],

                const SizedBox(height: 16),

                // ==================================================
                // VIEW DETAILS
                // ==================================================

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "View Details".tr(),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// INFO BOX
// ============================================================

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoBox({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: context.isDark
            ? Colors.white.withOpacity(.035)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: context.subTextColor,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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

// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusBadge({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ============================================================
// EMPTY
// ============================================================

class _EmptyLotteryState extends StatelessWidget {
  const _EmptyLotteryState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.workspace_premium_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              "No Lotteries Found".tr(),
              style: TextStyle(
                color: context.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "There are no lotteries available at the moment.".tr(),
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

// ============================================================
// ERROR
// ============================================================

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
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
              size: 58,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text("Retry".tr()),
            ),
          ],
        ),
      ),
    );
  }
}

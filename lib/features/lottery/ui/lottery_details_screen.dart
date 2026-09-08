import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/theming/app_colors.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';
import 'package:platinum_app/features/lottery/data/models/lottery_model.dart';

import '../logic/lottery_cubit.dart';
import '../logic/lottery_state.dart';

class LotteryDetailsScreen extends StatelessWidget {
  const LotteryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: context.bgColor,
        foregroundColor: context.textColor,
        title: Text(
          "Lottery Details".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<LotteryCubit, LotteryState>(
        builder: (context, state) {
          final cubit = context.read<LotteryCubit>();

          if (state is LotteryLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state is LotteryError) {
            return _ErrorView(
              message: state.message,
              onRetry: () {
                // إذا عندك id محفوظ بالـ cubit حطه هون
              },
            );
          }

          final lottery = cubit.lotteryDetails;

          if (lottery == null) {
            return _EmptyView();
          }

          final rules = lottery.rules ?? [];
          final participants = lottery.participants ?? [];

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              // إذا عندك method لجلب التفاصيل مرة ثانية
              // await cubit.getLotteryDetails(lottery.id);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// =====================================================
                  /// HEADER
                  /// =====================================================
                  _buildHeader(
                    context,
                    lottery,
                  ),

                  const SizedBox(height: 24),

                  /// =====================================================
                  /// UNIT INFORMATION
                  /// =====================================================
                  _sectionHeader(
                    context,
                    icon: Icons.home_work_outlined,
                    title: "Unit Information".tr(),
                  ),

                  const SizedBox(height: 12),

                  _buildUnitCard(
                    context,
                    lottery,
                  ),

                  /// =====================================================
                  /// RULES
                  /// =====================================================
                  if (rules.isNotEmpty) ...[
                    const SizedBox(height: 26),
                    _sectionHeader(
                      context,
                      icon: Icons.rule_outlined,
                      title: "Rules".tr(),
                    ),
                    const SizedBox(height: 12),
                    ...rules.map(
                      (rule) => _buildRuleCard(
                        context,
                        rule,
                      ),
                    ),
                  ],

                  /// =====================================================
                  /// PARTICIPANTS
                  /// =====================================================
                  if (participants.isNotEmpty) ...[
                    const SizedBox(height: 26),
                    _sectionHeader(
                      context,
                      icon: Icons.groups_outlined,
                      title: "Participants".tr(),
                    ),
                    const SizedBox(height: 12),
                    ...participants.map(
                      (participant) => _buildParticipantCard(
                        context,
                        participant,
                      ),
                    ),
                  ],

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(
    BuildContext context,
    dynamic lottery,
  ) {
    final status = lottery.status ?? "";

    final bool isCompleted = status.toString().toLowerCase() == "completed";

    final Color statusColor = isCompleted ? Colors.green : Colors.orange;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              context.isDark ? .25 : .06,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.10),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  Icons.emoji_events_outlined,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  lottery.title ?? "Lottery".tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: context.textColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(.10),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  status.isEmpty ? "Unknown".tr() : status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Divider(
            height: 1,
            color: context.isDark
                ? Colors.white.withOpacity(.08)
                : Colors.grey.withOpacity(.15),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 17,
                color: context.subTextColor,
              ),
              const SizedBox(width: 8),
              Text(
                "Created".tr(),
                style: TextStyle(
                  color: context.subTextColor,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                lottery.createdAt ?? "-",
                style: TextStyle(
                  color: context.textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.textColor,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // UNIT CARD
  // ============================================================

  Widget _buildUnitCard(
    BuildContext context,
    LotteryModel lottery,
  ) {
    final unit = lottery.unit;

    if (unit == null) {
      return _smallEmptyCard(
        context,
        icon: Icons.home_work_outlined,
        text: "No unit information available".tr(),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: context.isDark
              ? Colors.white.withOpacity(.06)
              : Colors.grey.withOpacity(.10),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _unitInfo(
                  context,
                  Icons.home_work_outlined,
                  "Unit".tr(),
                  unit.unitNumber,
                ),
              ),
              Expanded(
                child: _unitInfo(
                  context,
                  Icons.layers_outlined,
                  "Floor".tr(),
                  unit.floor?.toString() ?? "-",
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _unitInfo(
                  context,
                  Icons.square_foot,
                  "Area".tr(),
                  unit.area == null ? "-" : "${unit.area} ${"m²".tr()}",
                ),
              ),
              Expanded(
                child: _unitInfo(
                  context,
                  Icons.meeting_room_outlined,
                  "Rooms".tr(),
                  unit.roomsCount?.toString() ?? "-",
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _priceBox(
            context,
            unit,
          ),
        ],
      ),
    );
  }

  Widget _unitInfo(
    BuildContext context,
    IconData icon,
    String title,
    String? value,
  ) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.08),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 19,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: context.subTextColor,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value ?? "-",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _priceBox(
    BuildContext context,
    dynamic unit,
  ) {
    final hasOffer = unit.hasActiveOffer == true;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(.07),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.10),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: AppColors.primary,
              size: 21,
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
                const SizedBox(height: 3),
                if (hasOffer)
                  Text(
                    "${unit.originalPrice ?? "-"}",
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 11,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Text(
                  "${unit.currentPrice ?? "-"}",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (hasOffer)
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
                "-${unit.discountPercentage ?? 0}%",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // RULE CARD
  // ============================================================

  Widget _buildRuleCard(
    BuildContext context,
    dynamic rule,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: AppColors.primary,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "${rule.ruleKey ?? "-"} "
              "${rule.operator ?? ""} "
              "${rule.ruleValue ?? ""}",
              style: TextStyle(
                color: context.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PARTICIPANT
  // ============================================================

  Widget _buildParticipantCard(
    BuildContext context,
    dynamic participant,
  ) {
    final bool isWinner = participant.isWinner == true;

    final name = participant.client?.account?.fullName ?? "Participant".tr();

    final job = participant.client?.additionalInfo?.jobTitle;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isWinner
              ? Colors.amber.withOpacity(.55)
              : context.isDark
                  ? Colors.white.withOpacity(.06)
                  : Colors.grey.withOpacity(.10),
          width: isWinner ? 1.5 : 1,
        ),
        boxShadow: [
          if (isWinner)
            BoxShadow(
              color: Colors.amber.withOpacity(.10),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isWinner
                  ? Colors.amber.withOpacity(.15)
                  : AppColors.primary.withOpacity(.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isWinner ? Icons.emoji_events : Icons.person_outline,
              color: isWinner ? Colors.amber.shade700 : AppColors.primary,
              size: 23,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (job != null && job.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    job,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isWinner)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "WINNER".tr(),
                style: TextStyle(
                  color: Colors.amber.shade800,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY
  // ============================================================

  Widget _smallEmptyCard(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: context.subTextColor,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: context.subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EMPTY VIEW
// ============================================================

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
            child: Icon(
              Icons.emoji_events_outlined,
              size: 42,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No Data".tr(),
            style: TextStyle(
              color: context.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ERROR VIEW
// ============================================================

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorView({
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 38,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

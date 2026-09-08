import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';

import '../logic/appointment_cubit.dart';
import '../logic/appointment_state.dart';
import '../logic/cancel_appointment_cubit.dart';
import '../logic/cancel_appointment_state.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AppointmentCubit>()..getMyAppointments(),
        ),
        BlocProvider(
          create: (_) => getIt<CancelAppointmentCubit>(),
        ),
      ],
      child: const _AppointmentsView(),
    );
  }
}

class _AppointmentsView extends StatelessWidget {
  const _AppointmentsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CancelAppointmentCubit, CancelAppointmentState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (cancelledAppointmentId, message) {
            Navigator.pushReplacementNamed(
              context,
              Routes.createAppointment,
            );
          },

          error: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                ),
              );
          },
        );
      },
      child: Scaffold(
        backgroundColor: context.bgColor,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.bgColor,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "My Appointments".tr(),
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          elevation: 5,
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              Routes.createAppointment,
            );

            if (context.mounted) {
              context.read<AppointmentCubit>().getMyAppointments();
            }
          },
          icon: const Icon(
            Icons.add_rounded,
            color: Colors.white,
          ),
          label: Text(
            "Create Appointment".tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        body: BlocBuilder<AppointmentCubit, AppointmentState>(
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
                  context
                      .read<AppointmentCubit>()
                      .getMyAppointments();
                },
              ),

              success: (appointments) {
                if (appointments.isEmpty) {
                  return const _EmptyAppointments();
                }

                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () {
                    return context
                        .read<AppointmentCubit>()
                        .getMyAppointments();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      100,
                    ),
                    physics:
                    const AlwaysScrollableScrollPhysics(),
                    itemCount: appointments.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return _AppointmentCard(
                        appointment: appointments[index],
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// =======================================================
/// APPOINTMENT CARD
/// =======================================================

class _AppointmentCard extends StatelessWidget {
  final dynamic appointment;

  const _AppointmentCard({
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final status = appointment.status ?? "unknown".tr();
    final type = appointment.type ?? "appointment".tr();

    final statusColor = _statusColor(status);

    final canCancel = status.toLowerCase() == "pending" ||
        status.toLowerCase() == "confirmed" ||
        status.toLowerCase() == "accepted";

    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: context.isDark
              ? Colors.white.withOpacity(.06)
              : Colors.black.withOpacity(.045),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              context.isDark ? .18 : .045,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ================= HEADER =================
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              14,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatType(type),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (appointment.createdAt != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          "Created".tr()+" ${appointment.createdAt}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: context.subTextColor,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                /// STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.10),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    _formatStatus(status),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: context.isDark
                ? Colors.white.withOpacity(.06)
                : Colors.black.withOpacity(.05),
          ),

          /// ================= DATE + TIME =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                color: context.isDark
                    ? Colors.white.withOpacity(.035)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _InfoItem(
                      icon: Icons.event_outlined,
                      title: "Date".tr(),
                      value: appointment.slot?.date ?? "-",
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 38,
                    color: context.isDark
                        ? Colors.white.withOpacity(.08)
                        : Colors.black.withOpacity(.06),
                  ),
                  Expanded(
                    child: _InfoItem(
                      icon: Icons.access_time_rounded,
                      title: "Time".tr(),
                      value: _formatTime(
                        appointment.slot?.startTime,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ================= ORDER =================
          if (appointment.order != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                12,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: context.isDark
                      ? Colors.white.withOpacity(.035)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.receipt_long_outlined,
                        size: 17,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      "Order #".tr()+"${appointment.order?.id ?? "-"}",
                      style: TextStyle(
                        color: context.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatType(
                        appointment.order?.type ?? "-",
                      ),
                      style: TextStyle(
                        color: context.subTextColor,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          /// ================= NOTES =================
          if (appointment.notes != null && appointment.notes!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                14,
              ),
              child: Column(
                children: appointment.notes!
                    .map<Widget>(
                      (note) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 7),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(.055),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              size: 17,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                note.text ?? "",
                                style: TextStyle(
                                  color: context.textColor,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

          /// ================= CANCEL =================
          if (canCancel)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                16,
              ),
              child: _CancelButton(
                appointmentId: appointment.id,
              ),
            ),
        ],
      ),
    );
  }

  static Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;

      case "confirmed":
      case "accepted":
        return Colors.green;

      case "completed":
        return Colors.blue;

      case "cancelled":
      case "canceled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  static String _formatStatus(String status) {
    return status
        .replaceAll("_", " ")
        .split(" ")
        .map(
          (word) =>
              word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1),
        )
        .join(" ");
  }

  static String _formatType(String type) {
    return type
        .replaceAll("_", " ")
        .split(" ")
        .map(
          (word) =>
              word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1),
        )
        .join(" ");
  }

  static String _formatTime(String? time) {
    if (time == null || time.isEmpty) {
      return "-";
    }

    final parts = time.split(":");

    if (parts.length < 2) {
      return time;
    }

    final hour = int.tryParse(parts[0]);

    if (hour == null) {
      return time;
    }

    final minute = parts[1];

    final period = hour >= 12 ? "PM" : "AM";

    final displayHour = hour % 12 == 0 ? 12 : hour % 12;

    return "$displayHour:$minute $period";
  }
}

/// =======================================================
/// CANCEL BUTTON
/// =======================================================


class _CancelButton extends StatelessWidget {
  final int appointmentId;

  const _CancelButton({
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CancelAppointmentCubit, CancelAppointmentState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (cancelledAppointmentId, message) {
            if (cancelledAppointmentId != appointmentId) {
              return;
            }

            Navigator.pushReplacementNamed(
              context,
              Routes.createAppointment,
            );
          },

          error: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (loadingAppointmentId) =>
          loadingAppointmentId == appointmentId,
          orElse: () => false,
        );
        return SizedBox(
          width: double.infinity,
          height: 44,
          child: OutlinedButton.icon(
            onPressed: isLoading
                ? null
                : () => _showCancelDialog(context),
            icon: isLoading
                ? const SizedBox(
              width: 17,
              height: 17,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.red,
              ),
            )
                : const Icon(
              Icons.event_busy_outlined,
              size: 18,
            ),
            label: Text(
              isLoading
                  ? "Cancelling...".tr()
                  : "Cancel Appointment".tr(),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: BorderSide(
                color: Colors.red.withOpacity(.25),
              ),
              backgroundColor: Colors.red.withOpacity(.035),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showCancelDialog(
      BuildContext context,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: context.cardColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.event_busy_outlined,
                  color: Colors.red,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Cancel Appointment?".tr(),
                  style: TextStyle(
                    color: context.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            "By cancelling this appointment, you will need to book another appointment. Do you want to continue?"
                .tr(),
            style: TextStyle(
              color: context.subTextColor,
              height: 1.5,
              fontSize: 14,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            12,
            0,
            12,
            12,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: Text(
                "Keep Appointment".tr(),
                style: TextStyle(
                  color: context.subTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Yes, Cancel".tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      context
          .read<CancelAppointmentCubit>()
          .cancelAppointment(appointmentId);
    }
  }
}

/// =======================================================
/// INFO ITEM
/// =======================================================

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.09),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 18,
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
                  fontSize: 10.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.textColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// =======================================================
/// EMPTY
/// =======================================================

class _EmptyAppointments extends StatelessWidget {
  const _EmptyAppointments();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today_outlined,
                size: 42,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              "No Appointments".tr(),
              style: TextStyle(
                color: context.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You don't have any appointments yet.".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Create your first appointment using the button below.".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// ERROR
/// =======================================================

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
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textColor,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              label:  Text("Retry".tr()),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(
                  color: AppColors.primary.withOpacity(.25),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

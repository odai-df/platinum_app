import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';

import '../data/models/payment_contract_model.dart';
import '../data/models/payment_model.dart';

import '../logic/payment_cubit.dart';
import '../logic/payment_state.dart';
import '../logic/upload_payment_file_cubit.dart';
import '../logic/upload_payment_file_state.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<PaymentCubit>()..getPayments(),
        ),
        BlocProvider(
          create: (_) => getIt<UploadPaymentFileCubit>(),
        ),
      ],
      child: const _PaymentView(),
    );
  }
}

class _PaymentView extends StatelessWidget {
  const _PaymentView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadPaymentFileCubit, UploadPaymentFileState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (paymentId, data) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                 SnackBar(
                  content: Text(
                    'Payment files uploaded successfully'.tr(),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );

            context.read<PaymentCubit>().getPayments();
          },

          error: (paymentId, message) {
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
      child: Scaffold(
        backgroundColor: context.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.bgColor,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Payments".tr(),
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
              error: (message) {
                return _ErrorView(
                  message: message,
                  onRetry: () {
                    context.read<PaymentCubit>().getPayments();
                  },
                );
              },
              success: (contracts) {
                if (contracts.isEmpty) {
                  return const _EmptyPayments();
                }

                return DefaultTabController(
                  length: contracts.length,
                  child: Column(
                    children: [
                      /// ================= CONTRACT TABS =================

                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          8,
                          16,
                          12,
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: context.isDark
                                ? Colors.white.withOpacity(.04)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TabBar(
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: context.subTextColor,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            padding: const EdgeInsets.all(4),
                            tabs: contracts.map((contract) {
                              return Tab(
                                text: "Contract #".tr()+"${contract.contractId ?? '-'}",
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      /// ================= CONTRACT CONTENT =================

                      Expanded(
                        child: TabBarView(
                          children: contracts.map((contract) {
                            return _ContractTab(
                              contract: contract,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
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

/// ============================================================
/// CONTRACT TAB
/// ============================================================

class _ContractTab extends StatelessWidget {
  final PaymentContractModel contract;

  const _ContractTab({
    required this.contract,
  });

  @override
  Widget build(BuildContext context) {
    final payments = contract.payments ?? [];

    final paidPayments = payments
        .where(
          (payment) =>
      payment.status?.toLowerCase().trim() == 'paid',
    )
        .toList();

    final pendingPayments = payments
        .where(
          (payment) =>
      payment.status?.toLowerCase().trim() == 'pending',
    )
        .toList();

    final approvalPayments = payments
        .where(
          (payment) =>
      payment.status?.toLowerCase().trim() ==
          'pending_approval',
    )
        .toList();

    final totalAmount = payments.fold<double>(
      0,
          (sum, payment) =>
      sum + _parseAmount(payment.amount),
    );

    final paidAmount = paidPayments.fold<double>(
      0,
          (sum, payment) =>
      sum + _parseAmount(payment.amount),
    );

    final pendingAmount = pendingPayments.fold<double>(
      0,
          (sum, payment) =>
      sum + _parseAmount(payment.amount),
    );

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              4,
              16,
              12,
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: context.isDark
                      ? Colors.white.withOpacity(.06)
                      : Colors.black.withOpacity(.04),
                ),
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
                      Icons.receipt_long_rounded,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contract".tr(),
                          style: TextStyle(
                            color: context.subTextColor,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "#${_englishDigits(contract.contractId?.toString() ?? '-')}",
                          style: TextStyle(
                            color: context.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${payments.length} ${"Payments".tr()}",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    title: "Total".tr(),
                    value: _formatMoney(totalAmount),
                    icon:
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryItem(
                    title: "Paid".tr(),
                    value: _formatMoney(paidAmount),
                    icon: Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryItem(
                    title: "Pending".tr(),
                    value: _formatMoney(pendingAmount),
                    icon: Icons.schedule_rounded,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: context.isDark
                    ? Colors.white.withOpacity(.04)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(13),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: context.subTextColor,
                padding: const EdgeInsets.all(4),
                tabs: [
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Paid".tr(),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${paidPayments.length})",
                          ),
                        ],
                      ),
                    ),
                  ),

                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Pending".tr(),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${pendingPayments.length})",
                          ),
                        ],
                      ),
                    ),
                  ),

                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.hourglass_top_rounded,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Awaiting Approval".tr(),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${approvalPayments.length})",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: TabBarView(
              children: [
                _PaymentList(
                  payments: paidPayments,
                ),

                _PaymentList(
                  payments: pendingPayments,
                ),

                _PaymentList(
                  payments: approvalPayments,
                  emptyTitle: "No payments awaiting approval",
                  emptySubtitle: "There are no payments waiting for approval.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentList extends StatelessWidget {
  final List<PaymentModel> payments;
  final String emptyTitle;
  final String emptySubtitle;

  const _PaymentList({
    required this.payments,
    this.emptyTitle = "No payments available",
    this.emptySubtitle =
    "There are no payments in this category.",
  });

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 50,
                color: context.subTextColor,
              ),

              const SizedBox(height: 14),

              Text(
                emptyTitle.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                emptySubtitle.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.subTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () {
        return context
            .read<PaymentCubit>()
            .getPayments();
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          16,
          4,
          16,
          30,
        ),
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];

          return _PaymentTimelineItem(
            payment: payment,
            isLast: index == payments.length - 1,
          );
        },
      ),
    );
  }
}
/// ============================================================
/// PAYMENT ITEM
/// ============================================================

class _PaymentTimelineItem extends StatelessWidget {
  final PaymentModel payment;
  final bool isLast;

  const _PaymentTimelineItem({
    required this.payment,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final paymentStatus =
    payment.status?.toLowerCase().trim();

    final isPaid = paymentStatus == 'paid';
    final isPendingApproval =
        paymentStatus == 'pending_approval';

    final statusColor = isPaid
        ? Colors.green
        : isPendingApproval
        ? Colors.blue
        : Colors.orange;

    final attachments = payment.attachments ?? [];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= TIMELINE =================

          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withOpacity(.25),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: context.isDark
                          ? Colors.white12
                          : Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// ================= PAYMENT CARD =================

          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 14,
              ),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: context.isDark
                      ? Colors.white.withOpacity(.06)
                      : Colors.grey.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  /// HEADER

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _paymentType(
                            payment.paymentType,
                          ),
                          style: TextStyle(
                            color: context.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      _StatusBadge(
                        status: payment.status,
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  /// AMOUNT

                  Text(
                    _formatMoney(
                      _parseAmount(payment.amount),
                    ),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// DATE

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 15,
                        color: context.subTextColor,
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          _formatDate(
                            payment.paymentDate,
                          ),
                          style: TextStyle(
                            color: context.subTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  /// PAYMENT METHOD

                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 16,
                        color: context.subTextColor,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        _capitalize(
                          payment.paymentMethod,
                        ),
                        style: TextStyle(
                          color: context.subTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  /// EMPLOYEE

                  if (payment.employee != null &&
                      payment.employee!.isNotEmpty) ...[
                    const SizedBox(height: 7),

                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 16,
                          color: context.subTextColor,
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            payment.employee!,
                            style: TextStyle(
                              color: context.subTextColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  /// FILES

                  if (attachments.isNotEmpty) ...[
                    const SizedBox(height: 12),

                    ...attachments.map(
                          (attachment) {
                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 7,
                          ),
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary
                                .withOpacity(.06),
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                attachment.type == 'image'
                                    ? Icons.image_outlined
                                    : Icons
                                    .insert_drive_file_outlined,
                                size: 19,
                                color: AppColors.primary,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  attachment.originalName ??
                                      "Attachment".tr(),
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color:
                                    context.textColor,
                                    fontSize: 11.5,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 5),
                  ],

                  /// UPLOAD ONLY FOR PENDING

                  if (!isPaid)
                    _UploadPaymentButton(
                      paymentId: payment.id,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// UPLOAD BUTTON
/// ============================================================

class _UploadPaymentButton extends StatelessWidget {
  final int? paymentId;

  const _UploadPaymentButton({
    required this.paymentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPaymentFileCubit,
        UploadPaymentFileState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (loadingPaymentId) =>
          loadingPaymentId == paymentId,
          orElse: () => false,
        );

        return SizedBox(
          width: double.infinity,
          height: 43,
          child: OutlinedButton.icon(
            onPressed: paymentId == null || isLoading
                ? null
                : () => _pickFiles(context),

            icon: isLoading
                ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            )
                : const Icon(
              Icons.upload_file_outlined,
              size: 18,
            ),

            label: Text(
              isLoading
                  ? "Uploading...".tr()
                  : "Upload Payment File".tr(),
            ),

            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(
                color: AppColors.primary.withOpacity(.25),
              ),
              backgroundColor:
              AppColors.primary.withOpacity(.035),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFiles(BuildContext context) async {
    try {
      final result = await FilePicker.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final files = result.files
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList();

      if (files.isEmpty || paymentId == null) {
        return;
      }

      await context
          .read<UploadPaymentFileCubit>()
          .uploadFiles(
        paymentId: paymentId!,
        files: files,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

/// ============================================================
/// SUMMARY
/// ============================================================

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 10.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// STATUS
/// ============================================================

class _StatusBadge extends StatelessWidget {
  final String? status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final normalized =
    status?.toLowerCase().trim();

    late final Color color;
    late final IconData icon;
    late final String text;

    switch (normalized) {
      case 'paid':
        color = Colors.green;
        icon = Icons.check_circle;
        text = "Paid".tr();
        break;

      case 'pending_approval':
        color = Colors.blue;
        icon = Icons.hourglass_top_rounded;
        text = "Awaiting Approval".tr();
        break;

      case 'pending':
      default:
        color = Colors.orange;
        icon = Icons.schedule;
        text = "Pending".tr();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// EMPTY
/// ============================================================

class _EmptyPayments extends StatelessWidget {
  const _EmptyPayments();

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
                Icons.receipt_long_outlined,
                size: 42,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "No Payments Yet".tr(),
              style: TextStyle(
                color: context.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your payment information will appear here.".tr(),
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

/// ============================================================
/// ERROR
/// ============================================================

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
                color: context.subTextColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label:  Text("Retry".tr()),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// HELPERS
/// ============================================================

double _parseAmount(String? value) {
  if (value == null || value.isEmpty) {
    return 0;
  }

  return double.tryParse(value) ?? 0;
}

String _formatMoney(double amount) {
  return NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  ).format(amount);
}

String _formatDate(String? value) {
  if (value == null || value.isEmpty) {
    return "-";
  }

  try {
    final date = DateTime.parse(value);

    return DateFormat(
      'dd MMM yyyy',
      'en_US',
    ).format(date);
  } catch (_) {
    return _englishDigits(value);
  }
}

String _englishDigits(String value) {
  const arabicDigits = '٠١٢٣٤٥٦٧٨٩';
  const persianDigits = '۰۱۲۳۴۵۶۷۸۹';
  const englishDigits = '0123456789';

  var result = value;

  for (int i = 0; i < 10; i++) {
    result = result.replaceAll(
      arabicDigits[i],
      englishDigits[i],
    );

    result = result.replaceAll(
      persianDigits[i],
      englishDigits[i],
    );
  }

  return result;
}
String _paymentType(String? value) {
  if (value == null || value.isEmpty) {
    return "Payment".tr();
  }

  switch (value.toLowerCase()) {
    case 'down_payment':
      return "Down Payment".tr();

    case 'installment':
      return "Installment".tr();

    default:
      return _capitalize(value);
  }
}

String _capitalize(String? value) {
  if (value == null || value.isEmpty) {
    return "-";
  }

  return value
      .replaceAll('_', ' ')
      .split(' ')
      .map(
        (word) => word.isEmpty
            ? ''
            : word[0].toUpperCase() + word.substring(1).toLowerCase(),
      )
      .join(' ');
}

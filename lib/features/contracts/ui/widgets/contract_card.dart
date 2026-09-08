import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';
import '../../data/models/contract_model.dart';

class ContractCard extends StatelessWidget {
  final ContractModel contract;

  const ContractCard({
    super.key,
    required this.contract,
  });

  Color _statusColor() {
    switch (contract.order?.status) {
      case "initially_accepted":
        return Colors.orange;

      case "completed":
        return Colors.green;

      case "cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.contractDetails,
            arguments: contract.id,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 18,
          ),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  context.isDark ? .3 : .08,
                ),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contract #".tr()+"${contract.id}",
                          style: TextStyle(
                            color: context.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          contract.createdAt ?? "",
                          style: TextStyle(
                            color: context.subTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      contract.order?.status
                              ?.replaceAll("_", " ")
                              .toUpperCase() ??
                          "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _infoRow(
                context,
                Icons.payments_outlined,
                "Total Price".tr(),
                contract.totalPrice ?? "-",
              ),
              const SizedBox(height: 12),
              _infoRow(
                context,
                Icons.account_balance_wallet_outlined,
                "Down Payment".tr(),
                "${contract.downPaymentAmount ?? 0}",
              ),
              const SizedBox(height: 12),
              _infoRow(
                context,
                Icons.calendar_month,
                "Installments".tr(),
                "${contract.installmentsCount ?? 0} "+"Months".tr(),
              ),
            ],
          ),
        ));
  }

  Widget _infoRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: context.subTextColor,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

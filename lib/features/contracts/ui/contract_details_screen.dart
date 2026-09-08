import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/theme_extension.dart';
import '../../../../core/theming/app_colors.dart';
import '../data/models/contract_details_payment.dart';
import '../logic/contract_cubit.dart';
import '../logic/contract_state.dart';

class ContractDetailsScreen extends StatelessWidget {
  const ContractDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.bgColor,
        title: Text(
          "Contract Details".tr(),
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ContractCubit, ContractState>(
        builder: (context, state) {
          final cubit = context.read<ContractCubit>();

          if (state is ContractLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final contract = cubit.contractDetails;

          if (contract == null) {
            return  Center(
              child: Text(
                "No Contract Data".tr(),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerCard(
                  context,
                  contract.status ?? "",
                  contract.id.toString(),
                ),
                const SizedBox(height: 20),
                _sectionTitle(
                  context,
                  "Client Information".tr(),
                ),
                _infoCard(
                  context,
                  Icons.person,
                  contract.client?.account?.fullName ?? "-",
                  contract.client?.account?.email ?? "",
                ),
                const SizedBox(height: 20),
                _sectionTitle(
                  context,
                  "Contract Summary".tr(),
                ),
                _summaryCard(context, contract),
                const SizedBox(height: 20),
                _sectionTitle(
                  context,
                  "Payment Schedule".tr(),
                ),
                ...contract.payments!.map(
                  (payment) => _paymentCard(
                    context,
                    payment,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerCard(
    BuildContext context,
    String status,
    String id,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.description,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Contract".tr(),
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  "#${id}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _sectionTitle(
    BuildContext context,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: context.textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoCard(
    BuildContext context,
    IconData icon,
    String title,
    String sub,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: context.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sub,
                style: TextStyle(
                  color: context.subTextColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _summaryCard(
    BuildContext context,
    dynamic contract,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          _row(
            context,
            "Total Price".tr(),
            contract.totalPrice,
          ),
          _row(
            context,
            "Down Payment".tr(),
            contract.downPaymentAmount.toString(),
          ),
          _row(
            context,
            "Installments".tr(),
            contract.installmentsCount.toString(),
          ),
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.subTextColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentCard(
    BuildContext context,
    ContractDetailsPayment payment,
  ) {
    final paid = payment.status == "paid".tr();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: (paid ? Colors.green : Colors.orange).withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              paid ? Icons.check : Icons.schedule,
              color: paid ? Colors.green : Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.paymentType ?? "",
                  style: TextStyle(
                    color: context.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  payment.paymentDate ?? "",
                  style: TextStyle(
                    color: context.subTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            payment.amount ?? "",
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

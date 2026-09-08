import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theming/theme_extension.dart';
import '../logic/contract_cubit.dart';
import '../logic/contract_state.dart';
import 'widgets/contract_card.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.bgColor,
        centerTitle: true,
        title: Text(
          "My Contracts".tr(),
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<ContractCubit, ContractState>(
        listener: (context, state) {
          if (state is ContractError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ContractCubit>();

          if (state is ContractLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ContractEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 90,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No Contracts Yet".tr(),
                    style: TextStyle(
                      color: context.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cubit.contracts.length,
            itemBuilder: (context, index) {
              final contract = cubit.contracts[index];

              return ContractCard(
                contract: contract,
              );
            },
          );
        },
      ),
    );
  }
}

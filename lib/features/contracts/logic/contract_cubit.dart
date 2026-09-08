import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/contract_details_model.dart';
import '../data/models/contract_model.dart';
import '../data/repo/contract_repo.dart';
import 'contract_state.dart';

class ContractCubit extends Cubit<ContractState> {
  final ContractRepo contractRepo;

  ContractCubit(
    this.contractRepo,
  ) : super(
          ContractInitial(),
        );

  List<ContractModel> contracts = [];

  Future<void> getContracts() async {
    emit(
      ContractLoading(),
    );

    final result = await contractRepo.getContracts();

    result.when(
      success: (response) {
        print("CONTRACT RESPONSE => ${response.data}");

        contracts = response.data ?? [];

        emit(
          ContractLoaded(),
        );
      },
      failure: (error) {
        print("CONTRACT FAILURE => ${error.apiErrorModel.message}");

        emit(
          ContractError(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }

  ContractDetailsModel? contractDetails;

  Future<void> getContractDetails(int id) async {
    emit(ContractLoading());

    final result = await contractRepo.getContractDetails(id);

    result.when(success: (response) {
      contractDetails = response.data;

      emit(ContractDetailsLoaded());
    }, failure: (error) {
      emit(ContractError(error.apiErrorModel.message ?? "Error"));
    });
  }
}

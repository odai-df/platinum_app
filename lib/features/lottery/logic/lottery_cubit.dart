import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/lottery_model.dart';
import '../data/repo/lottery_repo.dart';
import 'lottery_state.dart';

class LotteryCubit extends Cubit<LotteryState> {
  final LotteryRepo lotteryRepo;

  LotteryCubit(this.lotteryRepo)
      : super(const LotteryInitial());

  List<LotteryModel> lotteries = [];
  LotteryModel? lotteryDetails;

  Future<void> getLotteries() async {
    emit(const LotteryLoading());

    final result = await lotteryRepo.getLotteries();

    result.when(
      success: (response) {
        lotteries = response.data ?? [];

        emit(const LotterySuccess());
      },
      failure: (error) {
        emit(
          LotteryError(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }


  Future<void> getLotteryDetails(int id) async {
    emit(LotteryLoading());

    final result =
    await lotteryRepo.getLotteryDetails(id);

    result.when(
      success: (response) {
        lotteryDetails = response.data;

        emit(LotteryDetailsLoaded());
      },
      failure: (error) {
        emit(
          LotteryError(
            error.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }
}
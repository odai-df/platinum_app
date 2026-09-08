import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/offers_repo.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepo _repo;

  OffersCubit(this._repo) : super(const OffersState.initial());

  Future<void> getOffers() async {
    emit(const OffersState.loading());

    final result = await _repo.getOffers();

    result.when(
      success: (response) {
        emit(
          OffersState.success(
            response.data ?? [],
          ),
        );
      },
      failure: (error) {
        emit(
          OffersState.error(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }
}

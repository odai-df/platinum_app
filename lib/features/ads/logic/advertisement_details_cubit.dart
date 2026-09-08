import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/advertisements_repo.dart';
import 'advertisement_details_state.dart';

class AdvertisementDetailsCubit extends Cubit<AdvertisementDetailsState> {
  final AdvertisementsRepo _repo;

  AdvertisementDetailsCubit(this._repo)
      : super(const AdvertisementDetailsState.initial());

  Future<void> getDetails(int id) async {
    emit(const AdvertisementDetailsState.loading());

    final result = await _repo.getAdvertisementDetails(id);

    result.when(
      success: (data) {
        emit(
          AdvertisementDetailsState.success(data),
        );
      },
      failure: (error) {
        emit(
          AdvertisementDetailsState.error(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }
}

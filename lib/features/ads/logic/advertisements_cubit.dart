import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/advertisements_repo.dart';
import 'advertisements_state.dart';

class AdvertisementsCubit extends Cubit<AdvertisementsState> {
  final AdvertisementsRepo repo;

  AdvertisementsCubit(this.repo) : super(const AdvertisementsState.initial());

  Future<void> getAds() async {
    print("🚀 GET ADS CALLED");

    emit(const AdvertisementsState.loading());
    print("🟡 STATE: LOADING");

    final result = await repo.getActiveAds();

    print("📦 RESULT RECEIVED: $result");

    result.when(
      success: (data) {
        print("✅ SUCCESS");
        print("📊 ADS COUNT: ${data.length}");

        for (var ad in data) {
          print("🧾 AD ID: ${ad.id}");
          print("🧾 TITLE: ${ad.title}");
          print("🖼 ATTACHMENTS: ${ad.attachments.length}");
        }

        emit(AdvertisementsState.success(data));
        print("🟢 STATE: SUCCESS EMITTED");
      },
      failure: (error) {
        print("❌ ERROR OCCURRED");
        print("💥 MESSAGE: ${error.apiErrorModel.message}");

        emit(AdvertisementsState.error(
            error.apiErrorModel.message ?? "unknown error"));
      },
    );
  }
}

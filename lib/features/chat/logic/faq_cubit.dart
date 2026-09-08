import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/faq_model.dart';
import '../data/repo/faqRepo.dart';
import 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final FaqRepo faqRepo;

  FaqCubit(this.faqRepo)
      : super(
          const FaqState.initial(),
        );

  List<FaqModel> faqs = [];

  /// القائمة الرئيسية
  Future<void> getRootFaqs() async {
    emit(
      const FaqState.loading(),
    );

    final result = await faqRepo.getFaqRoot();

    result.when(
      success: (response) {
        faqs = response.data ?? [];

        emit(
          const FaqState.loaded(),
        );
      },
      failure: (error) {
        emit(
          FaqState.error(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }

  /// التفرعات
  ///
  /// مهم:
  /// ما منستخدم loading العادية هون
  /// حتى ما نعمل Refresh للشاشة كلها.
  Future<void> getChildren(int id) async {
    emit(
      const FaqState.childrenLoading(),
    );

    final result = await faqRepo.getFaqChildren(id);

    result.when(
      success: (response) {
        faqs = response.data ?? [];

        emit(
          const FaqState.loaded(),
        );
      },
      failure: (error) {
        emit(
          FaqState.error(
            error.apiErrorModel.message ?? "Something went wrong",
          ),
        );
      },
    );
  }

  Future<void> backToRoot() async {
    await getRootFaqs();
  }
}

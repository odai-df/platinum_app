import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_state.freezed.dart';

@freezed
class FaqState with _$FaqState {
  const factory FaqState.initial() = _Initial;

  /// أول تحميل للقائمة الرئيسية فقط
  const factory FaqState.loading() = _Loading;

  /// تحميل التفرعات بدون ما نخفي المحادثة
  const factory FaqState.childrenLoading() = _ChildrenLoading;

  const factory FaqState.loaded() = _Loaded;

  const factory FaqState.error(
      String message,
      ) = _Error;
}
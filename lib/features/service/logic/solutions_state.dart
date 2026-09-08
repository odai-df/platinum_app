import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/solution_model.dart';

part 'solutions_state.freezed.dart';

@freezed
class SolutionsState with _$SolutionsState {
  const factory SolutionsState.initial() = _Initial;
  const factory SolutionsState.loading() = _Loading;
  const factory SolutionsState.success(List<SolutionModel> data) = _Success;
  const factory SolutionsState.error(String message) = _Error;
}
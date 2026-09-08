import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/solution_details_model.dart';

part 'solution_details_state.freezed.dart';

@freezed
class SolutionDetailsState with _$SolutionDetailsState {
  const factory SolutionDetailsState.initial() = _Initial;
  const factory SolutionDetailsState.loading() = _Loading;
  const factory SolutionDetailsState.success(SolutionDetailsModel data) = _Success;
  const factory SolutionDetailsState.error(String message) = _Error;
}
import 'package:freezed_annotation/freezed_annotation.dart';
import 'solution_model.dart';

part 'solutions_response.freezed.dart';
part 'solutions_response.g.dart';

@freezed
class SolutionsResponse with _$SolutionsResponse {
  const factory SolutionsResponse({
    required String status,
    required String message,
    required List<SolutionModel> data,
  }) = _SolutionsResponse;

  factory SolutionsResponse.fromJson(Map<String, dynamic> json) =>
      _$SolutionsResponseFromJson(json);
}
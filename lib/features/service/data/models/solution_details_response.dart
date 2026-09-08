import 'package:freezed_annotation/freezed_annotation.dart';
import 'solution_details_model.dart';

part 'solution_details_response.freezed.dart';
part 'solution_details_response.g.dart';

@freezed
class SolutionDetailsResponse with _$SolutionDetailsResponse {
  const factory SolutionDetailsResponse({
    required String status,
    required String message,
    required SolutionDetailsModel data,
  }) = _SolutionDetailsResponse;

  factory SolutionDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$SolutionDetailsResponseFromJson(json);
}
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../ads/data/models/attachment_model.dart';

part 'solution_details_model.freezed.dart';

part 'solution_details_model.g.dart';

@freezed
class SolutionDetailsModel with _$SolutionDetailsModel {
  const factory SolutionDetailsModel({
    required int id,
    required String name,
    required String description,
    @JsonKey(name: 'original_price') required num originalPrice,
    @JsonKey(name: 'current_price') required num currentPrice,
    @JsonKey(name: 'has_active_offer') required bool hasActiveOffer,
    @JsonKey(name: 'discount_percentage') required num discountPercentage,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'created_from') required String createdFrom,
     List<AttachmentModel>? attachments,
  }) = _SolutionDetailsModel;

  factory SolutionDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SolutionDetailsModelFromJson(json);
}



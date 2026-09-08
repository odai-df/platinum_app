import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../ads/data/models/attachment_model.dart';

part 'solution_model.freezed.dart';
part 'solution_model.g.dart';

@freezed
class SolutionModel with _$SolutionModel {
  const factory SolutionModel({
    required int id,

    required String name,

    String? description,

    @JsonKey(name: 'original_price')
    required num originalPrice,

    @JsonKey(name: 'current_price')
    required num currentPrice,

    @JsonKey(name: 'has_active_offer')
    required bool hasActiveOffer,

    @JsonKey(name: 'discount_percentage')
    required int discountPercentage,

    @JsonKey(name: 'created_at')
    required String createdAt,

    @JsonKey(name: 'created_from')
    required String createdFrom,

    @Default([])
    List<AttachmentModel> attachments,
  }) = _SolutionModel;

  factory SolutionModel.fromJson(Map<String, dynamic> json) =>
      _$SolutionModelFromJson(json);
}
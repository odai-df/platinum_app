import 'package:json_annotation/json_annotation.dart';

import '../../../ads/data/models/attachment_model.dart';
import '../../../offers/data/models/offer_model.dart';

part 'my_solution_orders_response.g.dart';

@JsonSerializable()
class MySolutionOrdersResponse {
  final String status;
  final String message;
  final List<SolutionOrderModel> data;
  final PaginationLinksModel links;
  final PaginationMetaModel meta;

  MySolutionOrdersResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.links,
    required this.meta,
  });

  factory MySolutionOrdersResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MySolutionOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MySolutionOrdersResponseToJson(this);
}

/// ================= ORDER =================

@JsonSerializable()
class SolutionOrderModel {
  final int id;

  final SolutionModel solution;

  final String status;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  SolutionOrderModel({
    required this.id,
    required this.solution,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SolutionOrderModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SolutionOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolutionOrderModelToJson(this);
}

/// ================= SOLUTION =================

@JsonSerializable()
class SolutionModel {
  final int id;

  final String name;
  final String description;

  @JsonKey(name: 'original_price')
  final num originalPrice;

  @JsonKey(name: 'current_price')
  final num currentPrice;

  @JsonKey(name: 'has_active_offer')
  final bool hasActiveOffer;

  @JsonKey(name: 'discount_percentage')
  final int discountPercentage;

  final OfferModel? offer;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'created_from')
  final String createdFrom;

  final List<AttachmentModel> attachments;

  SolutionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.currentPrice,
    required this.hasActiveOffer,
    required this.discountPercentage,
    required this.offer,
    required this.createdAt,
    required this.createdFrom,
    required this.attachments,
  });

  factory SolutionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SolutionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolutionModelToJson(this);
}

/// ================= PAGINATION LINKS =================

@JsonSerializable()
class PaginationLinksModel {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  PaginationLinksModel({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory PaginationLinksModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaginationLinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationLinksModelToJson(this);
}

/// ================= PAGINATION META =================

@JsonSerializable()
class PaginationMetaModel {
  @JsonKey(name: 'current_page')
  final int currentPage;

  final int? from;

  @JsonKey(name: 'last_page')
  final int lastPage;

  final List<PaginationMetaLinkModel> links;

  final String path;

  @JsonKey(name: 'per_page')
  final int perPage;

  final int? to;

  final int total;

  PaginationMetaModel({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory PaginationMetaModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaginationMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaModelToJson(this);
}

/// ================= PAGINATION META LINK =================

@JsonSerializable()
class PaginationMetaLinkModel {
  final String? url;

  final String label;

  final int? page;

  final bool active;

  PaginationMetaLinkModel({
    required this.url,
    required this.label,
    required this.page,
    required this.active,
  });

  factory PaginationMetaLinkModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaginationMetaLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaLinkModelToJson(this);
}

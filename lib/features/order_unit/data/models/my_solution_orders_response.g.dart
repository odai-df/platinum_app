// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_solution_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySolutionOrdersResponse _$MySolutionOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    MySolutionOrdersResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => SolutionOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      links:
          PaginationLinksModel.fromJson(json['links'] as Map<String, dynamic>),
      meta: PaginationMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MySolutionOrdersResponseToJson(
        MySolutionOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'links': instance.links,
      'meta': instance.meta,
    };

SolutionOrderModel _$SolutionOrderModelFromJson(Map<String, dynamic> json) =>
    SolutionOrderModel(
      id: (json['id'] as num).toInt(),
      solution:
          SolutionModel.fromJson(json['solution'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$SolutionOrderModelToJson(SolutionOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'solution': instance.solution,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

SolutionModel _$SolutionModelFromJson(Map<String, dynamic> json) =>
    SolutionModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      originalPrice: json['original_price'] as num,
      currentPrice: json['current_price'] as num,
      hasActiveOffer: json['has_active_offer'] as bool,
      discountPercentage: (json['discount_percentage'] as num).toInt(),
      offer: json['offer'] == null
          ? null
          : OfferModel.fromJson(json['offer'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
      createdFrom: json['created_from'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SolutionModelToJson(SolutionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'original_price': instance.originalPrice,
      'current_price': instance.currentPrice,
      'has_active_offer': instance.hasActiveOffer,
      'discount_percentage': instance.discountPercentage,
      'offer': instance.offer,
      'created_at': instance.createdAt,
      'created_from': instance.createdFrom,
      'attachments': instance.attachments,
    };

PaginationLinksModel _$PaginationLinksModelFromJson(
        Map<String, dynamic> json) =>
    PaginationLinksModel(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );

Map<String, dynamic> _$PaginationLinksModelToJson(
        PaginationLinksModel instance) =>
    <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };

PaginationMetaModel _$PaginationMetaModelFromJson(Map<String, dynamic> json) =>
    PaginationMetaModel(
      currentPage: (json['current_page'] as num).toInt(),
      from: (json['from'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num).toInt(),
      links: (json['links'] as List<dynamic>)
          .map((e) =>
              PaginationMetaLinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String,
      perPage: (json['per_page'] as num).toInt(),
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationMetaModelToJson(
        PaginationMetaModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'from': instance.from,
      'last_page': instance.lastPage,
      'links': instance.links,
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
    };

PaginationMetaLinkModel _$PaginationMetaLinkModelFromJson(
        Map<String, dynamic> json) =>
    PaginationMetaLinkModel(
      url: json['url'] as String?,
      label: json['label'] as String,
      page: (json['page'] as num?)?.toInt(),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$PaginationMetaLinkModelToJson(
        PaginationMetaLinkModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'page': instance.page,
      'active': instance.active,
    };

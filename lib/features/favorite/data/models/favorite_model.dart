import 'package:json_annotation/json_annotation.dart';

import '../../../units/data/models/unit_model.dart';

part 'favorite_model.g.dart';

@JsonSerializable()
class FavoriteModel {

  final int id;

  final UnitModel unit;

  @JsonKey(name: 'created_at')
  final String createdAt;

  FavoriteModel({
    required this.id,
    required this.unit,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FavoriteModelToJson(this);
}
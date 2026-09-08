import 'package:json_annotation/json_annotation.dart';

import 'favorite_model.dart';

part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteResponse {

  final String status;

  final String message;

  final List<FavoriteModel> data;

  FavoriteResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FavoriteResponseToJson(this);
}
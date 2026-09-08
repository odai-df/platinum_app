import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  dynamic message;

  String? status;

  dynamic errors;
  final int? code;


  ApiErrorModel({
    this.message,
    this.status,
    this.errors,
    this.code
  });

  factory ApiErrorModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ApiErrorModelToJson(this);

  String get errorMessage {
    if (message is String) {
      return message;
    }

    if (message is Map<String, dynamic>) {
      final firstValue =
          (message as Map<String, dynamic>)
              .values
              .first;

      if (firstValue is List && firstValue.isNotEmpty) {
        return firstValue.first.toString();
      }

      return firstValue.toString();
    }

    return "Unknown error";
  }
}
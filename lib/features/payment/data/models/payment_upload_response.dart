import 'package:json_annotation/json_annotation.dart';

import '../../../ads/data/models/attachment_model.dart';


part 'payment_upload_response.g.dart';

@JsonSerializable()
class PaymentUploadResponse {
  final String? status;
  final String? message;
  final PaymentUploadData? data;

  const PaymentUploadResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PaymentUploadResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$PaymentUploadResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentUploadResponseToJson(this);
}

@JsonSerializable()
class PaymentUploadData {
  final int? id;
  final String? status;

  final List<AttachmentModel>? attachments;

  const PaymentUploadData({
    this.id,
    this.status,
    this.attachments,
  });

  factory PaymentUploadData.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$PaymentUploadDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentUploadDataToJson(this);
}
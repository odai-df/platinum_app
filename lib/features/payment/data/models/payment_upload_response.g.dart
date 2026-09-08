// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentUploadResponse _$PaymentUploadResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentUploadResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PaymentUploadData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentUploadResponseToJson(
        PaymentUploadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

PaymentUploadData _$PaymentUploadDataFromJson(Map<String, dynamic> json) =>
    PaymentUploadData(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentUploadDataToJson(PaymentUploadData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'attachments': instance.attachments,
    };

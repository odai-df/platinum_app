import 'package:json_annotation/json_annotation.dart';

part 'additional_info_model.g.dart';

@JsonSerializable()
class AdditionalInfoModel {
  @JsonKey(name: 'client_id')
  final int clientId;

  @JsonKey(name: 'birth_date')
  final String birthDate;

  @JsonKey(name: 'job_title')
  final String jobTitle;

  @JsonKey(name: 'social_status')
  final String socialStatus;

  @JsonKey(name: 'national_id')
  final String nationalId;

  AdditionalInfoModel({
    required this.clientId,
    required this.birthDate,
    required this.jobTitle,
    required this.socialStatus,
    required this.nationalId,
  });

  factory AdditionalInfoModel.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoModel(
      clientId: json['client_id'],
      birthDate: _parseBirthDate(json['birth_date']),
      jobTitle: json['job_title'] ?? '',
      socialStatus: json['social_status'] ?? '',
      nationalId: json['national_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$AdditionalInfoModelToJson(this);
}

String _parseBirthDate(dynamic value) {
  if (value is String) return value;

  if (value is Map && value['date'] != null) {
    return value['date'].toString().split(' ').first;
  }

  return '';
}
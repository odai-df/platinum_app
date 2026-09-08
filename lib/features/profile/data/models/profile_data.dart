import 'package:json_annotation/json_annotation.dart';

import 'account_model.dart';
import 'additional_info_model.dart';

part 'profile_data.g.dart';

@JsonSerializable()
class ProfileData {
  final AccountModel account;

  @JsonKey(name: 'additional_info')
  final AdditionalInfoModel additionalInfo;

  ProfileData({
    required this.account,
    required this.additionalInfo,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
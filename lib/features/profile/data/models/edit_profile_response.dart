import 'package:json_annotation/json_annotation.dart';
import 'package:platinum_app/features/profile/data/models/profile_data.dart';

part 'edit_profile_response.g.dart';

@JsonSerializable()
class EditProfileResponse {

  final String status;
  final String message;

  final ProfileData data;

  EditProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditProfileResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$EditProfileResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EditProfileResponseToJson(this);
}
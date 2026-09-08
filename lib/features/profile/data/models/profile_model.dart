import 'package:json_annotation/json_annotation.dart';
import 'package:platinum_app/features/profile/data/models/profile_data.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final ProfileData data;

  ProfileModel({
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
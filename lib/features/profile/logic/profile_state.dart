import '../data/models/profile_model.dart';

abstract class ProfileState {}

/// ===============================
/// INITIAL
/// ===============================

class ProfileInitial extends ProfileState {}

/// ===============================
/// GET PROFILE
/// ===============================

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

/// ===============================
/// EDIT PROFILE
/// ===============================

class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {
  final String message;

  EditProfileSuccess(this.message);
}

class EditProfileError extends ProfileState {
  final String message;

  EditProfileError(this.message);
}
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/edit_profile_request.dart';
import '../data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());

    final result = await profileRepo.getProfile();

    result.when(
      success: (profile) {
        emit(ProfileLoaded(profile));
      },
      failure: (error) {
        emit(ProfileError(error.apiErrorModel.message ?? "Something went wrong"));
      },
    );
  }


  Future<void> editProfile(
      EditProfileRequest request,
      ) async {

    emit(EditProfileLoading());

    final response =
    await profileRepo.editProfile(request);

    response.when(

      success: (res) {
        emit(EditProfileSuccess(res.message));
      },

      failure: (error) {

        emit(
          EditProfileError(
            error.apiErrorModel.message ??
                "Something went wrong",
          ),
        );

      },
    );
  }

}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/helpers/shared_pref_helper.dart';
import 'package:platinum_app/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:platinum_app/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:platinum_app/features/sign_up/logic/sign_up_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;

  SignupCubit(this._signupRepo)
      : super(const SignupState.initial());

  TextEditingController firstNameController =
  TextEditingController();

  TextEditingController lastNameController =
  TextEditingController();

  TextEditingController addressController =
  TextEditingController();

  TextEditingController birthDateController =
  TextEditingController();

  TextEditingController emailController =
  TextEditingController();

  TextEditingController phoneController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  TextEditingController passwordConfirmationController =
  TextEditingController();

  TextEditingController jobTitleController =
  TextEditingController();

  TextEditingController nationalIdController =
  TextEditingController();

  final formKey = GlobalKey<FormState>();

  String gender = "male";

  String socialStatus = "single";

  File? photo;

  void setPhoto(File file) {
    photo = file;
    emit(state);
  }

  void setGender(String value) {
    gender = value;
    emit(state);
  }

  void setSocialStatus(String value) {
    socialStatus = value;
    emit(state);
  }

  void emitSignupStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const SignupState.signupLoading());

    final requestBody = SignupRequestBody(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      address: addressController.text,
      birthDate: birthDateController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
      passwordConfirmation:
      passwordConfirmationController.text,
      gender: gender,
      jobTitle: jobTitleController.text,
      socialStatus: socialStatus,
      nationalId: nationalIdController.text,
      photo: photo,
    );

    print("Signup Request Body: ${requestBody.toJson()}");
    print("Signup Request File: $photo");

    final response =
    await _signupRepo.signup(requestBody, photo: photo);

    response.when(
      success: (signupResponse) async {
        await SharedPrefHelper.setData(
          'temp_user_id',
          signupResponse.data?.user?.account?.id,
        );

        await SharedPrefHelper.setData(
          'temp_email',
          emailController.text,
        );

        await SharedPrefHelper.setData(
          'otp_code',
          signupResponse.data?.otp,
        );

        emit(
          SignupState.signupSuccess(signupResponse),
        );
      },
      failure: (error) {
        emit(
          SignupState.signupError(
            error:
            error.apiErrorModel.errorMessage ?? '',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    jobTitleController.dispose();
    nationalIdController.dispose();

    return super.close();
  }
}
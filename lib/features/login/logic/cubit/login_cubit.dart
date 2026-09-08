import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/helpers/constants.dart';
import 'package:platinum_app/core/helpers/shared_pref_helper.dart';
import 'package:platinum_app/core/networking/dio_factory.dart';
import 'package:platinum_app/features/login/data/models/login_request_body.dart';
import 'package:platinum_app/features/login/data/repos/login_repo.dart';
import 'package:platinum_app/features/login/logic/cubit/login_state.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/notifications/firebase_notification_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());

    final response = await _loginRepo.login(
      LoginRequestBody(
        login: emailController.text,
        password: passwordController.text,
      ),
    );

    response.when(
      success: (loginResponse) async {

        /// 🔑 tokens (FIXED)
        final accessToken = loginResponse.data?.tokens?.accessToken;
        final refreshToken = loginResponse.data?.tokens?.refreshToken;

        if (accessToken == null || refreshToken == null) {
          emit(const LoginState.error(error: "Token missing from server"));
          return;
        }
        await saveUserToken(accessToken, refreshToken);

        /// 👤 user info
        final account = loginResponse.data?.user?.account;

        await SharedPrefHelper.setData(
          SharedPrefKeys.userName,
          account?.fullName ?? "",
        );

        await SharedPrefHelper.setData(
          SharedPrefKeys.email,
          account?.email ?? "",
        );

        await SharedPrefHelper.setData(
          SharedPrefKeys.phone,
          account?.phone ?? "",
        );

        await SharedPrefHelper.setData(
          SharedPrefKeys.userId,
          account?.id?.toString() ?? "",
        );

        print("User ID: ${account?.id}");
        await getIt<FirebaseNotificationService>().initialize();
        emit(LoginState.success(loginResponse));
      },

      failure: (error) {
        emit(
          LoginState.error(
            error: error.apiErrorModel.message ?? '',
          ),
        );
      },
    );
  }

  Future<void> saveUserToken(
    String access,
    String refresh,
  ) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.accessToken,
      access,
    );

    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.refreshToken,
      refresh,
    );

    DioFactory.setTokenIntoHeaderAfterLogin(access);
  }
}

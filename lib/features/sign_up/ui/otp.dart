import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:platinum_app/core/helpers/extensions.dart';
import '../../../core/routing/routes.dart';
import '../logic/otp_cubit.dart';
import '../logic/otp_state.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('otp_verification'.tr()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        // foregroundColor: Colors.blue,
      ),
      body: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          print("Current State: $state");
          if (state is OtpSuccess) {
            Future.microtask(() {
              showDialog(

                context: context,
                barrierDismissible: false,
                builder: (dialogContext) => AlertDialog(
                  backgroundColor: Colors.white,
                  title:  Row(
                    children: [
                      Icon(Icons.verified, color: Colors.green, size: 28),
                      SizedBox(width: 8),
                      Text('successfully_verified'.tr(), style: TextStyle(fontSize: 22),),
                    ],
                  ),
                  content:  Text(
                    'email_verified_success'.tr(),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    ElevatedButton.icon(
                      icon:  Icon(Icons.login),
                      label:  Text('login_now'.tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        textStyle:  TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        context.pushNamed(Routes.loginScreen);
                      },
                    ),
                  ],
                ),
              );
            });
          } else if (state is OtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'Verification failed')),
            );
            _otpController.clear();
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified_user, color: Colors.blue[700], size: 80),
                 SizedBox(height: 24),
                 Text(
                  "enter_verification_code".tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                 SizedBox(height: 16),
                PinCodeTextField(
                  appContext: context,
                  controller: _otpController,
                  length: 6,
                  autoFocus: true,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    activeColor: Colors.blue,
                    selectedColor: Colors.blue[700]!,
                    inactiveColor: Colors.grey[400]!,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: false,
                  onCompleted: (code) {
                    context.read<OtpCubit>().verifyOtp(code, widget.email);
                  },
                  onChanged: (_) {},
                ),
                 SizedBox(height: 24),
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    if (state is OtpLoading) {
                      return  CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon:  Icon(Icons.check_circle_outline),
                        label:  Text('verify'.tr()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding:  EdgeInsets.symmetric(vertical: 14),
                          textStyle:  TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          context.read<OtpCubit>().verifyOtp(
                            _otpController.text,
                            widget.email,
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  icon:  Icon(Icons.refresh),
                  label:  Text('resend_code'.tr()),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue[700],
                    textStyle:  TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    context.read<OtpCubit>().resendCode(widget.email );
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('code_resent'.tr())),
                    );
                  },
                ),
                 SizedBox(height: 8),
                 Text(
                  "didn't_receive_code".tr(),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

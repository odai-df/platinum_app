import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/sign_up_cubit.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPasswordObscureText = true;

  bool isPasswordConfirmationObscureText = true;

  File? selectedPhoto;

  final ImagePicker _picker = ImagePicker();

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    passwordController = context.read<SignupCubit>().passwordController;
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedPhoto = File(image.path);
      });

      context.read<SignupCubit>().setPhoto(
            selectedPhoto!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          // GestureDetector(
          //   onTap: pickImage,
          //   child: CircleAvatar(
          //     radius: 50,
          //     backgroundColor: Colors.grey[300],
          //     backgroundImage: selectedPhoto != null
          //         ? FileImage(selectedPhoto!)
          //         : null,
          //     child: selectedPhoto == null
          //         ? const Icon(
          //       Icons.camera_alt,
          //       size: 40,
          //       color: Colors.white,
          //     )
          //         : null,
          //   ),
          // ),

          verticalSpace(18),

          /// First Name
          AppTextFormField(
            hintText: 'first_name'.tr(),
            controller: cubit.firstNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'first_name_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Last Name
          AppTextFormField(
            hintText: 'last_name'.tr(),
            controller: cubit.lastNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'last_name_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Email
          AppTextFormField(
            hintText: 'email'.tr(),
            controller: cubit.emailController,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'email_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Address
          AppTextFormField(
            hintText: 'address'.tr(),
            controller: cubit.addressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'address_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Birth Date
          AppTextFormField(
            hintText: 'birth_date'.tr(),
            controller: cubit.birthDateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'birth_date_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Phone
          AppTextFormField(
            hintText: 'phone_number'.tr(),
            controller: cubit.phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'phone_number_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Job Title
          AppTextFormField(
            hintText: 'job_title'.tr(),
            controller: cubit.jobTitleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'job_title_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// National ID
          AppTextFormField(
            hintText: 'national_id'.tr(),
            controller: cubit.nationalIdController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'national_id_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Gender
          DropdownButtonFormField<String>(
            value: cubit.gender,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: "male",
                child: Text("Male".tr()),
              ),
              DropdownMenuItem(
                value: "female",
                child: Text("Female".tr()),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                cubit.setGender(value);
              }
            },
          ),

          verticalSpace(18),

          /// Social Status
          DropdownButtonFormField<String>(
            value: cubit.socialStatus,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: "single",
                child: Text("Single".tr()),
              ),
              DropdownMenuItem(
                value: "married",
                child: Text("Married".tr()),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                cubit.setSocialStatus(value);
              }
            },
          ),

          verticalSpace(18),

          /// Password
          AppTextFormField(
            controller: cubit.passwordController,
            hintText: 'password'.tr(),
            isObscureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'password_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(18),

          /// Password Confirmation
          AppTextFormField(
            controller: cubit.passwordConfirmationController,
            hintText: 'password_confirmation'.tr(),
            isObscureText: isPasswordConfirmationObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordConfirmationObscureText =
                      !isPasswordConfirmationObscureText;
                });
              },
              child: Icon(
                isPasswordConfirmationObscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value != cubit.passwordController.text) {
                return 'password_confirmation_error'.tr();
              }
              return null;
            },
          ),

          verticalSpace(20),
        ],
      ),
    );
  }
}

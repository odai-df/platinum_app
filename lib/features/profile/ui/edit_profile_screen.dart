import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/features/profile/data/models/profile_data.dart';

import '../data/models/edit_profile_request.dart';
import '../logic/profile_cubit.dart';
import '../logic/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileData profile;

  const EditProfileScreen({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final jobTitle = TextEditingController();
  final nationalId = TextEditingController();
  final birthDate = TextEditingController();
  final gender = TextEditingController();
  final socialStatus = TextEditingController();

  @override
  void initState() {
    super.initState();

    final account = widget.profile.account;
    final info = widget.profile.additionalInfo;

    final nameParts = account.fullName.split(" ");

    firstName.text = nameParts.first;
    lastName.text =
    nameParts.length > 1 ? nameParts.last : "";

    phone.text = account.phone;
    address.text = account.address;

    jobTitle.text = info.jobTitle;
    nationalId.text = info.nationalId;
    birthDate.text = info.birthDate;
    gender.text = account.type;
    socialStatus.text = info.socialStatus;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final profile = widget.profile;
    final account = profile.account;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff0F172A) : const Color(
          0xffF7F7FB),

      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );

            Navigator.pop(context, true);
          }

          if (state is EditProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        builder: (context, state) {
          final isLoading = state is EditProfileLoading;

          return SingleChildScrollView(
            child: Column(
              children: [

              /// =========================
              /// CUSTOM HEADER
              /// =========================
                /// ================= HEADER (SAME AS PROFILE) =================
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff1E3A8A),
                        Color(0xff3B82F6),
                        Color(0xff60A5FA),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [

                        /// TOP BAR (BACK ONLY)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),

                        /// AVATAR
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.blue.shade700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// NAME
                        Text(
                          account.fullName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        /// EMAIL
                        Text(
                          account.email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

            const SizedBox(height: 20),

            /// =========================
            /// FORM
            /// =========================
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                    _buildField(
                    title: "First Name".tr(),
                    icon: Icons.person,
                    controller: firstName,
                    isDark: isDark,
                  ),
                  _buildField(
                    title: "Last Name".tr(),
                    icon: Icons.person_outline,
                    controller: lastName,
                    isDark: isDark,
                  ),

                  _buildField(
                    title: "Phone".tr(),
                    icon: Icons.phone,
                    controller: phone,
                    isDark: isDark,
                    keyboardType: TextInputType.phone,
                  ),

                  _buildField(
                    title: "Address".tr(),
                    icon: Icons.location_on,
                    controller: address,
                    isDark: isDark,
                  ),

                  _buildField(
                    title: "Job Title".tr(),
                    icon: Icons.work,
                    controller: jobTitle,
                    isDark: isDark,
                  ),

                  _buildField(
                    title: "Birth Date".tr(),
                    icon: Icons.cake,
                    controller: birthDate,
                    isDark: isDark,
                  ),

                  _buildField(
                    title: "National ID".tr(),
                    icon: Icons.badge,
                    controller: nationalId,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 25),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                    if (!_formKey.currentState!.validate()) return;

                    final request = EditProfileRequest(
                      firstName: firstName.text,
                      lastName: lastName.text,
                      address: address.text,
                      birthDate: birthDate.text,
                      phone: phone.text,
                      gender: gender.text,
                      jobTitle: jobTitle.text,
                      socialStatus: socialStatus.text,
                      nationalId: nationalId.text,
                    );

                    context.read<ProfileCubit>().editProfile(request);
                  },
                  child: isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      :  Text(
                    "Save Changes".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),)
          ,
          ]
          ,
          )
          ,
          );
        },
      ),
    );
  }

  Widget _buildField({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isDark = false,
  }) {
    final borderColor = isDark ? Colors.white12 : Colors.grey.shade200;
    final fillColor = isDark ? const Color(0xff111827) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required".tr();
          }
          return null;
        },

        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(
            color: isDark ? Colors.white60 : Colors.grey,
          ),

          prefixIcon: Icon(
            icon,
            color: const Color(0xff2563EB),
          ),

          filled: true,
          fillColor: fillColor,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: borderColor),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xff2563EB),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
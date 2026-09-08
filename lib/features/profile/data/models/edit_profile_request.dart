class EditProfileRequest {
  final String firstName;
  final String lastName;
  final String address;
  final String birthDate;
  final String phone;
  final String gender;
  final String jobTitle;
  final String socialStatus;
  final String nationalId;

  EditProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.birthDate,
    required this.phone,
    required this.gender,
    required this.jobTitle,
    required this.socialStatus,
    required this.nationalId,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'birth_date': birthDate,
      'phone': phone,
      'gender': gender,
      'job_title': jobTitle,
      'social_status': socialStatus,
      'national_id': nationalId,
    };
  }
}
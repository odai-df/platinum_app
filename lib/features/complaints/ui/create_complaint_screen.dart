import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';

import '../data/models/complaint_type_model.dart';
import '../logic/complaint_types/complaint_types_cubit.dart';
import '../logic/complaint_types/complaint_types_state.dart';
import '../logic/create_complaint/create_complaint_cubit.dart';
import '../logic/create_complaint/create_complaint_state.dart';

class CreateComplaintScreen extends StatefulWidget {
  final int unitId;

  const CreateComplaintScreen({
    super.key,
    required this.unitId,
  });

  @override
  State<CreateComplaintScreen> createState() => _CreateComplaintScreenState();
}

class _CreateComplaintScreenState extends State<CreateComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  ComplaintTypeModel? selectedType;

  final List<File> selectedFiles = [];

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateComplaintCubit, CreateComplaintState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );

            Navigator.pop(context, true);
          },
          error: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          },
        );
      },
      child: Scaffold(
        backgroundColor: context.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.bgColor,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Submit Complaint".tr(),
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                16.w,
                10.h,
                16.w,
                30.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  SizedBox(height: 24.h),
                  _sectionTitle(
                    context,
                    "Complaint Type".tr(),
                    "Choose the category that best describes your complaint.".tr(),
                  ),
                  SizedBox(height: 12.h),
                  _buildComplaintTypes(context),
                  SizedBox(height: 24.h),
                  _sectionTitle(
                    context,
                    "Complaint Information".tr(),
                    "Tell us what happened.".tr(),
                  ),
                  SizedBox(height: 12.h),
                  _buildTitleField(context),
                  SizedBox(height: 14.h),
                  _buildBodyField(context),
                  SizedBox(height: 24.h),
                  _sectionTitle(
                    context,
                    "Attachments".tr(),
                    "Add photos or files to help explain the issue.".tr(),
                  ),
                  SizedBox(height: 12.h),
                  _buildAttachmentPicker(context),
                  if (selectedFiles.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    _buildSelectedFiles(context),
                  ],
                  SizedBox(height: 30.h),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(.10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.12),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: const Icon(
              Icons.report_problem_outlined,
              color: AppColors.primary,
              size: 25,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Report an Issue".tr(),
                  style: TextStyle(
                    color: context.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Submit a complaint about this property.".tr(),
                  style: TextStyle(
                    color: context.subTextColor,
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: context.textColor,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(
            color: context.subTextColor,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildComplaintTypes(BuildContext context) {
    return BlocBuilder<ComplaintTypesCubit, ComplaintTypesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => _buildTypesLoading(context),
          error: (message) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(.06),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.red.withOpacity(.12),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<ComplaintTypesCubit>().getComplaintTypes();
                  },
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          success: (types) {
            if (types.isEmpty) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "No complaint types available.".tr(),
                  style: TextStyle(
                    color: context.subTextColor,
                  ),
                ),
              );
            }

            return Column(
              children: types.map((type) {
                final selected = selectedType?.id == type.id;

                final title = type.title?.en?.trim().isNotEmpty == true
                    ? type.title!.en!
                    : "Complaint Type".tr();

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = type;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.all(13.w),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary.withOpacity(.08)
                            : context.cardColor,
                        borderRadius: BorderRadius.circular(17.r),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : context.isDark
                                  ? Colors.white.withOpacity(.07)
                                  : Colors.grey.shade200,
                          width: selected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42.w,
                            height: 42.w,
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary.withOpacity(.12)
                                  : context.isDark
                                      ? Colors.white.withOpacity(.05)
                                      : Colors.grey.withOpacity(.07),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.category_outlined,
                              color: selected
                                  ? AppColors.primary
                                  : context.subTextColor,
                            ),
                          ),
                          SizedBox(width: 11.w),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: context.textColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: 22.w,
                            height: 22.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : context.subTextColor.withOpacity(.35),
                              ),
                            ),
                            child: selected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildTypesLoading(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Container(
          margin: EdgeInsets.only(bottom: 10.h),
          height: 70.h,
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(17.r),
          ),
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField(BuildContext context) {
    return TextFormField(
      controller: _titleController,
      style: TextStyle(
        color: context.textColor,
        fontSize: 14.sp,
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter a complaint title".tr();
        }

        return null;
      },
      decoration: _inputDecoration(
        context,
        label: "Complaint Title".tr(),
        hint: "Enter complaint title".tr(),
        icon: Icons.title_rounded,
      ),
    );
  }

  Widget _buildBodyField(BuildContext context) {
    return TextFormField(
      controller: _bodyController,
      minLines: 5,
      maxLines: 7,
      style: TextStyle(
        color: context.textColor,
        fontSize: 14.sp,
        height: 1.4,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please describe your complaint".tr();
        }

        return null;
      },
      decoration: _inputDecoration(
        context,
        label: "Description".tr(),
        hint: "Explain what happened...".tr(),
        icon: Icons.notes_rounded,
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(
        color: context.subTextColor,
      ),
      hintStyle: TextStyle(
        color: context.subTextColor.withOpacity(.65),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(
          left: 13.w,
          right: 8.w,
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
      filled: true,
      fillColor: context.cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17.r),
        borderSide: BorderSide(
          color: context.isDark
              ? Colors.white.withOpacity(.08)
              : Colors.grey.shade200,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17.r),
        borderSide: BorderSide(
          color: context.isDark
              ? Colors.white.withOpacity(.08)
              : Colors.grey.shade200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17.r),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17.r),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17.r),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildAttachmentPicker(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: _pickFiles,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(.15),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.09),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.attach_file_rounded,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Add Attachments".tr(),
              style: TextStyle(
                color: context.textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Images, PDF, Word, Excel and other files".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFiles(BuildContext context) {
    return Column(
      children: selectedFiles.asMap().entries.map(
        (entry) {
          final index = entry.key;
          final file = entry.value;

          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(
              horizontal: 11.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: context.isDark
                    ? Colors.white.withOpacity(.06)
                    : Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.09),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    _fileIcon(file.path),
                    color: AppColors.primary,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 9.w),
                Expanded(
                  child: Text(
                    file.path.split(Platform.pathSeparator).last,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedFiles.removeAt(index);
                    });
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<CreateComplaintCubit, CreateComplaintState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return SizedBox(
          width: double.infinity,
          height: 54.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : _submitComplaint,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.r),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 23,
                    height: 23,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.send_rounded,
                        size: 20,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Submit Complaint".tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'webp',
          'pdf',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'csv',
        ],
      );

      if (result == null) {
        return;
      }

      final files = result.files
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList();

      setState(() {
        selectedFiles.addAll(files);
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              "Could not select files".tr(),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedType == null || selectedType?.id == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
           SnackBar(
            content: Text(
              "Please select a complaint type".tr(),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

      return;
    }

    FocusScope.of(context).unfocus();

    await context.read<CreateComplaintCubit>().createComplaint(
          complaintTypeId: selectedType!.id!,
          title: _titleController.text.trim(),
          body: _bodyController.text.trim(),
          unitId: widget.unitId,
          attachments: selectedFiles,
        );
  }

  IconData _fileIcon(String path) {
    final extension = path.split('.').last.toLowerCase();

    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'webp':
        return Icons.image_outlined;

      case 'pdf':
        return Icons.picture_as_pdf_outlined;

      case 'doc':
      case 'docx':
        return Icons.description_outlined;

      case 'xls':
      case 'xlsx':
      case 'csv':
        return Icons.table_chart_outlined;

      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';

import '../../units/data/models/attachment_model.dart';
import '../data/models/complaint_model.dart';
import '../logic/my_complaints_cubit.dart';
import '../logic/my_complaints_state.dart';

class MyComplaintsScreen extends StatelessWidget {
  const MyComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyComplaintsCubit>()..getMyComplaints(),
      child: const _MyComplaintsView(),
    );
  }
}

class _MyComplaintsView extends StatelessWidget {
  const _MyComplaintsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.bgColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Complaints'.tr(),
          style: TextStyle(
            color: context.textColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<MyComplaintsCubit, MyComplaintsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            error: (message) => _ErrorView(
              message: message,
              onRetry: () {
                context.read<MyComplaintsCubit>().getMyComplaints();
              },
            ),
            success: (complaints) {
              if (complaints.isEmpty) {
                return const _EmptyComplaints();
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () {
                  return context.read<MyComplaintsCubit>().getMyComplaints();
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    10.h,
                    16.w,
                    30.h,
                  ),
                  itemCount: complaints.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    return _ComplaintCard(
                      complaint: complaints[index],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;

  const _ComplaintCard({
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    final status = complaint.status ?? 'unknown'.tr();
    final statusColor = _statusColor(status);
    final typeTitle = complaint.type?.title?.en;
    final attachments = complaint.attachments ?? [];

    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: context.isDark
              ? Colors.white.withOpacity(.06)
              : Colors.black.withOpacity(.04),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              context.isDark ? .18 : .05,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.09),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: const Icon(
                    Icons.category_outlined,
                    color: AppColors.primary,
                    size: 19,
                  ),
                ),
                SizedBox(width: 9.w),
                Expanded(
                  child: Text(
                    typeTitle?.isNotEmpty == true ? typeTitle! : 'Complaint'.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _StatusBadge(
                  status: status,
                  color: statusColor,
                ),
              ],
            ),
            SizedBox(height: 13.h),
            Text(
              complaint.title ?? 'Untitled Complaint'.tr(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            if (complaint.body != null &&
                complaint.body!.trim().isNotEmpty) ...[
              SizedBox(height: 7.h),
              Text(
                complaint.body!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.subTextColor,
                  fontSize: 12.sp,
                  height: 1.5,
                ),
              ),
            ],
            SizedBox(height: 14.h),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 15.sp,
                  color: context.subTextColor,
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    complaint.createdAt ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
            if (attachments.isNotEmpty) ...[
              SizedBox(height: 14.h),
              Divider(
                height: 1,
                color: context.isDark
                    ? Colors.white.withOpacity(.06)
                    : Colors.black.withOpacity(.06),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.attach_file_rounded,
                    size: 17.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '${attachments.length} '+'Attachments'.tr(),
                    style: TextStyle(
                      color: context.textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9.h),
              ...attachments.take(3).map(
                (attachment) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 7.h,
                    ),
                    child: _AttachmentItem(
                      attachment: attachment,
                    ),
                  );
                },
              ),
              if (attachments.length > 3)
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    '+ ${attachments.length - 3} '+'more files'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;

      case 'in_progress':
        return Colors.blue;

      case 'resolved':
        return Colors.green;

      case 'rejected':
        return Colors.red;

      case 'closed':
        return Colors.grey;

      default:
        return Colors.grey;
    }
  }
}

class _AttachmentItem extends StatelessWidget {
  final AttachmentModel attachment;

  const _AttachmentItem({
    required this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    final color = _fileColor(attachment.extension);

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () => _openAttachment(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 9.h,
        ),
        decoration: BoxDecoration(
          color: context.isDark
              ? Colors.white.withOpacity(.035)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: color.withOpacity(.10),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                _fileIcon(attachment.extension),
                color: color,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 9.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attachment.originalName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    attachment.extension.toUpperCase(),
                    style: TextStyle(
                      color: context.subTextColor,
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13.sp,
              color: context.subTextColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openAttachment(BuildContext context) async {
    final extension = attachment.extension.toLowerCase();

    final isImage = [
      'jpg',
      'jpeg',
      'png',
      'webp',
      'gif',
    ].contains(extension);

    if (isImage) {
      _showImageViewer(
        context,
        attachment.url,
        attachment.originalName,
      );
      return;
    }

    final uri = Uri.tryParse(attachment.url);

    if (uri == null) {
      _showError(
        context,
        'Invalid file URL'.tr(),
      );
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        _showError(
          context,
          'Could not open the file'.tr(),
        );
      }
    } catch (_) {
      _showError(
        context,
        'Could not open the file'.tr(),
      );
    }
  }

  void _showImageViewer(
    BuildContext context,
    String imageUrl,
    String fileName,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.92),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white,
                          size: 60,
                        ),
                      );
                    },
                    loadingBuilder: (
                      context,
                      child,
                      progress,
                    ) {
                      if (progress == null) {
                        return child;
                      }

                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.55),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showError(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  IconData _fileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'webp':
      case 'gif':
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

      case 'mp4':
      case 'mov':
      case 'avi':
        return Icons.video_file_outlined;

      case 'mp3':
      case 'wav':
        return Icons.audio_file_outlined;

      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Color _fileColor(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Colors.red;

      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'webp':
      case 'gif':
        return Colors.blue;

      case 'doc':
      case 'docx':
        return Colors.indigo;

      case 'xls':
      case 'xlsx':
      case 'csv':
        return Colors.green;

      case 'mp4':
      case 'mov':
      case 'avi':
        return Colors.deepPurple;

      case 'mp3':
      case 'wav':
        return Colors.orange;

      default:
        return Colors.grey;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;

  const _StatusBadge({
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        _formatStatus(status),
        style: TextStyle(
          color: color,
          fontSize: 9.5.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatStatus(String value) {
    return value
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }
}

class _EmptyComplaints extends StatelessWidget {
  const _EmptyComplaints();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 92.w,
              height: 92.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.report_problem_outlined,
                size: 44,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              'No Complaints'.tr(),
              style: TextStyle(
                color: context.textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "You don't have any complaints yet.".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76.w,
              height: 76.w,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.red.shade300,
                size: 40.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textColor,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.h),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              label:  Text('Retry'.tr()),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(
                  color: AppColors.primary.withOpacity(.25),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';
import '../../data/models/my_unit_model.dart';

class MyUnitCard extends StatelessWidget {
  final MyUnitModel myUnit;

  const MyUnitCard({
    super.key,
    required this.myUnit,
  });

  Color _statusColor() {
    switch (myUnit.status?.toLowerCase()) {
      case "transferred":
        return Colors.green;

      case "pending":
        return Colors.orange;

      case "cancelled":
      case "canceled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String _formatStatus(String? status) {
    if (status == null || status.isEmpty) {
      return "Unknown".tr();
    }

    return status
        .replaceAll("_", " ")
        .split(" ")
        .map(
          (word) =>
              word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1),
        )
        .join(" ");
  }

  @override
  Widget build(BuildContext context) {
    final unit = myUnit.unit;

    final image = unit?.attachments != null &&
            unit!.attachments!.isNotEmpty &&
            unit.attachments!.first.url != null &&
            unit.attachments!.first.url!.isNotEmpty
        ? unit.attachments!.first.url!
        : "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85";

    return GestureDetector(
      onTap: () {
        if (unit?.id == null) return;

        Navigator.pushNamed(
          context,
          Routes.MyUnitDetailsScreen,
          arguments: {
            'id': unit!.id,
            'showOrderButton': false,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 6.h,
        ),
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
                context.isDark ? .25 : .06,
              ),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// ============================================================
// IMAGE
// ============================================================

            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Image.network(
                    image,
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 150.h,
                        width: double.infinity,
                        color: context.isDark
                            ? Colors.grey.shade900
                            : Colors.grey.shade200,
                        child: Icon(
                          Icons.apartment_rounded,
                          size: 42.sp,
                          color: context.subTextColor,
                        ),
                      );
                    },
                  ),
                ),

// IMAGE GRADIENT
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.38),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

// ========================================================
// OWNERSHIP STATUS
// ========================================================

                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      _formatStatus(myUnit.status).toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .3,
                      ),
                    ),
                  ),
                ),

// ========================================================
// ATTACHMENTS COUNT
// ========================================================

                if (unit?.attachments != null && unit!.attachments!.isNotEmpty)
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.45),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.photo_library_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "${unit.attachments!.length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

// ============================================================
// CONTENT
// ============================================================

            Padding(
              padding: EdgeInsets.fromLTRB(
                14.w,
                12.h,
                14.w,
                13.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
// ========================================================
// UNIT NUMBER + TYPE
// ========================================================

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          unit?.unitNumber ?? "-",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      if (unit?.type != null && unit!.type!.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(.08),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            unit.type!,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 8.h),

// ========================================================
// FEATURES
// ========================================================

                  Row(
                    children: [
                      _compactFeature(
                        Icons.square_foot_rounded,
                        "${unit?.area ?? "-"} "+"m²".tr(),
                        context,
                      ),
                      _divider(context),
                      _compactFeature(
                        Icons.meeting_room_outlined,
                        "${unit?.roomsCount ?? "-"} "+"Rooms".tr(),
                        context,
                      ),
                      _divider(context),
                      _compactFeature(
                        Icons.layers_outlined,
                        "Floor".tr()+" ${unit?.floor ?? "-"}",
                        context,
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

// ========================================================
// OWNERSHIP INFO
// ========================================================

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 11.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.isDark
                          ? Colors.white.withOpacity(.04)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(.10),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const Icon(
                            Icons.verified_outlined,
                            size: 17,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 9.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Owned since".tr(),
                                style: TextStyle(
                                  color: context.subTextColor,
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                myUnit.ownedAt ?? "-",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: context.textColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (myUnit.attachments != null &&
                            myUnit.attachments!.isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.attach_file_rounded,
                                size: 16.sp,
                                color: context.subTextColor,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "${myUnit.attachments!.length}",
                                style: TextStyle(
                                  color: context.subTextColor,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _compactFeature(
    IconData icon,
    String text,
    BuildContext context,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: AppColors.primary,
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: context.subTextColor,
          ),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) {
    return Container(
      width: 1,
      height: 14.h,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      color: context.isDark
          ? Colors.white.withOpacity(.12)
          : Colors.black.withOpacity(.08),
    );
  }
}

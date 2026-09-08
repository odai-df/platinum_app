import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/ErrorView.dart';
import '../../../favorite/logic/favorite_cubit.dart';
import '../../../favorite/logic/favorite_state.dart';
import '../../../units_details/logic/unit_details_cubit.dart';
import '../../../units_details/logic/unit_details_state.dart';
import '../../../units_details/ui/unit_360_view.dart';

import 'package:intl/intl.dart';

class MyUnitDetailsScreen extends StatefulWidget {
  final int unitId;
  final bool showOrderButton;

  const MyUnitDetailsScreen({
    super.key,
    required this.unitId,
    this.showOrderButton = true,
  });

  @override
  State<MyUnitDetailsScreen> createState() => _UnitDetailsScreenState();
}

class _UnitDetailsScreenState extends State<MyUnitDetailsScreen> {
  final PageController _pageController = PageController();

  int _currentImage = 0;

  bool initialized = false;

  late bool isFav;
  final NumberFormat priceFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();

    context.read<UnitDetailCubit>().getUnitDetails(widget.unitId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: context.bgColor,
      body: BlocBuilder<UnitDetailCubit, UnitDetailState>(
        builder: (context, state) {
          if (state is UnitDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UnitDetailFailure) {
            return ErrorView(
              onRetry: () {
                context.read<UnitDetailCubit>().getUnitDetails(widget.unitId);
              },
            );
          }

          if (state is UnitDetailSuccess) {
            final unit = state.unit;

            if (!initialized) {
              isFav = unit.isFavorite;
              initialized = true;
            }

            return Stack(
              children: [
                /// ================= CONTENT =================
                SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    bottom: 90,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ================= IMAGE GALLERY =================

                      SizedBox(
                        height: 270.h,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onHorizontalDragUpdate: (_) {},
                              child: PageView.builder(
                                controller: _pageController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: unit.attachments.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentImage = index;
                                  });
                                },
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  final attachment = unit.attachments[index];

                                  final is360 =
                                      attachment.type == '360_panorama';

                                  final extension =
                                      attachment.extension.toLowerCase();

                                  final isImage = [
                                    'jpg',
                                    'jpeg',
                                    'png',
                                    'webp',
                                    'gif',
                                  ].contains(extension);

                                  return GestureDetector(
                                    onTap: () {
                                      /// 360 IMAGE
                                      if (is360) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Unit360View(
                                              imageUrl: attachment.url,
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      /// NORMAL IMAGE
                                      if (isImage) {
                                        _showImageViewer(
                                          context,
                                          attachment.url,
                                          attachment.originalName,
                                        );
                                      }
                                    },
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(
                                          attachment.url,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) {
                                            return Container(
                                              color: context.isDark
                                                  ? Colors.grey.shade900
                                                  : Colors.grey.shade200,
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                                size: 40,
                                                color: context.subTextColor,
                                              ),
                                            );
                                          },
                                        ),

                                        Container(
                                          color: Colors.black.withOpacity(.20),
                                        ),

                                        /// 360 BADGE
                                        if (is360)
                                          Center(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(.55),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.panorama,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Tap to explore 360°'.tr(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        /// NORMAL IMAGE BADGE
                                        if (!is360 && isImage)
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(.45),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.zoom_in_rounded,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            /// GRADIENT
                            Positioned.fill(
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(.5),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /// TOP ACTIONS
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.black.withOpacity(.4),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                    BlocBuilder<FavoriteCubit, FavoriteState>(
                                      builder: (
                                        context,
                                        favState,
                                      ) {
                                        return CircleAvatar(
                                          backgroundColor:
                                              Colors.black.withOpacity(.4),
                                          child: IconButton(
                                            icon: Icon(
                                              isFav
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFav
                                                  ? Colors.red
                                                  : Colors.white,
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                isFav = !isFav;
                                              });

                                              try {
                                                if (isFav) {
                                                  await context
                                                      .read<FavoriteCubit>()
                                                      .toggleFavorite(unit.id);
                                                } else {
                                                  await context
                                                      .read<FavoriteCubit>()
                                                      .removeFavorite(unit.id);
                                                }
                                              } catch (e) {
                                                setState(() {
                                                  isFav = !isFav;
                                                });

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(e.toString()),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// IMAGE COUNT
                            Positioned(
                              bottom: 20,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${_currentImage + 1} / ${unit.attachments.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// ================= DETAILS =================
                      Container(
                        transform: Matrix4.translationValues(
                          0,
                          -20,
                          0,
                        ),
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          20,
                          16,
                          16,
                        ),
                        decoration: BoxDecoration(
                          color: context.bgColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ================= UNIT HEADER =================

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        unit.unitNumber,
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: context.textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        unit.type.toUpperCase(),
                                        style: TextStyle(
                                          color: context.subTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: .4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _StatusBadge(
                                  status: unit.status,
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            /// ================= PRICE =================

                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: context.isDark
                                      ? AppColors.darkBorder
                                      : Colors.grey.shade200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price".tr(),
                                          style: TextStyle(
                                            color: context.subTextColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (unit.hasActiveOffer)
                                          Text(
                                            priceFormatter.format(
                                              unit.originalPrice,
                                            ),
                                            style: TextStyle(
                                              color: context.subTextColor,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 12,
                                            ),
                                          ),
                                        Text(
                                          priceFormatter.format(
                                            unit.currentPrice,
                                          ),
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (unit.hasActiveOffer)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(.10),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "-${unit.discountPercentage}%",
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// ================= BASIC INFO =================

                            Row(
                              children: [
                                Expanded(
                                  child: _InfoTile(
                                    icon: Icons.layers_outlined,
                                    title: "Floor".tr(),
                                    value: "${unit.floor}",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _InfoTile(
                                    icon: Icons.square_foot_outlined,
                                    title: "Area".tr(),
                                    value: "${unit.area} " + "m²".tr(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _InfoTile(
                                    icon: Icons.meeting_room_outlined,
                                    title: "Rooms".tr(),
                                    value: "${unit.roomsCount}",
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            /// ================= DESCRIPTION =================

                            if (unit.description != null &&
                                unit.description!.trim().isNotEmpty) ...[
                              Text(
                                "Description".tr(),
                                style: TextStyle(
                                  color: context.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                unit.description!,
                                style: TextStyle(
                                  color: context.subTextColor,
                                  height: 1.5,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 18),
                            ],

                            /// ================= BUILDING =================

                            if (unit.building != null) ...[
                              _DetailsCard(
                                icon: Icons.apartment_rounded,
                                title: unit.building.buildingNumber,
                                subtitle: "${unit.building.floorsCount} " +
                                    "Floors •".tr() +
                                    " ${_capitalize(unit.building.status)}",
                              ),
                              const SizedBox(height: 10),
                            ],

                            /// ================= PROJECT =================

                            if (unit.building.project != null) ...[
                              _DetailsCard(
                                icon: Icons.location_city_rounded,
                                title: unit.building.project!.name,
                                subtitle: _capitalize(
                                  unit.building.project!.status,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            /// ================= MAP =================

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.cardColor,
                                  foregroundColor: context.textColor,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.map_outlined,
                                  size: 20,
                                ),
                                label: Text(
                                  "Open in Maps".tr(),
                                ),
                                onPressed: () {
                                  final coords = unit.building.coordinates;

                                  if (coords == null) {
                                    return;
                                  }

                                  openSmartMap(
                                    coords.latitude ?? 0,
                                    coords.longitude ?? 0,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// ================= COMPLAINT BUTTON =================

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      10,
                      16,
                      16,
                    ),
                    decoration: BoxDecoration(
                      color: context.bgColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            context.isDark ? .20 : .08,
                          ),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.createComplaint,
                            arguments: widget.unitId,
                          );
                        },
                        icon: const Icon(
                          Icons.report_problem_outlined,
                          size: 21,
                        ),
                        label: Text(
                          "Submit Complaint".tr(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Future<void> openSmartMap(
    double lat,
    double lng,
  ) async {
    final Uri googleAppUri = Uri.parse(
      "comgooglemaps://?q=$lat,$lng",
    );

    final Uri appleMapsUri = Uri.parse(
      "http://maps.apple.com/?q=$lat,$lng",
    );

    final Uri webFallbackUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );

    try {
      if (Platform.isAndroid) {
        if (await _canOpen(
          googleAppUri,
        )) {
          return;
        }

        await launchUrl(
          webFallbackUri,
          mode: LaunchMode.externalApplication,
        );

        return;
      }

      if (Platform.isIOS) {
        if (await _canOpen(
          appleMapsUri,
        )) {
          return;
        }

        await launchUrl(
          webFallbackUri,
          mode: LaunchMode.externalApplication,
        );

        return;
      }

      await launchUrl(
        webFallbackUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint(
        "Map launch failed: $e",
      );
    }
  }

  Future<bool> _canOpen(
    Uri uri,
  ) async {
    try {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      return false;
    }
  }
}

/// ============================================================
/// INFO TILE
/// ============================================================

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: context.isDark ? AppColors.darkBorder : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 19,
            color: AppColors.primary,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// DETAILS CARD
/// ============================================================

class _DetailsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _DetailsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: context.isDark ? AppColors.darkBorder : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.10),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.subTextColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: context.subTextColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.toLowerCase();

    Color color;
    IconData icon;

    switch (normalizedStatus) {
      case 'available':
        color = Colors.green;
        icon = Icons.check_circle_outline_rounded;
        break;

      case 'reserved':
        color = Colors.orange;
        icon = Icons.schedule_rounded;
        break;

      case 'sold':
        color = Colors.red;
        icon = Icons.sell_outlined;
        break;

      case 'unavailable':
        color = Colors.grey;
        icon = Icons.block_outlined;
        break;

      default:
        color = AppColors.primary;
        icon = Icons.info_outline_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            _capitalize(status),
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

String _capitalize(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "-";
  }

  return value
      .replaceAll('_', ' ')
      .split(' ')
      .where((word) => word.isNotEmpty)
      .map(
        (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
      )
      .join(' ');
}

void _showImageViewer(
  BuildContext context,
  String imageUrl,
  String fileName,
) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(.95),
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              /// IMAGE
              Positioned.fill(
                child: Center(
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 5.0,
                    panEnabled: true,
                    scaleEnabled: true,
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white,
                            size: 70,
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
                            strokeWidth: 2.5,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              /// CLOSE BUTTON
              SafeArea(
                child: Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.55),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),

              /// FILE NAME
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.55),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

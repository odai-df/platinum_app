import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';
import '../../../favorite/logic/favorite_cubit.dart';
import '../../../units/data/models/unit_model.dart';

class UnitCard extends StatefulWidget {
  final UnitModel unit;
  final bool showFavorite;
  final bool showOrderButton;

  const UnitCard({
    super.key,
    required this.unit,
    this.showFavorite = false,
    this.showOrderButton = true,
  });

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
  late bool isFav;

  final NumberFormat priceFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    isFav = widget.unit.isFavorite;
  }

  Color _statusColor() {
    switch (widget.unit.status.toLowerCase()) {
      case "available":
        return Colors.green;

      case "reserved":
        return Colors.orange;

      case "sold":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final image =
        widget.unit.attachments != null && widget.unit.attachments!.isNotEmpty
            ? widget.unit.attachments!.first.url
            : "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85";

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.unitDetailsScreen,
          arguments: {
            'id': widget.unit.id,
            'showOrderButton': widget.showOrderButton,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(20),
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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
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
                          Icons.image_not_supported_outlined,
                          size: 40,
                          color: context.subTextColor,
                        ),
                      );
                    },
                  ),
                ),

                // Image gradient
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.35),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ========================================================
                // STATUS
                // ========================================================

                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.unit.status.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .3,
                      ),
                    ),
                  ),
                ),

                // ========================================================
                // FAVORITE
                // ========================================================

                if (widget.showFavorite)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        final cubit = context.read<FavoriteCubit>();

                        setState(() {
                          isFav = !isFav;
                        });

                        try {
                          if (isFav) {
                            await cubit.toggleFavorite(widget.unit.id);
                          } else {
                            await cubit.removeFavorite(widget.unit.id);
                          }
                        } catch (_) {
                          if (mounted) {
                            setState(() {
                              isFav = !isFav;
                            });
                          }
                        }
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: context.cardColor.withOpacity(.94),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 19,
                          color: isFav ? Colors.red : context.subTextColor,
                        ),
                      ),
                    ),
                  ),

                // ========================================================
                // DISCOUNT
                // ========================================================

                if (widget.unit.hasActiveOffer)
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "-${widget.unit.discountPercentage}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // ============================================================
            // CONTENT
            // ============================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                14,
                12,
                14,
                13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ========================================================
                  // TITLE + PRICE
                  // ========================================================

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.unit.unitNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: context.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (widget.unit.hasActiveOffer)
                            Text(
                              priceFormatter.format(
                                widget.unit.originalPrice,
                              ),
                              style: TextStyle(
                                fontSize: 10,
                                color: context.subTextColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            priceFormatter.format(
                              widget.unit.currentPrice,
                            ),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ========================================================
                  // FEATURES
                  // ========================================================

                  Row(
                    children: [
                      _compactFeature(
                        Icons.square_foot_rounded,
                        "${widget.unit.area} "+"m²".tr(),
                        context,
                      ),

                      _divider(context),

                      _compactFeature(
                        Icons.meeting_room_outlined,
                        "${widget.unit.roomsCount} "+"Rooms".tr(),
                        context,
                      ),

                      // إذا بدك الطابق رجعه هون
                      //
                      // _divider(context),
                      //
                      // _compactFeature(
                      //   Icons.layers_outlined,
                      //   "Floor ${widget.unit.floor}",
                      //   context,
                      // ),
                    ],
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
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
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
      height: 14,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: context.isDark
          ? Colors.white.withOpacity(.12)
          : Colors.black.withOpacity(.08),
    );
  }
}

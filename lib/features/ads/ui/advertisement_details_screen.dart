import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/features/ads/data/models/advertisement_details_model.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../../../core/widgets/ErrorView.dart';

import '../data/models/advertisement_model.dart';
import '../data/models/offer_model.dart';
import '../logic/advertisement_details_cubit.dart';
import '../logic/advertisement_details_state.dart';

class AdvertisementDetailsScreen extends StatefulWidget {
  final int id;

  const AdvertisementDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<AdvertisementDetailsScreen> createState() =>
      _AdvertisementDetailsScreenState();
}

class _AdvertisementDetailsScreenState
    extends State<AdvertisementDetailsScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    context.read<AdvertisementDetailsCubit>().getDetails(widget.id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      body: BlocBuilder<AdvertisementDetailsCubit, AdvertisementDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () =>
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            error: (message) =>
                ErrorView(
                  onRetry: () {
                    context.read<AdvertisementDetailsCubit>().getDetails(
                        widget.id);
                  },
                ),
            success: (data) {
              return _buildContent(
                context,
                data,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context,
      AdvertisementDetailsModel data,) {
    final attachments = data.attachments;
    final offer = data.offer;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================================
              // HEADER
              // ==========================================================

              _buildHeader(
                context,
                attachments,
              ),

              // ==========================================================
              // CONTENT
              // ==========================================================

              Transform.translate(
                offset: const Offset(0, -22),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    26,
                    20,
                    30,
                  ),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ==================================================
                      // STATUS
                      // ==================================================

                      // _buildStatus(
                      //   data.status,
                      // ),

                      const SizedBox(height: 14),

                      // ==================================================
                      // TITLE
                      // ==================================================

                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: context.textColor,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ==================================================
                      // DESCRIPTION
                      // ==================================================

                      Text(
                        "Description".tr(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: context.textColor,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        data.description.isNotEmpty ? data.description : "-",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: context.subTextColor,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // ==================================================
                      // INFORMATION
                      // ==================================================

                      _buildInformationSection(
                        context,
                        data,
                      ),

                      // ==================================================
                      // OFFER
                      // ==================================================

                      if (offer != null) ...[
                        const SizedBox(height: 24),
                        _buildOfferSection(
                          context,
                          offer,
                        ),
                      ],

                      const SizedBox(height: 24),

                      // ==================================================
                      // CREATED INFO
                      // ==================================================


                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ==============================================================
        // BACK BUTTON
        // ==============================================================

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(.45),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ====================================================================
  // HEADER
  // ====================================================================

  Widget _buildHeader(BuildContext context,
      List<dynamic> attachments,) {
    if (attachments.isEmpty) {
      return SizedBox(
        height: 300,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(.55),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.campaign_rounded,
                  size: 90,
                  color: Colors.white70,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.15),
                    Colors.transparent,
                    Colors.black.withOpacity(.35),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: attachments.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context,
                index,) {
              return Image.network(
                attachments[index].url,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: context.isDark
                        ? Colors.grey.shade900
                        : Colors.grey.shade200,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 60,
                      color: context.subTextColor,
                    ),
                  );
                },
              );
            },
          ),

          // Gradient
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.5),
                      Colors.transparent,
                      Colors.black.withOpacity(.45),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Dots
          if (attachments.length > 1)
            Positioned(
              bottom: 35,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  attachments.length,
                      (index) {
                    final selected = currentPage == index;

                    return AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      width: selected ? 22 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: selected ? Colors.white : Colors.white54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ====================================================================
  // STATUS
  // ====================================================================

  Widget _buildStatus(bool status) {
    final active = status;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: active
            ? Colors.green.withOpacity(.12)
            : Colors.orange.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? Icons.check_circle_outline : Icons.schedule,
            size: 17,
            color: active ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 6),
          Text(
            active ? "Active".tr() : "Inactive".tr(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: active ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // INFORMATION
  // ====================================================================

  Widget _buildInformationSection(BuildContext context,
      AdvertisementDetailsModel data,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Advertisement Information".tr(),
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: context.textColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _infoCard(
                context,
                icon: Icons.calendar_today_outlined,
                title: "Starts".tr(),
                value: _formatDate(data.startsAt),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _infoCard(
                context,
                icon: Icons.event_outlined,
                title: "Ends".tr(),
                value: _formatDate(data.endsAt),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _infoCard(
          context,
          icon: Icons.timer_outlined,
          title: "Duration".tr(),
          value: "${data.durationDays} ${"days".tr()}",
        ),
      ],
    );
  }

  Widget _infoCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.isDark
            ? Colors.white.withOpacity(.05)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.subTextColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // OFFER
  // ====================================================================

  Widget _buildOfferSection(BuildContext context,
      OfferModel offer,) {
    final itemType = offer.itemType?.toLowerCase();

    final isUnit = itemType == 'unit';

    final isService = itemType == 'service' || itemType == 'solution';

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        _openOfferItem(
          context,
          offer,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(.12),
              AppColors.primary.withOpacity(.04),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withOpacity(.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================================
            // OFFER HEADER
            // ==========================================================

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_offer_outlined,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Special Offer".tr(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: context.textColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        isUnit
                            ? "Unit Offer".tr()
                            : isService
                            ? "Service Offer".tr()
                            : "Special Offer".tr(),
                        style: TextStyle(
                          fontSize: 12,
                          color: context.subTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Icon(
                //   Icons.arrow_forward_ios_rounded,
                //   size: 17,
                //   color: AppColors.primary,
                // ),
              ],
            ),

            const SizedBox(height: 18),

            // ==========================================================
            // PRICES
            // ==========================================================

            Row(
              children: [
                Expanded(
                  child: _priceItem(
                    context,
                    title: "Old Price".tr(),
                    price: offer.oldPrice ?? 0,
                    crossed: true,
                  ),
                ),
                Expanded(
                  child: _priceItem(
                    context,
                    title: "New Price".tr(),
                    price: offer.newPrice ?? 0,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ==========================================================
            // DISCOUNT + TYPE
            // ==========================================================

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.12),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Text(
                    "${offer.discountPercentage ?? 0}% ${"OFF".tr()}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                if (isUnit)
                  _offerTypeBadge(
                    context,
                    Icons.apartment_outlined,
                    "Unit".tr(),
                  ),
                if (isService)
                  _offerTypeBadge(
                    context,
                    Icons.design_services_outlined,
                    "Service".tr(),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            // ==========================================================
            // VIEW DETAILS
            // ==========================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isUnit
                        ? "View Unit Details".tr()
                        : isService
                        ? "View Service Details".tr()
                        : "View Details".tr(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceItem(BuildContext context, {
    required String title,
    required num price,
    bool crossed = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: context.subTextColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "\$${price.toString()}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: crossed ? context.subTextColor : AppColors.primary,
            decoration: crossed ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }

  Widget _offerTypeBadge(BuildContext context,
      IconData icon,
      String title,) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: AppColors.primary,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // OPEN OFFER ITEM
  // ====================================================================

  void _openOfferItem(BuildContext context,
      OfferModel offer,) {
    final itemType = offer.itemType?.toLowerCase();
    final itemId = offer.itemId;

    debugPrint('===== OFFER CLICK =====');
    debugPrint('itemType => $itemType');
    debugPrint('itemId => $itemId');

    if (itemId == null || itemType == null) {
      debugPrint('❌ Missing itemType or itemId');
      return;
    }

    if (itemType == 'unit') {
      debugPrint('🏠 Opening Unit Details...');

      Navigator.pushNamed(
        context,
        Routes.unitDetailsScreen,
        arguments: {
          'id': itemId,
          'showOrderButton': true,
        },
      );

      return;
    }

    if (itemType == 'service' || itemType == 'solution') {
      debugPrint('🛠 Opening Service Details...');

      Navigator.pushNamed(
        context,
        Routes.solutionDetails,
        arguments: itemId,
      );

      return;
    }

    debugPrint('❌ Unsupported item type: $itemType');
  }

  // ====================================================================
  // CREATED INFO
  // ====================================================================

  // Widget _buildCreatedInfo(BuildContext context,
  //     AdvertisementDetailsModel data,) {
  //   return Row(
  //     children: [
  //       Icon(
  //         Icons.info_outline,
  //         size: 18,
  //         color: context.subTextColor,
  //       ),
  //       const SizedBox(width: 8),
  //       Expanded(
  //         // child: Text(
  //         //   "${"Created on".tr()} ${_formatDate(data.createdAt)}",
  //         //   style: TextStyle(
  //         //     fontSize: 12,
  //         //     color: context.subTextColor,
  //         //   ),
  //         // ),
  //       ),
  //     ],
  //   );
  // }

  // ====================================================================
  // DATE FORMAT
  // ====================================================================

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(
        date.replaceFirst(' ', 'T'),
      );

      return "${parsed.day.toString().padLeft(2, '0')}/"
          "${parsed.month.toString().padLeft(2, '0')}/"
          "${parsed.year}";
    } catch (_) {
      return date;
    }
  }
}

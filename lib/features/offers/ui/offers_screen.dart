import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';
import '../data/models/offer_model.dart';
import '../logic/offers_cubit.dart';
import '../logic/offers_state.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OffersCubit>()..getOffers(),
      child: const _OffersView(),
    );
  }
}

class _OffersView extends StatelessWidget {
  const _OffersView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: context.bgColor,
        title: Text(
          "Offers",
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),

            loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            },

            error: (message) {
              return _ErrorView(
                message: message,
                onRetry: () {
                  context.read<OffersCubit>().getOffers();
                },
              );
            },

            success: (offers) {
              if (offers.isEmpty) {
                return const _EmptyOffers();
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () {
                  return context.read<OffersCubit>().getOffers();
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    10,
                    16,
                    30,
                  ),
                  itemCount: offers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    return OfferCard(
                      offer: offers[index],
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

// ============================================================
// OFFER CARD
// ============================================================

class OfferCard extends StatelessWidget {
  final OfferModel offer;

   OfferCard({
    super.key,
    required this.offer,
  });

  final NumberFormat _priceFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final item = offer.item;

    return Material(
      color: context.cardColor,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          // لاحقاً نضيف الانتقال لتفاصيل الوحدة / الخدمة
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: context.isDark
                  ? Colors.white.withOpacity(.06)
                  : Colors.grey.withOpacity(.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  context.isDark ? .20 : .05,
                ),
                blurRadius: 15,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ================= HEADER =================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.10),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        offer.itemType == "unit"
                            ? Icons.apartment_rounded
                            : Icons.local_offer_rounded,
                        color: AppColors.primary,
                        size: 27,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.itemType == "unit"
                                ? "Apartment Offer"
                                : "Special Offer",
                            style: TextStyle(
                              fontSize: 12,
                              color: context.subTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            item?.unitNumber ?? "Special Offer",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // DISCOUNT

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.10),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "-${offer.discountPercentage}%",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ================= UNIT INFO =================

                if (item != null) ...[
                  Row(
                    children: [
                      _InfoItem(
                        icon: Icons.square_foot_rounded,
                        value: "${item.area} m²",
                      ),

                      const SizedBox(width: 18),

                      _InfoItem(
                        icon: Icons.meeting_room_outlined,
                        value: "${item.roomsCount} Rooms",
                      ),

                      const Spacer(),

                      _StatusBadge(
                        status: item.status,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],

                // ================= PRICE =================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.06),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Special Price",
                            style: TextStyle(
                              fontSize: 12,
                              color: context.subTextColor,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            _priceFormatter.format(offer.newPrice),
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Old Price",
                            style: TextStyle(
                              fontSize: 11,
                              color: context.subTextColor,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            _priceFormatter.format(offer.oldPrice),
                            style: TextStyle(
                              fontSize: 13,
                              color: context.subTextColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ================= DATE =================

                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 17,
                      color: context.subTextColor,
                    ),

                    const SizedBox(width: 7),

                    Expanded(
                      child: Text(
                        "Valid until ${_formatDate(offer.endDate??"")}",
                        style: TextStyle(
                          fontSize: 12,
                          color: context.subTextColor,
                        ),
                      ),
                    ),

                    if (offer.isActive == true)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "ACTIVE",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(String value) {
    try {
      final date = DateTime.parse(
        value.replaceFirst(' ', 'T'),
      );

      return DateFormat(
        'dd MMM yyyy',
      ).format(date);
    } catch (_) {
      return value;
    }
  }
}

// ============================================================
// INFO ITEM
// ============================================================

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: AppColors.primary,
        ),

        const SizedBox(width: 5),

        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: context.subTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// STATUS
// ============================================================

class _StatusBadge extends StatelessWidget {
  final String? status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final value = status?.toLowerCase() ?? "";

    Color color;

    switch (value) {
      case "available":
        color = Colors.green;
        break;

      case "reserved":
        color = Colors.orange;
        break;

      case "sold":
        color = Colors.red;
        break;

      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        value.isEmpty ? "Unknown" : value.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ============================================================
// EMPTY
// ============================================================

class _EmptyOffers extends StatelessWidget {
  const _EmptyOffers();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              "No Offers Available",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "There are no active offers at the moment.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ERROR
// ============================================================

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
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60,
              color: Colors.red.shade300,
            ),

            const SizedBox(height: 15),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.subTextColor,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
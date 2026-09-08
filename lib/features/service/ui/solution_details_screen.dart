import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/widgets/ErrorView.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../../order_unit/logic/ordar_cubit.dart';
import '../../order_unit/logic/ordar_state.dart';
import '../logic/solution_details_cubit.dart';
import '../logic/solution_details_state.dart';

class SolutionDetailsScreen extends StatefulWidget {
  final int id;
  final bool showOrderButton;

  const SolutionDetailsScreen({
    super.key,
    required this.id,
    this.showOrderButton = true,
  });

  @override
  State<SolutionDetailsScreen> createState() => _SolutionDetailsScreenState();
}

class _SolutionDetailsScreenState extends State<SolutionDetailsScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    context.read<SolutionDetailsCubit>().getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      body: BlocBuilder<SolutionDetailsCubit, SolutionDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            error: (msg) => ErrorView(
              onRetry: () {
                context.read<SolutionDetailsCubit>().getDetails(widget.id);
              },
            ),
            success: (data) {
              final images = data.attachments;

              return Stack(
                children: [
                  /// ================= BODY =================
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ================= IMAGE SLIDER =================
                        SizedBox(
                          height: 320,
                          child: Stack(
                            children: [
                              if (images!.isNotEmpty)
                                PageView.builder(
                                  controller: _pageController,
                                  itemCount: images.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      currentPage = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      images[index].url,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          color: context.cardColor,
                                          child: Center(
                                            child: Icon(
                                              Icons.broken_image_outlined,
                                              size: 60,
                                              color: context.subTextColor,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              else
                                Container(
                                  width: double.infinity,
                                  color: context.cardColor,
                                  child: Center(
                                    child: Icon(
                                      Icons.home_work_outlined,
                                      size: 80,
                                      color: context.subTextColor,
                                    ),
                                  ),
                                ),

                              /// Gradient
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.4),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),

                              /// Back button
                              SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.4),
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

                              /// Dots
                              if (images.length > 1)
                                Positioned(
                                  bottom: 12,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      images.length,
                                      (index) => AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        width: currentPage == index ? 18 : 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: currentPage == index
                                              ? Colors.white
                                              : Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        /// ================= CONTENT =================
                        Transform.translate(
                          offset: const Offset(0, -20),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// TITLE
                                Text(
                                  data.name.tr(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: context.textColor,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                /// ================= PRICE =================
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      /// Original price
                                      if (data.hasActiveOffer)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Original Price".tr(),
                                              style: TextStyle(
                                                color: context.subTextColor,
                                              ),
                                            ),
                                            Text(
                                              "${data.originalPrice} \$",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: context.subTextColor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),

                                      if (data.hasActiveOffer)
                                        const SizedBox(height: 8),

                                      /// Current price
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Price".tr(),
                                            style: TextStyle(
                                              color: context.textColor,
                                            ),
                                          ),
                                          Text(
                                            "${data.currentPrice} \$",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),

                                      /// Discount
                                      if (data.hasActiveOffer) ...[
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(.12),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20,
                                              ),
                                            ),
                                            child: Text(
                                              "${data.discountPercentage}% ${"OFF".tr()}",
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                /// ================= DESCRIPTION =================
                                Text(
                                  "Description".tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: context.textColor,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  data.description.tr(),
                                  style: TextStyle(
                                    height: 1.5,
                                    color: context.subTextColor,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                /// ================= INFO CHIPS =================
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    _chip(
                                      Icons.access_time,
                                      data.createdFrom.tr(),
                                    ),
                                    _chip(
                                      Icons.calendar_today_outlined,
                                      data.createdAt,
                                    ),
                                    _chip(
                                      Icons.image_outlined,
                                      "${images.length} ${"Photos".tr()}",
                                    ),
                                    if (data.hasActiveOffer)
                                      _chip(
                                        Icons.local_offer_outlined,
                                        "${data.discountPercentage}% ${"OFF".tr()}",
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ================= REQUEST SERVICE BUTTON =================
                  if (widget.showOrderButton)
                    BlocConsumer<OrderCubit, OrderState>(
                      listener: (context, state) {
                        if (state is OrderSuccess) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  16,
                                ),
                                elevation: 0,
                                backgroundColor: Colors.green.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                duration: const Duration(seconds: 3),
                                content: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.18),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 21,
                                      ),
                                    ),
                                    const SizedBox(width: 11),
                                    Expanded(
                                      child: Text(
                                        state.message,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                          Navigator.pop(
                            context,
                            true,
                          );
                        }

                        if (state is OrderError) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  16,
                                ),
                                elevation: 0,
                                backgroundColor: Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                duration: const Duration(seconds: 3),
                                content: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.18),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.white,
                                        size: 21,
                                      ),
                                    ),
                                    const SizedBox(width: 11),
                                    Expanded(
                                      child: Text(
                                        state.message,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is OrderLoading;

                        return Positioned(
                          left: 14,
                          right: 14,
                          bottom: 10,
                          child: SafeArea(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        context
                                            .read<OrderCubit>()
                                            .createSolutionOrder(
                                              data.id,
                                            );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  disabledBackgroundColor:
                                      AppColors.primary.withOpacity(0.6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        width: 21,
                                        height: 21,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.shopping_bag_outlined,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Request Service".tr(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _chip(
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkContainer : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: context.subTextColor,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: context.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

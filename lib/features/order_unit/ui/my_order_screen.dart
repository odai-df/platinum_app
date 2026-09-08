import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/features/home/ui/widgets/unit_card.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../../../core/widgets/ErrorView.dart';

import '../logic/my_order_cubit.dart';
import '../logic/my_order_stete.dart';
import '../logic/my_solution_cubit.dart';
import '../logic/my_solution_state.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    context.read<OrdersCubit>().getMyOrders();

    _tabController.addListener(() {
      if (_tabController.index == 1) {
        final state = context.read<SolutionOrdersCubit>().state;

        if (state is! SolutionOrdersSuccess) {
          context.read<SolutionOrdersCubit>().getMySolutionOrders();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: context.bgColor,
        title: Text(
          "My Orders".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.textColor,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: context.subTextColor,
          tabs:  [
            Tab(text: "Apartments".tr()),
            Tab(text: "Services".tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// ================= APARTMENTS =================
          BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is OrdersError) {
                return ErrorView(
                  onRetry: () {
                    context.read<OrdersCubit>().getMyOrders();
                  },
                );
              }

              if (state is OrdersSuccess) {
                final orders = state.orders;

                return RefreshIndicator(
                  color: context.textColor,
                  backgroundColor: context.bgColor,
                  onRefresh: () async {
                    await context.read<OrdersCubit>().getMyOrders();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      if (order.unit == null) {
                        return const SizedBox();
                      }

                      return UnitCard(
                        unit: order.unit!,
                        showFavorite: false,
                        showOrderButton: false,
                      );
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          ),

          /// ================= SERVICES =================
          BlocBuilder<SolutionOrdersCubit, SolutionOrdersState>(
            builder: (context, state) {
              if (state is SolutionOrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SolutionOrdersError) {
                return ErrorView(
                  onRetry: () {
                    context.read<SolutionOrdersCubit>().getMySolutionOrders();
                  },
                );
              }

              if (state is SolutionOrdersSuccess) {
                final orders = state.orders;

                if (orders.isEmpty) {
                  return  Center(
                    child: Text('No orders found'.tr()),
                  );
                }

                return RefreshIndicator(
                  color: context.textColor,
                  backgroundColor: context.bgColor,
                  onRefresh: () async {
                    await context
                        .read<SolutionOrdersCubit>()
                        .getMySolutionOrders();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final solution = order.solution;

                      final image = solution.attachments.isNotEmpty
                          ? solution.attachments.first.url
                          : "";

                      final hasDiscount =
                          solution.hasActiveOffer &&
                              solution.discountPercentage > 0 &&
                              solution.originalPrice != solution.currentPrice;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.solutionDetails,
                            arguments: {
                              'id': solution.id,
                              'showOrderButton': false,
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: context.isDark
                                  ? Colors.white.withOpacity(0.06)
                                  : Colors.black.withOpacity(0.04),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  context.isDark ? 0.18 : 0.045,
                                ),
                                blurRadius: 18,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// ================= IMAGE =================
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 165,
                                      width: double.infinity,
                                      child: image.isNotEmpty
                                          ? Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                            ) {
                                          return _buildEmptyImage(context);
                                        },
                                      )
                                          : _buildEmptyImage(context),
                                    ),

                                    /// IMAGE GRADIENT
                                    Positioned.fill(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.08),
                                              Colors.black.withOpacity(0.30),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// STATUS
                                    Positioned(
                                      top: 13,
                                      left: 13,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 11,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.38),
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.18),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              order.status.toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// DISCOUNT
                                    if (hasDiscount)
                                      Positioned(
                                        top: 13,
                                        right: 13,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            '${solution.discountPercentage}% '+'OFF'.tr(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                /// ================= CONTENT =================
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    15,
                                    16,
                                    16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /// TITLE
                                      Text(
                                        solution.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: context.textColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      const SizedBox(height: 7),

                                      /// DESCRIPTION
                                      Text(
                                        solution.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: context.subTextColor,
                                          fontSize: 13,
                                          height: 1.45,
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      /// DIVIDER
                                      Divider(
                                        height: 1,
                                        thickness: 0.7,
                                        color: context.isDark
                                            ? Colors.white.withOpacity(0.07)
                                            : Colors.black.withOpacity(0.06),
                                      ),

                                      const SizedBox(height: 13),

                                      /// BOTTOM INFO
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          /// DATE
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary
                                                        .withOpacity(0.09),
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                  ),
                                                  child: Icon(
                                                    Icons.calendar_today_outlined,
                                                    size: 15,
                                                    color: AppColors.primary,
                                                  ),
                                                ),

                                                const SizedBox(width: 9),

                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Ordered'.tr(),
                                                        style: TextStyle(
                                                          color: context.subTextColor,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        order.createdAt,
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: context.textColor,
                                                          fontSize: 11.5,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          /// PRICE
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              if (hasDiscount)
                                                Text(
                                                  '\$${solution.originalPrice}',
                                                  style: TextStyle(
                                                    color: context.subTextColor,
                                                    fontSize: 11,
                                                    decoration:
                                                    TextDecoration.lineThrough,
                                                  ),
                                                ),

                                              const SizedBox(height: 1),

                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '\$${solution.currentPrice}',
                                                    style: const TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
Widget _buildEmptyImage(BuildContext context) {
  return Container(
    color: context.isDark
        ? Colors.white.withOpacity(0.04)
        : Colors.black.withOpacity(0.025),
    child: Center(
      child: Icon(
        Icons.image_outlined,
        size: 42,
        color: context.subTextColor.withOpacity(0.45),
      ),
    ),
  );
}
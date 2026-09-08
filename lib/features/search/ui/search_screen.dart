import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../home/ui/widgets/unit_card.dart';
import '../logic/search_cubit.dart';
import '../logic/search_state.dart';
import 'widgets/filter_bottom_sheet.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchCubit>()..loadLocations(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<SearchCubit>(),
        child: const FilterBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
      backgroundColor: context.bgColor,
      body: SafeArea(
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<SearchCubit>();
            final units = cubit.units;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// ================= HEADER =================

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Find Your Home".tr(),
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: context.textColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Discover a place that feels like home".tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context.subTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(.08)
                                : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              if (!isDark)
                                BoxShadow(
                                  color: Colors.black.withOpacity(.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                            ],
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: context.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// ================= SEARCH CARD =================

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                    child: GestureDetector(
                      onTap: () => _openFilters(context),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(.06)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withOpacity(.08)
                                : Colors.grey.shade200,
                          ),
                          boxShadow: [
                            if (!isDark)
                              BoxShadow(
                                color: Colors.black.withOpacity(.06),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(.10),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: const Icon(
                                Icons.search_rounded,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Search properties".tr(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: context.textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Location, price, type...".tr(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.subTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: const Icon(
                                Icons.tune_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// ================= RESULT HEADER =================

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
                    child: Row(
                      children: [
                        Text(
                          "Properties".tr(),
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: context.textColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (units.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${units.length}",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        const Spacer(),
                        if (units.isNotEmpty)
                          TextButton.icon(
                            onPressed: cubit.clearFilters,
                            icon: const Icon(
                              Icons.refresh_rounded,
                              size: 17,
                            ),
                            label:  Text("Clear".tr()),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                /// ================= LOADING =================

                if (state is SearchSearching)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )

                /// ================= EMPTY AFTER SEARCH =================

                else if (state is SearchEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptySearch(
                      icon: Icons.search_off_rounded,
                      title: "No Properties Found".tr(),
                      subtitle:
                          "Try changing your filters to find more properties.".tr(),
                      buttonText: "Change Filters".tr(),
                      onPressed: () => _openFilters(context),
                    ),
                  )

                /// ================= INITIAL =================

                else if (units.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptySearch(
                      icon: Icons.home_work_outlined,
                      title: "Find Your Perfect Home".tr(),
                      subtitle:
                          "Explore apartments and properties that match your needs.".tr(),
                      buttonText: "Start Searching".tr(),
                      onPressed: () => _openFilters(context),
                    ),
                  )

                /// ================= RESULTS =================

                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: UnitCard(
                              unit: units[index],
                            ),
                          );
                        },
                        childCount: units.length,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const _EmptySearch({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 52,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 26),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: context.textColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: context.subTextColor,
            ),
          ),
          const SizedBox(height: 26),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                Icons.tune_rounded,
                color: context.textColor,
              ),
              label: Text(
                buttonText,
                style: TextStyle(
                  color: context.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.cardColor,
                foregroundColor: context.textColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: context.isDark
                      ? Colors.white.withOpacity(.08)
                      : Colors.grey.shade200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

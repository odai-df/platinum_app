import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';
import 'package:platinum_app/features/home/ui/widgets/unit_card.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widgets/ErrorView.dart';
import '../../../units/logic/units_cubit.dart';
import '../../../units/logic/units_state.dart';

class UnitsSection extends StatefulWidget {
  const UnitsSection({super.key});

  @override
  State<UnitsSection> createState() => _UnitsSectionState();
}

class _UnitsSectionState extends State<UnitsSection> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        print("🔥 TRIGGER loadMore()");
        context.read<UnitsCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitsCubit, UnitsState>(
      builder: (context, state) {
        print("🖼️ UI STATE: $state");

        if (state is UnitsLoading) {
          return Expanded(
            child: ListView.builder(
              controller: _controller,
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: 4,
              itemBuilder: (_, __) => const UnitCardSkeleton(),
            ),
          );
        }

        if (state is UnitsFailure) {
          return ErrorView(
            onRetry: () {
              context.read<UnitsCubit>().fetchUnits();
            },
          );
        }
        if (state is UnitsSuccess) {
          print("🟢 SHOW SUCCESS - units: ${state.units.length}");

          return Expanded(
            child: ListView.builder(
                controller: _controller,
                itemCount: state.units.length + (state.isLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.units.length) {
                    return Column(
                      children: const [
                        UnitCardSkeleton(),
                        UnitCardSkeleton(),
                      ],
                    );
                  }

                  final unit = state.units[index]; // 🔥 هذا الناقص

                  return UnitCard(
                    unit: unit,
                    showFavorite: true,
                    // isFavorite: unit.isFavorite,

                    // onFavoriteTap: () async {
                    //   final cubit = context.read<FavoriteCubit>();
                    //
                    //   final isFav = unit.isFavorite;
                    //
                    //   try {
                    //     if (isFav) {
                    //       await cubit.removeFavorite(unit.id);
                    //     } else {
                    //       await cubit.toggleFavorite(unit.id);
                    //     }
                    //
                    //     // 🔥 update UI locally
                    //     context.read<UnitsCubit>().toggleLocalFavorite(unit.id);
                    //
                    //   } catch (e) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("Operation failed")),
                    //     );
                    //   }
                    // },
                  );
                }),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class UnitCardSkeleton extends StatelessWidget {
  const UnitCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      child: Shimmer.fromColors(
        baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              Container(
                height: 190,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// title + price
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 18,
                                width: 120,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 12,
                                width: 90,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    /// features
                    Row(
                      children: [
                        Container(
                          width: 95,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 95,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      height: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

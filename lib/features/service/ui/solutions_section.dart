import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_extension.dart';
import '../logic/solutions_cubit.dart';
import '../logic/solutions_state.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  @override
  void initState() {
    super.initState();
    context.read<SolutionsCubit>().getSolutions();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return BlocBuilder<SolutionsCubit, SolutionsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return _ServiceChipSkeleton();
              },
            ),
          ),
          error: (msg) => SizedBox(
            height: 70,
            child: Center(
              child: Text(
                msg,
                style: TextStyle(
                  color: context.subTextColor,
                ),
              ),
            ),
          ),
          success: (data) {
            // ما في خدمات
            if (data.isEmpty) {
              return const SizedBox.shrink();
            }

            // في خدمات
            return SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];

                  return _ServiceChip(
                    title: item.name,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.solutionDetails,
                        arguments: item.id,
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ServiceChip({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color:
                isDark ? AppColors.darkBorder : Colors.black.withOpacity(0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title.tr(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceChipSkeleton extends StatelessWidget {
  const _ServiceChipSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDark
          ? Colors.grey.shade800
          : Colors.grey.shade300,
      highlightColor: context.isDark
          ? Colors.grey.shade700
          : Colors.grey.shade100,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

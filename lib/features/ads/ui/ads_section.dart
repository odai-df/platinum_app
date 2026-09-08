import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/routing/routes.dart';
import '../../home/ui/widgets/ads_section.dart';
import '../logic/advertisements_cubit.dart';
import '../logic/advertisements_state.dart';

class AdsSection extends StatefulWidget {
  const AdsSection({super.key});

  @override
  State<AdsSection> createState() => _AdsSectionState();
}

class _AdsSectionState extends State<AdsSection> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AdvertisementsCubit>().getAds();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _statusBox({
    required IconData icon,
    required String message,
    Color color = Colors.grey,
    double height = 100,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: height,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.04)
              : Colors.black.withOpacity(0.025),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 24,
                color: color.withOpacity(0.65),
              ),
              const SizedBox(width: 10),
              Text(
                message,
                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.65),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const _AdsSkeleton(),
          error: (msg) => _statusBox(
            icon: Icons.error_outline,
            message: msg,
            color: Colors.red,
          ),
          success: (ads) {
            if (ads.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                SizedBox(
                  height: 190,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: ads.length,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final ad = ads[index];

                      final imageUrl = ad.attachments.isNotEmpty
                          ? ad.attachments.first.url
                          : 'https://via.placeholder.com/400';

                      return AnimatedScale(
                        duration: const Duration(milliseconds: 250),
                        scale: currentIndex == index ? 1 : 0.96,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.advertisementDetails,
                              arguments: ad.id,
                            );
                          },
                          child: AdCard(
                            title: ad.title,
                            image: imageUrl,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                if (ads.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      ads.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentIndex == index ? 20 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentIndex == index
                              ? const Color(0xff43a4f1)
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AdsSkeleton extends StatelessWidget {
  const _AdsSkeleton();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (_) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Shimmer.fromColors(
                baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                highlightColor:
                    isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                child: Container(
                  width: 18,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

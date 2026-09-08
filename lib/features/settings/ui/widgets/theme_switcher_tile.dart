import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_cubit.dart';

class ThemeSwitcherTile extends StatelessWidget {
  const ThemeSwitcherTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: Material(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _toggleTheme(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            child: Row(
              children: [
                /// ICON
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.amber.withOpacity(.12)
                        : AppColors.primary.withOpacity(.10),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: Icon(
                      isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      key: ValueKey(isDark),
                      color: isDark ? Colors.amber : AppColors.primary,
                      size: 21,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Theme".tr(),
                        style: TextStyle(
                          color: context.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          isDark ? "Dark mode".tr() : "Light mode".tr(),
                          key: ValueKey(isDark),
                          style: TextStyle(
                            color: context.subTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// SWITCH
                Switch.adaptive(
                  value: isDark,
                  activeColor: AppColors.primary,
                  onChanged: (_) => _toggleTheme(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    final cubit = context.read<ThemeCubit>();

    ThemeAnimationService().run(
      context,
      cubit.toggleTheme,
    );
  }
}

/// ============================================================
/// THEME ANIMATION SERVICE
/// ============================================================

class ThemeAnimationService {
  static final ThemeAnimationService _instance =
      ThemeAnimationService._internal();

  factory ThemeAnimationService() => _instance;

  ThemeAnimationService._internal();

  bool _isAnimating = false;

  void run(
    BuildContext context,
    VoidCallback onFinish,
  ) {
    if (_isAnimating) return;

    _isAnimating = true;

    final overlay = Overlay.of(context);

    final renderObject = context.findRenderObject();

    Offset center = Offset.zero;

    if (renderObject is RenderBox) {
      center = renderObject.localToGlobal(
        renderObject.size.center(Offset.zero),
      );
    }

    final currentIsDark = context.isDark;

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) {
        return _ThemeRevealAnimation(
          center: center,
          isGoingDark: !currentIsDark,
          onComplete: () {
            onFinish();

            if (entry.mounted) {
              entry.remove();
            }

            _isAnimating = false;
          },
        );
      },
    );

    overlay.insert(entry);
  }
}

/// ============================================================
/// REVEAL ANIMATION
/// ============================================================

class _ThemeRevealAnimation extends StatefulWidget {
  final Offset center;
  final bool isGoingDark;
  final VoidCallback onComplete;

  const _ThemeRevealAnimation({
    required this.center,
    required this.isGoingDark,
    required this.onComplete,
  });

  @override
  State<_ThemeRevealAnimation> createState() => _ThemeRevealAnimationState();
}

class _ThemeRevealAnimationState extends State<_ThemeRevealAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 850,
      ),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();

    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final maxRadius = _getMaxRadius(
      size,
      widget.center,
    );

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final progress = _animation.value;

          final radius = maxRadius * progress;

          // خفيف جداً بالبداية
          final opacity = Curves.easeOut.transform(
                progress,
              ) *
              0.88;

          return ClipPath(
            clipper: _CircleClipper(
              center: widget.center,
              radius: radius,
            ),
            child: Container(
              width: size.width,
              height: size.height,
              color: widget.isGoingDark
                  ? const Color(0xff111827).withOpacity(
                      opacity,
                    )
                  : Colors.white.withOpacity(
                      opacity,
                    ),
            ),
          );
        },
      ),
    );
  }

  double _getMaxRadius(
    Size size,
    Offset center,
  ) {
    final corners = [
      const Offset(0, 0),
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ];

    double maxDistance = 0;

    for (final corner in corners) {
      final dx = corner.dx - center.dx;
      final dy = corner.dy - center.dy;

      final distance = sqrt(
        dx * dx + dy * dy,
      );

      maxDistance = max(
        maxDistance,
        distance,
      );
    }

    return maxDistance;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// ============================================================
/// CIRCLE CLIPPER
/// ============================================================

class _CircleClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  const _CircleClipper({
    required this.center,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );
  }

  @override
  bool shouldReclip(
    covariant _CircleClipper oldClipper,
  ) {
    return oldClipper.center != center || oldClipper.radius != radius;
  }
}

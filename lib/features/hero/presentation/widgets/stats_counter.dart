import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

class StatsCounter extends StatelessWidget {
  final String value;
  final String label;

  const StatsCounter({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

// class AnimatedStatsCounter extends StatelessWidget {
//   final String value;
//   final String label;
//   final Duration duration;

//   const AnimatedStatsCounter({
//     super.key,
//     required this.value,
//     required this.label,
//     this.duration = const Duration(seconds: 2),
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final int? numericalValue = int.tryParse(
//       value.replaceAll(RegExp(r'[^0-9]'), ''),
//     );

//     return Column(
//       children: [
//         if (numericalValue != null)
//           TweenAnimationBuilder<double>(
//             tween: Tween(begin: 0, end: numericalValue.toDouble()),
//             duration: duration,
//             curve: Curves.easeOut,
//             builder: (context, value, child) {
//               return Text(
//                 '${value.toInt()}+',
//                 style: TextStyle(
//                   color: AppColors.primaryColor,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             },
//           )
//         else
//           Text(
//             value,
//             style: TextStyle(
//               color: AppColors.primaryColor,
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(
//             color: isDark
//                 ? AppColors.textSecondaryDark
//                 : AppColors.textSecondaryLight,
//             fontSize: 16,
//           ),
//         ),
//       ],
//     );
//   }
// }

class AnimatedStatsCounter extends StatefulWidget {
  final String value;
  final String label;
  final Duration duration;
  final IconData? icon;
  final bool animate;
  final bool isDark;

  const AnimatedStatsCounter({
    super.key,
    required this.value,
    required this.label,
    this.duration = const Duration(seconds: 2),
    this.icon,
    this.animate = true,
    required this.isDark,
  });

  @override
  State<AnimatedStatsCounter> createState() => _AnimatedStatsCounterState();
}

class _AnimatedStatsCounterState extends State<AnimatedStatsCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _countAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  int get numericValue {
    return int.tryParse(widget.value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _countAnimation = Tween<double>(
      begin: 0,
      end: numericValue.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: AppColors.primaryColor, size: 24),
                    const SizedBox(height: 15),
                  ],
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _countAnimation.value.round().toString(),
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.value.contains('+')) ...[
                        Text(
                          '+',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatsCounterRow extends StatelessWidget {
  final List<StatsItem> items;
  final bool isDark;
  final double spacing;
  final bool animate;
  final ScrollController? scrollController;
  final double scrollTriggerOffset;

  const StatsCounterRow({
    super.key,
    required this.items,
    required this.isDark,
    this.spacing = 20,
    this.animate = true,
    this.scrollController,
    this.scrollTriggerOffset = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return _buildMobileLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  Widget _buildMobileLayout() {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: _buildAnimatedCounter(item),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: _buildAnimatedCounter(item, delay: index * 0.2),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnimatedCounter(StatsItem item, {double delay = 0.0}) {
    if (scrollController != null) {
      return ScrollAnimatedStatsCounter(
        value: item.value,
        label: item.label,
        icon: item.icon,
        isDark: isDark,
        scrollController: scrollController!,
        scrollTriggerOffset: scrollTriggerOffset,
        delay: delay,
      );
    } else {
      return AnimatedStatsCounter(
        value: item.value,
        label: item.label,
        icon: item.icon,
        isDark: isDark,
        animate: animate,
        duration: Duration(milliseconds: 2000 + (delay * 500).toInt()),
      );
    }
  }
}

class ScrollAnimatedStatsCounter extends StatefulWidget {
  final String value;
  final String label;
  final IconData? icon;
  final bool isDark;
  final ScrollController scrollController;
  final double scrollTriggerOffset;
  final double delay;

  const ScrollAnimatedStatsCounter({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    required this.isDark,
    required this.scrollController,
    this.scrollTriggerOffset = 0.5,
    this.delay = 0.0,
  });

  @override
  State<ScrollAnimatedStatsCounter> createState() =>
      _ScrollAnimatedStatsCounterState();
}

class _ScrollAnimatedStatsCounterState
    extends State<ScrollAnimatedStatsCounter> {
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_checkScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkScroll);
    super.dispose();
  }

  void _checkScroll() {
    if (_hasAnimated) return;

    final scrollPosition = widget.scrollController.position.pixels;
    final maxScrollExtent = widget.scrollController.position.maxScrollExtent;

    // Calculate scroll percentage (0.0 to 1.0)
    final scrollPercentage = scrollPosition / maxScrollExtent;

    if (scrollPercentage >= widget.scrollTriggerOffset) {
      setState(() {
        _hasAnimated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedStatsCounter(
      value: widget.value,
      label: widget.label,
      icon: widget.icon,
      isDark: widget.isDark,
      animate: _hasAnimated,
      duration: Duration(milliseconds: 2000 + (widget.delay * 500).toInt()),
    );
  }
}

class StatsItem {
  final String value;
  final String label;
  final IconData? icon;

  const StatsItem({required this.value, required this.label, this.icon});
}

// Helper class for responsive design
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}

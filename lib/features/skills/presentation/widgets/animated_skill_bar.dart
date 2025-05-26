import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

import '../../../../core/utils/responsive.dart';

// Enhanced AnimatedSkillBar with fixed width calculation
class AnimatedSkillBar extends StatefulWidget {
  final String skillName;
  final double percentage;
  final bool isDark;
  final Duration animationDuration;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollStartOffset;
  final Color? progressColor;

  const AnimatedSkillBar({
    super.key,
    required this.skillName,
    required this.percentage,
    required this.isDark,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animateOnScroll = false,
    this.scrollController,
    this.scrollStartOffset = 0.0,
    this.progressColor,
  });

  @override
  State<AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<AnimatedSkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percentage,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.addListener(_handleScrollListener);
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _controller.forward();
          _hasAnimated = true;
        }
      });
    }
  }

  void _handleScrollListener() {
    if (!widget.animateOnScroll ||
        widget.scrollController == null ||
        _hasAnimated)
      return;

    final double scrollPosition = widget.scrollController!.position.pixels;
    final double maxScrollExtent =
        widget.scrollController!.position.maxScrollExtent;
    final double scrollPercentage = scrollPosition / maxScrollExtent;

    if (scrollPercentage >= widget.scrollStartOffset) {
      _controller.forward();
      _hasAnimated = true;
      widget.scrollController!.removeListener(_handleScrollListener);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.removeListener(_handleScrollListener);
    }
    super.dispose();
  }

  double _getBarHeight(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 12;
    } else if (Responsive.isTablet(context)) {
      return 10;
    } else {
      return 8;
    }
  }

  double _getFontSize(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 16;
    } else if (Responsive.isTablet(context)) {
      return 15;
    } else {
      return 14;
    }
  }

  double _getPercentageFontSize(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 13;
    } else if (Responsive.isTablet(context)) {
      return 12;
    } else {
      return 11;
    }
  }

  double _getCardPadding(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 20;
    } else if (Responsive.isTablet(context)) {
      return 16;
    } else {
      return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    final barHeight = _getBarHeight(context);
    final fontSize = _getFontSize(context);
    final percentageFontSize = _getPercentageFontSize(context);
    final cardPadding = _getCardPadding(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: widget.isDark
                ? Colors.grey[850]?.withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isDark
                  ? Colors.grey[700]?.withOpacity(0.5) ?? Colors.grey
                  : Colors.grey[300]?.withOpacity(0.5) ?? Colors.grey,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isDark
                    ? Colors.black.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.skillName,
                      style: TextStyle(
                        color: widget.isDark ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: cardPadding * 0.4,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      // color: (widget.progressColor ?? AppColors.primaryColor)
                      //     .withOpacity(0.1),
                      color: (widget.progressColor ?? AppColors.info)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${(_animation.value * 100).toInt()}%',
                      style: TextStyle(
                        // color: widget.progressColor ?? AppColors.primaryColor,
                        color: widget.progressColor ?? AppColors.info,
                        fontWeight: FontWeight.bold,
                        fontSize: percentageFontSize,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: cardPadding * 0.6),
              // Use LayoutBuilder to get the actual container width
              LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Background Bar
                      Container(
                        height: barHeight,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? Colors.grey[700]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(barHeight / 2),
                        ),
                      ),
                      // Progress Bar - Fixed width calculation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: barHeight,
                        width:
                            constraints.maxWidth *
                            _animation
                                .value, // Use container width instead of screen width
                        decoration: BoxDecoration(
                          // color: widget.progressColor ?? AppColors.primaryColor,
                          color: widget.progressColor ?? AppColors.info,
                          borderRadius: BorderRadius.circular(barHeight / 2),
                          boxShadow: [
                            BoxShadow(
                              // color:
                              //     (widget.progressColor ??
                              //             AppColors.primaryColor)
                              //         .withOpacity(0.3),
                              color: (widget.progressColor ?? AppColors.info)
                                  .withOpacity(0.3),
                              blurRadius: Responsive.isDesktop(context) ? 6 : 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      // Shine effect for desktop
                      if (Responsive.isDesktop(context))
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: barHeight,
                          width: constraints.maxWidth * _animation.value,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.0),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(barHeight / 2),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Enhanced AnimatedCircularSkill with better responsive design
class AnimatedCircularSkill extends StatefulWidget {
  final String skillName;
  final double percentage;
  final bool isDark;
  final Duration animationDuration;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollStartOffset;
  final double? size;
  final Color? progressColor;

  const AnimatedCircularSkill({
    super.key,
    required this.skillName,
    required this.percentage,
    required this.isDark,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animateOnScroll = false,
    this.scrollController,
    this.scrollStartOffset = 0.0,
    this.size,
    this.progressColor,
  });

  @override
  State<AnimatedCircularSkill> createState() => _AnimatedCircularSkillState();
}

class _AnimatedCircularSkillState extends State<AnimatedCircularSkill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percentage,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.addListener(_handleScrollListener);
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _controller.forward();
          _hasAnimated = true;
        }
      });
    }
  }

  void _handleScrollListener() {
    if (!widget.animateOnScroll ||
        widget.scrollController == null ||
        _hasAnimated)
      return;

    final double scrollPosition = widget.scrollController!.position.pixels;
    final double maxScrollExtent =
        widget.scrollController!.position.maxScrollExtent;
    final double scrollPercentage = scrollPosition / maxScrollExtent;

    if (scrollPercentage >= widget.scrollStartOffset) {
      _controller.forward();
      _hasAnimated = true;
      widget.scrollController!.removeListener(_handleScrollListener);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.removeListener(_handleScrollListener);
    }
    super.dispose();
  }

  // Improved responsive sizing methods
  double _getSize(BuildContext context) {
    if (widget.size != null) return widget.size!;

    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return 120;
    } else if (width >= 900) {
      return 110;
    } else if (width >= 600) {
      return 100;
    } else if (width >= 400) {
      return 90;
    } else {
      return 80;
    }
  }

  double _getStrokeWidth(BuildContext context) {
    final size = _getSize(context);
    return size * 0.08; // 8% of the circle size
  }

  double _getPercentageFontSize(BuildContext context) {
    final size = _getSize(context);
    return size * 0.18; // 18% of the circle size
  }

  double _getSkillNameFontSize(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 16;
    } else if (Responsive.isTablet(context)) {
      return 15;
    } else if (Responsive.isSmallMobile(context)) {
      return 13;
    } else {
      return 14;
    }
  }

  double _getCardPadding(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 20;
    } else if (Responsive.isTablet(context)) {
      return 16;
    } else {
      return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = _getSize(context);
    final strokeWidth = _getStrokeWidth(context);
    final percentageFontSize = _getPercentageFontSize(context);
    final skillNameFontSize = _getSkillNameFontSize(context);
    final cardPadding = _getCardPadding(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: widget.isDark
                ? Colors.grey[850]?.withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isDark
                  ? Colors.grey[700]?.withOpacity(0.5) ?? Colors.grey
                  : Colors.grey[300]?.withOpacity(0.5) ?? Colors.grey,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isDark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: CircularProgressIndicator(
                          value: _animation.value,
                          strokeWidth: strokeWidth,
                          backgroundColor: widget.isDark
                              ? Colors.grey[700]
                              : Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.progressColor ?? Colors.blue,
                          ),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(_animation.value * 100).toInt()}%',
                            style: TextStyle(
                              color: widget.progressColor ?? Colors.blue,
                              fontSize: percentageFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (Responsive.isDesktop(context))
                            Container(
                              width: size * 0.25,
                              height: 2,
                              margin: const EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                color: widget.progressColor ?? Colors.blue,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: cardPadding * 0.8),
              Text(
                widget.skillName,
                style: TextStyle(
                  color: widget.isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: skillNameFontSize,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

// إضافة مكون لعرض مجموعة من المهارات بتخطيط مرن
class ResponsiveSkillsGrid extends StatelessWidget {
  final List<Widget> skills;
  final bool isCircular;

  const ResponsiveSkillsGrid({
    super.key,
    required this.skills,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCircular) {
      return ResponsiveGridView(
        childAspectRatio: Responsive.isDesktop(context) ? 0.9 : 1.0,
        crossAxisSpacing: Responsive.isDesktop(context) ? 24 : 16,
        mainAxisSpacing: Responsive.isDesktop(context) ? 24 : 16,
        children: skills,
      );
    } else {
      return Column(
        children: skills
            .map(
              (skill) => Padding(
                padding: EdgeInsets.only(
                  bottom: Responsive.isDesktop(context) ? 20 : 16,
                ),
                child: skill,
              ),
            )
            .toList(),
      );
    }
  }
}

// إضافة مجموعة مهارات مع تأثيرات حركية
// Enhanced AnimatedSkillsGrid with better responsive grid
class AnimatedSkillsGrid extends StatefulWidget {
  final Map<String, double> skills;
  final bool isDark;
  final ScrollController scrollController;
  final bool useCircular;

  const AnimatedSkillsGrid({
    super.key,
    required this.skills,
    required this.isDark,
    required this.scrollController,
    this.useCircular = false,
  });

  @override
  State<AnimatedSkillsGrid> createState() => _AnimatedSkillsGridState();
}

class _AnimatedSkillsGridState extends State<AnimatedSkillsGrid> {
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1400) {
      return 5;
    } else if (width >= 1200) {
      return 4;
    } else if (width >= 900) {
      return 3;
    } else if (width >= 600) {
      return 2;
    } else {
      return 1;
    }
  }

  double _getChildAspectRatio(BuildContext context) {
    if (widget.useCircular) {
      return Responsive.isMobile(context) ? 0.9 : 1.0;
    } else {
      return 3.0; // For skill bars
    }
  }

  double _getSpacing(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 20;
    } else if (Responsive.isTablet(context)) {
      return 16;
    } else {
      return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.red,
      Colors.indigo,
      Colors.pink,
    ];

    if (widget.useCircular) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              crossAxisSpacing: _getSpacing(context),
              mainAxisSpacing: _getSpacing(context),
              childAspectRatio: _getChildAspectRatio(context),
            ),
            itemCount: widget.skills.length,
            itemBuilder: (context, index) {
              final skill = widget.skills.entries.elementAt(index);
              return AnimatedCircularSkill(
                skillName: skill.key,
                percentage: skill.value,
                isDark: widget.isDark,
                animateOnScroll: true,
                scrollController: widget.scrollController,
                scrollStartOffset: 0.5,
                progressColor: colors[index % colors.length],
              );
            },
          );
        },
      );
    } else {
      // For linear skill bars - implement AnimatedSkillBar here
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.skills.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: _getSpacing(context)),
        itemBuilder: (context, index) {
          final skill = widget.skills.entries.elementAt(index);
          // You would implement AnimatedSkillBar similar to AnimatedCircularSkill
          return Container(
            padding: EdgeInsets.all(_getSpacing(context)),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? Colors.grey[850]?.withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isDark
                    ? Colors.grey[700]?.withOpacity(0.5) ?? Colors.grey
                    : Colors.grey[300]?.withOpacity(0.5) ?? Colors.grey,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skill.key,
                  style: TextStyle(
                    color: widget.isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.isDesktop(context) ? 16 : 14,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: skill.value,
                  backgroundColor: widget.isDark
                      ? Colors.grey[700]
                      : Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colors[index % colors.length],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(skill.value * 100).toInt()}%',
                  style: TextStyle(
                    color: colors[index % colors.length],
                    fontSize: Responsive.isDesktop(context) ? 14 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}

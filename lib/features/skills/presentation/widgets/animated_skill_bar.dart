import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

class AnimatedSkillBar extends StatefulWidget {
  final String skillName;
  final double percentage;
  final bool isDark;
  final Duration animationDuration;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollStartOffset;

  const AnimatedSkillBar({
    super.key,
    required this.skillName,
    required this.percentage,
    required this.isDark,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animateOnScroll = false,
    this.scrollController,
    this.scrollStartOffset = 0.0,
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
      _controller.forward();
      _hasAnimated = true;
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
      // يمكننا إزالة المستمع بمجرد تشغيل الرسوم المتحركة
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.skillName,
                  style: TextStyle(
                    color: widget.isDark
                        ? AppColors.textDark
                        : AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(_animation.value * 100).toInt()}%',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                // Background Bar
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? AppColors.darkCard
                        : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                // Progress Bar
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width * _animation.value,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class AnimatedCircularSkill extends StatefulWidget {
  final String skillName;
  final double percentage;
  final bool isDark;
  final Duration animationDuration;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollStartOffset;
  final double size;
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
    this.size = 100.0,
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
      _controller.forward();
      _hasAnimated = true;
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
      // يمكننا إزالة المستمع بمجرد تشغيل الرسوم المتحركة
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: widget.size,
                      height: widget.size,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 8,
                        backgroundColor: widget.isDark
                            ? AppColors.darkCard
                            : AppColors.lightCard,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.progressColor ?? AppColors.primaryColor,
                        ),
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
                            color:
                                widget.progressColor ?? AppColors.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.skillName,
              style: TextStyle(
                color: widget.isDark ? AppColors.textDark : AppColors.textLight,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}

// إضافة مجموعة مهارات مع تأثيرات حركية
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
  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      AppColors.primaryColor,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    if (widget.useCircular) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 768 ? 4 : 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
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
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.skills.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final skill = widget.skills.entries.elementAt(index);
          return AnimatedSkillBar(
            skillName: skill.key,
            percentage: skill.value,
            isDark: widget.isDark,
            animateOnScroll: true,
            scrollController: widget.scrollController,
            scrollStartOffset: 0.5,
          );
        },
      );
    }
  }
}

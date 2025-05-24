import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class ExperienceCard extends StatefulWidget {
  final String company;
  final String role;
  final String duration;
  final String location;
  final List<String> description;
  final bool isDark;
  final double delay;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollTriggerOffset;

  const ExperienceCard({
    super.key,
    required this.company,
    required this.role,
    required this.duration,
    required this.location,
    required this.description,
    required this.isDark,
    required this.delay,
    this.animateOnScroll = false,
    this.scrollController,
    this.scrollTriggerOffset = 0.3,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _hasAnimated = false;
  final GlobalKey _cardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800 + (widget.delay * 300).toInt()),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    if (widget.animateOnScroll && widget.scrollController != null) {
      // تأخير قصير للسماح بتجهيز العناصر البصرية
      Future.delayed(Duration(milliseconds: 100), () {
        widget.scrollController!.addListener(_checkScroll);
        _checkScroll(); // تحقق فورًا من وضع التمرير الحالي
      });
    } else {
      Future.delayed(Duration(milliseconds: (widget.delay * 300).toInt()), () {
        if (mounted) {
          _controller.forward();
          _hasAnimated = true;
        }
      });
    }
  }

  // التحقق من وضع التمرير باستخدام موقع العنصر
  void _checkScroll() {
    if (_hasAnimated || widget.scrollController == null) return;

    if (_cardKey.currentContext != null) {
      final RenderBox renderBox =
          _cardKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;

      // عنصر مرئي عندما يكون في نصف الشاشة السفلي
      if (position.dy <= screenHeight * 0.8) {
        setState(() {
          _hasAnimated = true;
        });
        _controller.forward();

        // إلغاء المستمع بعد تشغيل الرسوم المتحركة
        widget.scrollController!.removeListener(_checkScroll);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.removeListener(_checkScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _cardKey,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_slideAnimation.value, 0),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimeline(),
                      const SizedBox(width: 30),
                      Expanded(child: _buildCard()),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        // دائرة متحركة على خط الزمن
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.accentColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(
                      0.5 * _fadeAnimation.value,
                    ),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            );
          },
        ),
        // خط زمني متحرك
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 2,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryColor,
                    widget.isDark
                        ? AppColors.darkCard
                        : AppColors.lightSecondary,
                  ],
                  stops: [0.0, 0.5],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: widget.isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context),
          const SizedBox(height: 20),
          ...widget.description.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            // تأخير ظهور كل عنصر بالوصف
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // حساب معامل التأخير لكل عنصر
                final double progressFactor =
                    (_controller.value - (index * 0.1)).clamp(0.0, 1.0);

                return Opacity(
                  opacity: progressFactor,
                  child: Transform.translate(
                    offset: Offset(20 * (1 - progressFactor), 0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: widget.isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // استخدام عمود للمحمول
        final useColumn = constraints.maxWidth < 500;

        if (useColumn) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleCompanySection(),
              const SizedBox(height: 15),
              _buildDateLocationSection(),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTitleCompanySection()),
              const SizedBox(width: 20),
              _buildDateLocationSection(),
            ],
          );
        }
      },
    );
  }

  Widget _buildTitleCompanySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.role,
          style: TextStyle(
            color: widget.isDark ? AppColors.textDark : AppColors.textLight,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 5),
        Text(
          widget.company,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildDateLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 5),
              Text(
                widget.duration,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: widget.isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            const SizedBox(width: 5),
            Text(
              widget.location,
              style: TextStyle(
                color: widget.isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

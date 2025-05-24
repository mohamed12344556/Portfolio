import 'package:flutter/material.dart';
import '../../../../core/shared/animations/animated_text.dart';
import '../../../../core/shared/animations/fade_animation.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_title.dart';
import 'certification_viewer.dart';
import 'education_card.dart';

class EducationSection extends StatefulWidget {
  final ScrollController? scrollController;

  const EducationSection({super.key, this.scrollController});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  final _localScrollController = ScrollController();

  ScrollController get _effectiveScrollController =>
      widget.scrollController ?? _localScrollController;

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _localScrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: ResponsivePadding.getAll(context),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsivePadding.getContentWidth(context),
          ),
          child: Column(
            children: [
              const SectionTitle(title: AppStrings.educationTitle),
              const SizedBox(height: 20),
              FadeAnimation(
                delay: 0.2,
                child: AnimatedGradientText(
                  text: "Academic Background & Professional Development",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  gradient: AppColors.primaryGradient,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              FadeAnimation(
                delay: 0.3,
                child: AnimatedText(
                  text:
                      "My educational journey has equipped me with the knowledge and skills to excel in mobile app development",
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: 16,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                  animateOnScroll: true,
                  scrollController: _effectiveScrollController,
                  scrollStartOffset: 0.2,
                ),
              ),
              const SizedBox(height: 60),
              _buildEducation(context, isDark),
              const SizedBox(height: 80),
              FadeAnimation(
                delay: 0.4,
                child: Column(
                  children: [
                    AnimatedGradientText(
                      text: AppStrings.certificationsTitle,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      gradient: AppColors.primaryGradient,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Continuous learning and professional development",
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _buildCertifications(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducation(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildEducationItem(
          context,
          isDark,
          title: 'Digital Egypt Pioneers Initiative - DEPI',
          subtitle: 'Mobile App Development Track',
          duration: 'Oct 2024 - present',
          location: 'Cairo, Egypt',
          description:
              'An intensive training program by the Egyptian Ministry of Communications and Information Technology, specializing in Mobile App Development track.',
          delay: 0.2,
          scrollOffset: 0.3,
        ),
        const SizedBox(height: 30),
        _buildEducationItem(
          context,
          isDark,
          title: 'Faculty of Computers and Artificial Intelligence',
          subtitle: 'Bachelor of Computer Science',
          duration: '2021 - 2025',
          location: 'El Fayoum, Egypt',
          description:
              'Department of Computer Science, Graduation year 2025 with GPA 2.7',
          delay: 0.3,
          scrollOffset: 0.35,
        ),
      ],
    );
  }

  Widget _buildEducationItem(
    BuildContext context,
    bool isDark, {
    required String title,
    required String subtitle,
    required String duration,
    required String location,
    required String description,
    required double delay,
    required double scrollOffset,
  }) {
    return FadeAnimation(
      delay: delay,
      child: AnimatedEducationCard(
        title: title,
        subtitle: subtitle,
        duration: duration,
        location: location,
        description: description,
        isDark: isDark,
        scrollController: _effectiveScrollController,
        scrollTriggerOffset: scrollOffset,
      ),
    );
  }

  Widget _buildCertifications(BuildContext context, bool isDark) {
    final List<Map<String, String>> certifications = [
      {
        'title': 'Mobile Development using Flutter, ITI (Sep 2022 - Oct 2022)',
        'pdfUrl': 'assets/pdfs/UC-cfab72e7-97bd-41d9-a715-3804c988506e.pdf',
      },
      {
        'title':
            'Complete Flutter & Dart Development Course, Udemy (Aug 2023 - Oct 2023)',
        'pdfUrl': 'assets/pdfs/UC-cfab72e7-97bd-41d9-a715-3804c988506e.pdf',
      },
      {
        'title':
            'Flutter Advanced Course Bloc and MVVM Pattern, Udemy (Aug 2024)',
        'pdfUrl': 'https://example.com/certificates/flutter_bloc.pdf',
      },
      {
        'title': 'Flutter Clean Architecture, Udemy (Sep 2024)',
        'pdfUrl': 'https://example.com/certificates/flutter_clean.pdf',
      },
      {
        'title': 'Git and GitHub, Coursera (Apr 2022 - May 2022)',
        'pdfUrl': 'https://example.com/certificates/git_github.pdf',
      },
      {
        'title': 'Cyber Security, ITI (Aug 2023 - Sep 2023)',
        'pdfUrl': 'https://example.com/certificates/cyber_security.pdf',
      },
      {
        'title':
            'Introduction to Artificial Intelligence and Applications Training, Zewail City (Aug 2023 - Oct 2023)',
        'pdfUrl': 'https://example.com/certificates/ai_zewail.pdf',
      },
    ];

    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: certifications.map((cert) {
        return FadeAnimation(
          delay: 0.5 + (certifications.indexOf(cert) * 0.1),
          child: EnhancedCertificationChip(
            title: cert['title']!,
            isDark: isDark,
            pdfUrl: cert['pdfUrl']!,
          ),
        );
      }).toList(),
    );
  }
}

class AnimatedEducationCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String location;
  final String description;
  final bool isDark;
  final ScrollController scrollController;
  final double scrollTriggerOffset;

  const AnimatedEducationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.location,
    required this.description,
    required this.isDark,
    required this.scrollController,
    required this.scrollTriggerOffset,
  });

  @override
  State<AnimatedEducationCard> createState() => _AnimatedEducationCardState();
}

class _AnimatedEducationCardState extends State<AnimatedEducationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    widget.scrollController.addListener(_checkScroll);
  }

  void _checkScroll() {
    if (_hasAnimated) return;

    final scrollPosition = widget.scrollController.position.pixels;
    final maxScrollExtent = widget.scrollController.position.maxScrollExtent;
    final scrollPercentage = scrollPosition / maxScrollExtent;

    if (scrollPercentage >= widget.scrollTriggerOffset) {
      setState(() {
        _hasAnimated = true;
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.scrollController.removeListener(_checkScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: EducationCard(
              title: widget.title,
              subtitle: widget.subtitle,
              duration: widget.duration,
              location: widget.location,
              description: widget.description,
              isDark: widget.isDark,
            ),
          ),
        );
      },
    );
  }
}

class AnimatedCertificationsGrid extends StatefulWidget {
  final List<Map<String, String>> certifications;
  final bool isDark;
  final ScrollController scrollController;
  final double scrollTriggerOffset;

  const AnimatedCertificationsGrid({
    super.key,
    required this.certifications,
    required this.isDark,
    required this.scrollController,
    required this.scrollTriggerOffset,
  });

  @override
  State<AnimatedCertificationsGrid> createState() =>
      _AnimatedCertificationsGridState();
}

class _AnimatedCertificationsGridState
    extends State<AnimatedCertificationsGrid> {
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_checkScroll);
  }

  void _checkScroll() {
    if (_hasAnimated) return;

    final scrollPosition = widget.scrollController.position.pixels;
    final maxScrollExtent = widget.scrollController.position.maxScrollExtent;
    final scrollPercentage = scrollPosition / maxScrollExtent;

    if (scrollPercentage >= widget.scrollTriggerOffset) {
      setState(() {
        _hasAnimated = true;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: widget.certifications.asMap().entries.map((entry) {
        final index = entry.key;
        final cert = entry.value;

        return FadeAnimation(
          delay: _hasAnimated
              ? 0.5 + (index * 0.1)
              : 999, // Large delay if not triggered
          child: EnhancedCertificationChip(
            title: cert['title']!,
            isDark: widget.isDark,
            pdfUrl: cert['pdfUrl']!,
          ),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/shared/animations/animated_text.dart';
import 'package:personal_portfolio/core/shared/animations/fade_animation.dart';
import 'package:personal_portfolio/core/shared/models/experience_model.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/utils/responsive.dart';
import 'package:personal_portfolio/core/widgets/section_title.dart';
import 'package:personal_portfolio/features/experience/presentation/widgets/experience_card.dart';

class ExperienceSection extends StatefulWidget {
  final ScrollController? scrollController;

  const ExperienceSection({super.key, this.scrollController});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
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
        color: isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsivePadding.getContentWidth(context),
          ),
          child: Column(
            children: [
              const SectionTitle(title: AppStrings.experienceTitle),
              const SizedBox(height: 20),
              FadeAnimation(
                delay: 0.2,
                child: AnimatedGradientText(
                  text: "My Professional Journey",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  gradient: AppColors.primaryGradient,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              FadeAnimation(
                delay: 0.3,
                child: AnimatedText(
                  text:
                      "Over the years, I've had the opportunity to work on various exciting projects and collaborate with talented teams",
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
              _buildExperienceContent(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceContent(BuildContext context, bool isDark) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ExperienceData.experiences.length,
      itemBuilder: (context, index) {
        final experience = ExperienceData.experiences[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ExperienceCard(
            company: experience.company,
            role: experience.role,
            duration: experience.duration,
            location: experience.location,
            description: experience.description,
            isDark: isDark,
            delay: index * 0.2,
            animateOnScroll: true,
            scrollController: _effectiveScrollController,
            scrollTriggerOffset: 0.2 + (index * 0.05),
          ),
        );
      },
    );
  }
}

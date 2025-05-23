import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/shared/animations/animated_text.dart';
import 'package:personal_portfolio/core/shared/animations/fade_animation.dart';
import 'package:personal_portfolio/features/home/data/models/skill_model.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/utils/responsive.dart';
import 'package:personal_portfolio/core/widgets/section_title.dart';
import 'package:personal_portfolio/features/skills/presentation/widgets/animated_skill_bar.dart';

class SkillsSection extends StatefulWidget {
  final ScrollController? scrollController;

  const SkillsSection({super.key, this.scrollController});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  final ScrollController _localScrollController = ScrollController();
  bool _showCircularSkills = false;

  ScrollController get _effectiveScrollController =>
      widget.scrollController ?? _localScrollController;

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
              FadeAnimation(
                delay: 0.1,
                child: const SectionTitle(title: AppStrings.skillsTitle),
              ),
              const SizedBox(height: 20),
              FadeAnimation(
                delay: 0.2,
                child: AnimatedText(
                  text:
                      "These are the technologies and tools I've mastered over the years",
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  animateOnScroll: true,
                  scrollController: _effectiveScrollController,
                  scrollStartOffset: 0.2,
                  scrollEndOffset: 0.4,
                ),
              ),
              const SizedBox(height: 40),

              // زر تبديل عرض المهارات
              FadeAnimation(
                delay: 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        _showCircularSkills
                            ? Icons.linear_scale
                            : Icons.pie_chart,
                        color: Colors.white,
                      ),
                      label: Text(
                        _showCircularSkills ? 'Show Bars' : 'Show Circles',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _showCircularSkills = !_showCircularSkills;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              _showCircularSkills
                  ? _buildCircularSkillsView(context, isDark)
                  : _buildSkillsContent(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsContent(BuildContext context, bool isDark) {
    return Responsive(
      mobile: _buildMobileSkills(isDark),
      desktop: _buildDesktopSkills(isDark),
    );
  }

  Widget _buildMobileSkills(bool isDark) {
    return Column(
      children: SkillData.categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: FadeAnimation(
            delay: 0.4 + (index * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      category.icon,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    AnimatedGradientText(
                      text: category.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      gradient: AppColors.primaryGradient,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...category.skills.map((skill) {
                  final proficiency = SkillData.skillProficiency[skill] ?? 0.6;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: AnimatedSkillBar(
                      skillName: skill,
                      percentage: proficiency,
                      isDark: isDark,
                      animateOnScroll: true,
                      scrollController: _effectiveScrollController,
                      scrollStartOffset: 0.3,
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopSkills(bool isDark) {
    // Create a grid of skills with 3 columns
    final List<Widget> columns = [];
    final int columnCount = 3;

    for (int i = 0; i < columnCount; i++) {
      final List<Widget> columnChildren = [];

      for (int j = i; j < SkillData.categories.length; j += columnCount) {
        if (j < SkillData.categories.length) {
          final category = SkillData.categories[j];
          columnChildren.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: FadeAnimation(
                delay: 0.4 + (j * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          category.icon,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        AnimatedGradientText(
                          text: category.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          gradient: AppColors.primaryGradient,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...category.skills.map((skill) {
                      final proficiency =
                          SkillData.skillProficiency[skill] ?? 0.6;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: AnimatedSkillBar(
                          skillName: skill,
                          percentage: proficiency,
                          isDark: isDark,
                          animateOnScroll: true,
                          scrollController: _effectiveScrollController,
                          scrollStartOffset: 0.3,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        }
      }

      columns.add(
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnChildren,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        columns[0],
        const SizedBox(width: 30),
        columns[1],
        const SizedBox(width: 30),
        columns[2],
      ],
    );
  }

  // طريقة عرض المهارات بشكل دائري
  Widget _buildCircularSkillsView(BuildContext context, bool isDark) {
    // تحويل المهارات من SkillData إلى قائمة مسطحة من المهارات مع درجة الإتقان
    final Map<String, double> flatSkills = {};

    for (var category in SkillData.categories) {
      for (var skill in category.skills) {
        flatSkills[skill] = SkillData.skillProficiency[skill] ?? 0.6;
      }
    }

    return AnimatedSkillsGrid(
      skills: flatSkills,
      isDark: isDark,
      scrollController: _effectiveScrollController,
      useCircular: true,
    );
  }
}

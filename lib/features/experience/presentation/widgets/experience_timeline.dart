import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/shared/animations/fade_animation.dart';
import 'package:personal_portfolio/features/home/data/models/experience_model.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
  
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: ExperienceData.experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final exp = entry.value;

          return FadeAnimation(
            delay: 0.2 + (index * 0.1),
            child: _TimelineItem(
              company: exp.company,
              role: exp.role,
              duration: exp.duration,
              location: exp.location,
              description: exp.description.join('\n'),
              isFirst: index == 0,
              isLast: index == ExperienceData.experiences.length - 1,
              isDark: isDark,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String company;
  final String role;
  final String duration;
  final String location;
  final String description;
  final bool isFirst;
  final bool isLast;
  final bool isDark;

  const _TimelineItem({
    required this.company,
    required this.role,
    required this.duration,
    required this.location,
    required this.description,
    required this.isFirst,
    required this.isLast,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimeline(),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildContent(),
              if (!isLast) const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        if (!isLast)
          Container(
            width: 2,
            height: 100,
            color: isDark ? AppColors.darkCard : AppColors.lightSecondary,
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          role,
          style: TextStyle(
            color: isDark ? AppColors.textDark : AppColors.textLight,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 5),
        Text(
          company,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 15,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                const SizedBox(width: 5),
                Text(
                  duration,
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                const SizedBox(width: 5),
                Text(
                  location,
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Text(
        description,
        style: TextStyle(
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
          fontSize: 14,
          height: 1.6,
        ),
      ),
    );
  }
}

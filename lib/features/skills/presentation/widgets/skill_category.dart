import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

class SkillCategory extends StatelessWidget {
  final String category;
  final List<String> skills;
  final bool isDark;
  final double delay;

  const SkillCategory({
    super.key,
    required this.category,
    required this.skills,
    required this.isDark,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (delay * 1000).toInt()),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getCategoryIcon(category),
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      category,
                      style: TextStyle(
                        color: isDark ? AppTheme.textDark : AppTheme.textLight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...skills.map((skill) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        color: isDark
                            ? AppTheme.textSecondaryDark
                            : AppTheme.textSecondaryLight,
                        fontSize: 14,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Languages':
        return Icons.code;
      case 'Frameworks':
        return Icons.apps;
      case 'State Management':
        return Icons.settings_applications;
      case 'Design & Tools':
        return Icons.palette;
      default:
        return Icons.category;
    }
  }
}

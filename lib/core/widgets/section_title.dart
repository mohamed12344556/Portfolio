import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/widgets/gradient_text.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool useGradient;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        if (useGradient)
          GradientText(
            text: title,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          )
        else
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.code),
          onPressed: () {},
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        IconButton(
          icon: const Icon(Icons.work),
          onPressed: () {},
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {},
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/utils/url_launcher.dart';

import '../../../../MyIcons_icons.dart';
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
          icon: const Icon(MyIcons.linkedIN),
          onPressed: () {
            UrlLauncher.launchSocialMedia(
              'linkedin',
              "mohamed-abdelqawi",
              context: context,
            );
          },
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        IconButton(
          icon: const Icon(MyIcons.whatsApp),
          onPressed: () {
            UrlLauncher.launchPhone(AppStrings.phone, context: context);
          },
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        IconButton(
          icon: const Icon(MyIcons.mail),
          onPressed: () {
            UrlLauncher.launchEmail(AppStrings.email, context: context);
          },
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
      ],
    );
  }
}

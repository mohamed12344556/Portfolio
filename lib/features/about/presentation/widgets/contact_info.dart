import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/utils/url_launcher.dart';
import 'package:personal_portfolio/features/contact/presentation/widgets/contact_card.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InkWell(
          onTap: () =>
              UrlLauncher.launchEmail(AppStrings.email, context: context),
          child: ContactCard(
            icon: Icons.email,
            title: 'Email',
            value: AppStrings.email,
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () =>
              UrlLauncher.launchPhone(AppStrings.phone, context: context),
          child: ContactCard(
            icon: Icons.phone,
            title: 'Phone',
            value: AppStrings.phone,
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 20),
        ContactCard(
          icon: Icons.location_on,
          title: 'Location',
          value: AppStrings.location,
          isDark: isDark,
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () =>
              UrlLauncher.launchURL(AppStrings.github, context: context),
          child: ContactCard(
            icon: Icons.code,
            title: 'GitHub',
            value: screenWidth < 400
                ? 'github.com/mohamed...'
                : AppStrings.github,
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () =>
              UrlLauncher.launchURL(AppStrings.linkedin, context: context),
          child: ContactCard(
            icon: Icons.business,
            title: 'LinkedIn',
            value: screenWidth < 400
                ? 'linkedin.com/in/mohamed...'
                : AppStrings.linkedin,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/url_launcher.dart';
import '../../../../core/shared/providers/portfolio_provider.dart';
import '../../../contact/presentation/widgets/contact_card.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final personalInfo = context.watch<PortfolioProvider>().personalInfo;

    return Column(
      children: [
        InkWell(
          onTap: () =>
              UrlLauncher.launchEmail(personalInfo.email, context: context),
          child: ContactCard(
            icon: Icons.email,
            title: 'Email',
            value: personalInfo.email,
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () =>
              UrlLauncher.launchPhone(personalInfo.phone, context: context),
          child: ContactCard(
            icon: Icons.phone,
            title: 'Phone',
            value: personalInfo.phone,
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 20),
        ContactCard(
          icon: Icons.location_on,
          title: 'Location',
          value: personalInfo.location,
          isDark: isDark,
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () =>
              UrlLauncher.launchURL(personalInfo.github, context: context),
          child: ContactCard(
            icon: Icons.code,
            title: 'GitHub',
            value: screenWidth < 400
                ? 'github.com/mohamed...'
                : personalInfo.github,
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () =>
              UrlLauncher.launchURL(personalInfo.linkedin, context: context),
          child: ContactCard(
            icon: Icons.business,
            title: 'LinkedIn',
            value: screenWidth < 400
                ? 'linkedin.com/in/mohamed...'
                : personalInfo.linkedin,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

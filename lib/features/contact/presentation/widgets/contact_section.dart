import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/shared/animations/fade_animation.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/utils/responsive.dart';
import 'package:personal_portfolio/core/widgets/section_title.dart';
import 'package:personal_portfolio/features/about/presentation/widgets/contact_info.dart';
import 'package:personal_portfolio/features/contact/presentation/widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
              const SectionTitle(
                title: AppStrings.contactTitle,
                subtitle: AppStrings.contactSubtitle,
              ),
              const SizedBox(height: 60),
              Responsive(
                mobile: _buildMobileView(),
                desktop: _buildDesktopView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return Column(
      children: const [
        FadeAnimation(delay: 0.2, child: ContactInfo()),
        SizedBox(height: 60),
        FadeAnimation(delay: 0.4, child: ContactForm()),
      ],
    );
  }

  Widget _buildDesktopView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 2,
          child: FadeAnimation(delay: 0.2, child: ContactInfo()),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
            ),
            child: const FadeAnimation(delay: 0.4, child: ContactForm()),
          ),
        ),
      ],
    );
  }
}

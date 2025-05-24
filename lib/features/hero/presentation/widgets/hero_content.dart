import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../education/presentation/widgets/certification_viewer.dart';

import '../../../../core/shared/animations/fade_animation.dart';
import '../../../../core/shared/animations/slide_animation.dart';
import '../../../../core/widgets/animated_button.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../../../contact/presentation/widgets/hire_me_handler.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeAnimation(
          delay: 0.2,
          child: Text(
            AppStrings.heroGreeting,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SlideAnimation(
          delay: 0.4,
          child: Text(
            AppStrings.name,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const SizedBox(height: 16),
        SlideAnimation(
          delay: 0.6,
          child: GradientText(
            text: AppStrings.title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        const SizedBox(height: 24),
        FadeAnimation(
          delay: 0.8,
          child: Text(
            AppStrings.heroDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeAnimation(
          delay: 1.0,
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              AnimatedButton(
                text: AppStrings.hireMe,
                onPressed: () => HireMeHandler.showHireMeDialog(context),
                isPrimary: true,
              ),
              AnimatedButton(
                text: AppStrings.downloadCV,
                onPressed: () {
                  CertificateViewer.showCertificate(
                    context,
                    "Mohamed Ahemd AbdElqawi Flutter Dev",
                    "assets/pdfs/Mohamed-Ahemd-AbdElqawi-Flutter-Dev.pdf",
                  );
                },
                isPrimary: false,
                icon: Icons.download,
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        // FadeAnimation(
        //   delay: 1.2,
        //   child: Row(
        //     children: [
        //       StatsCounter(
        //         value: AppStrings.experienceYears,
        //         label: 'Experience',
        //       ),
        //       const SizedBox(width: 40),
        //       StatsCounter(
        //         value: AppStrings.projectsCompleted,
        //         label: 'Projects',
        //       ),
        //       const SizedBox(width: 40),
        //       StatsCounter(
        //         value: AppStrings.happyClients,
        //         label: 'Happy Clients',
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

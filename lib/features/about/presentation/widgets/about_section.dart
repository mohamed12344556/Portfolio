import 'package:flutter/material.dart';
import '../../../../core/shared/animations/fade_animation.dart';
import '../../../../core/shared/animations/slide_animation.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/animated_button.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../education/presentation/widgets/certification_viewer.dart';
import 'package:personal_portfolio/features/hero/presentation/widgets/stats_counter.dart'
    hide Responsive;

class AboutSection extends StatelessWidget {
  final ScrollController? scrollController;

  const AboutSection({super.key, this.scrollController});

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
              const SectionTitle(title: AppStrings.aboutTitle, subtitle: null),
              const SizedBox(height: 60),
              Responsive(
                mobile: _buildMobileView(context, isDark),
                desktop: _buildDesktopView(context, isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileView(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildProfileImage(isDark),
        const SizedBox(height: 40),
        _buildContent(context, isDark),
      ],
    );
  }

  Widget _buildDesktopView(BuildContext context, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: _buildProfileImage(isDark)),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildContent(context, isDark)),
      ],
    );
  }

  Widget _buildProfileImage(bool isDark) {
    return FadeAnimation(
      delay: 0.2,
      child: Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.accentColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 330,
              height: 330,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  // 'assets/images/3.jpg',
                  'assets/images/profile2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Decorative elements
            Positioned(
              top: 30,
              right: 50,
              child: _buildFloatingBubble(
                15,
                AppColors.primaryColor.withOpacity(0.7),
              ),
            ),
            Positioned(
              top: 70,
              right: 30,
              child: _buildFloatingBubble(
                25,
                AppColors.accentColor.withOpacity(0.5),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 30,
              child: _buildFloatingBubble(
                20,
                AppColors.primaryColor.withOpacity(0.6),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 70,
              child: _buildFloatingBubble(
                15,
                AppColors.accentColor.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingBubble(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark) {
    final effectiveScrollController = scrollController ?? ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideAnimation(
          delay: 0.4,
          child: GradientText(
            text: "Who am I?",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 20),
        FadeAnimation(
          delay: 0.6,
          child: Text(
            AppStrings.aboutDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              height: 1.8,
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeAnimation(
          delay: 0.8,
          child: StatsCounterRow(
            items: [
              StatsItem(
                value: AppStrings.experienceYears,
                label: 'Years Experience',
                icon: Icons.work,
              ),
              StatsItem(
                value: AppStrings.projectsCompleted,
                label: 'Projects',
                icon: Icons.folder,
              ),
              StatsItem(
                value: AppStrings.happyClients,
                label: 'Clients',
                icon: Icons.people,
              ),
            ],
            isDark: isDark,
            scrollController: effectiveScrollController,
            scrollTriggerOffset: 0.2,
          ),
        ),
        const SizedBox(height: 40),
        FadeAnimation(
          delay: 1.0,
          child: AnimatedButton(
            text: AppStrings.downloadCV,
            onPressed: () {
              CertificateViewer.showCertificate(
                context,
                "Mohamed Ahemd AbdElqawi Flutter Dev",
                "assets/pdfs/Mohamed-Ahemd-AbdElqawi-Flutter-Dev.pdf",
              );
            },
            isPrimary: true,
            icon: Icons.download,
          ),
        ),
      ],
    );
  }
}

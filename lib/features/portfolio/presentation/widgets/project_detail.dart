import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/shared/animations/fade_animation.dart';
import 'package:personal_portfolio/features/home/data/models/project_model.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/utils/url_launcher.dart';
import 'package:personal_portfolio/features/portfolio/presentation/widgets/project_gallery.dart';

class ProjectDetail extends StatelessWidget {
  final ProjectModel project;
  final bool isDark;
  final VoidCallback onBack;

  const ProjectDetail({
    super.key,
    required this.project,
    required this.isDark,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 30),
        if (project.images.isNotEmpty) ...[
          FadeAnimation(
            delay: 0.3,
            child: HorizontalProjectGallery(
              images: project.images,
              isDark: isDark,
              height: 300,
            ),
          ),
          const SizedBox(height: 30),
        ],
        FadeAnimation(delay: 0.4, child: _buildDetails(context)),
        const SizedBox(height: 30),
        FadeAnimation(delay: 0.5, child: _buildButtons(context)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.textDark : AppColors.textLight,
          ),
          onPressed: onBack,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: TextStyle(
                  color: isDark ? AppColors.textDark : AppColors.textLight,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      project.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    project.date,
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
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            color: isDark ? AppColors.textDark : AppColors.textLight,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          project.description,
          style: TextStyle(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Technologies',
          style: TextStyle(
            color: isDark ? AppColors.textDark : AppColors.textLight,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSecondary
                    : AppColors.lightSecondary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                tech,
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: [
        if (project.projectUrl != null)
          ElevatedButton.icon(
            icon: const Icon(Icons.link, size: 18),
            label: const Text('View Project'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () =>
                UrlLauncher.launchURL(project.projectUrl!, context: context),
          ),
        if (project.appStoreUrl != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.apple, size: 18),
            label: const Text('App Store'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: BorderSide(color: AppColors.primaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () =>
                UrlLauncher.launchURL(project.appStoreUrl!, context: context),
          ),
        if (project.playStoreUrl != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.android, size: 18),
            label: const Text('Play Store'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: BorderSide(color: AppColors.primaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () =>
                UrlLauncher.launchURL(project.playStoreUrl!, context: context),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/shared/animations/animated_text.dart';
import '../../../../core/shared/animations/fade_animation.dart';
import '../../../../core/shared/data/models/project_model.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_title.dart';
import 'filter_chips.dart';
import 'project_card.dart';
import 'project_detail.dart';

class PortfolioSection extends StatefulWidget {
  final ScrollController? scrollController;

  const PortfolioSection({super.key, this.scrollController});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  String _selectedCategory = 'All';
  ProjectModel? _selectedProject;
  final _scrollController = ScrollController();
  int _currentMobileIndex = 0;
  final PageController _mobilePageController = PageController();

  @override
  void initState() {
    super.initState();
    _mobilePageController.addListener(_handleMobilePageChange);

    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_handleMainScroll);
    }
  }

  void _handleMobilePageChange() {
    if (_mobilePageController.page != null) {
      final int newIndex = _mobilePageController.page!.round();
      if (_currentMobileIndex != newIndex) {
        setState(() {
          _currentMobileIndex = newIndex;
        });
      }
    }
  }

  void _handleMainScroll() {
    // Listen to main scroll events if needed
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _mobilePageController.removeListener(_handleMobilePageChange);
    _mobilePageController.dispose();

    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_handleMainScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: ResponsivePadding.getAll(context),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Center(
        child: Column(
          children: [
            const SectionTitle(
              title: AppStrings.portfolioTitle,
              subtitle: AppStrings.portfolioSubtitle,
            ),
            const SizedBox(height: 20),
            FadeAnimation(
              delay: 0.2,
              child: AnimatedText(
                text: "Check out some of my recent work and personal projects",
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            FadeAnimation(
              delay: 0.3,
              child: FilterChips(
                categories: ProjectData.getCategories(),
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                    _currentMobileIndex = 0;
                  });
                  if (Responsive.isMobile(context) &&
                      _mobilePageController.hasClients) {
                    _mobilePageController.jumpToPage(0);
                  }
                },
              ),
            ),
            const SizedBox(height: 40),
            _selectedProject == null
                ? _buildProjectGrid(context, isDark)
                : _buildProjectDetail(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectGrid(BuildContext context, bool isDark) {
    final filteredProjects = _selectedCategory == 'All'
        ? ProjectData.projects
        : ProjectData.projects
              .where((p) => p.category == _selectedCategory)
              .toList();

    if (Responsive.isMobile(context)) {
      return _buildMobileProjectView(context, isDark, filteredProjects);
    } else {
      return _buildDesktopProjectGrid(context, isDark, filteredProjects);
    }
  }

  Widget _buildDesktopProjectGrid(
    BuildContext context,
    bool isDark,
    List<ProjectModel> filteredProjects,
  ) {
    return ResponsiveGridView(
      childAspectRatio: Responsive.isTablet(context) ? 0.7 : 0.75,
      children: filteredProjects.map((project) {
        // final index = entry.key;
        // final project = entry.value;

        return ProjectCard(
          title: project.title,
          category: project.category,
          date: project.date,
          description: project.description,
          images: project.images,
          thumbnailUrl: project.thumbnailUrl,
          projectUrl: project.projectUrl,
          appStoreUrl: project.appStoreUrl,
          playStoreUrl: project.playStoreUrl,
          technologies: project.technologies,
          isDark: isDark,
          delay: Responsive.isTablet(context) ? 0.2 : 0.1,
        );
      }).toList(),
    );
  }

  // طريقة محسنة لعرض المشاريع على الهاتف المحمول
  Widget _buildMobileProjectView(
    BuildContext context,
    bool isDark,
    List<ProjectModel> projects,
  ) {
    if (projects.isEmpty) {
      return Center(
        child: Text(
          'No projects found for this category',
          style: TextStyle(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      );
    }

    return Column(
      children: [
        // PageView للتمرير الأفقي
        SizedBox(
          height: 450, // ارتفاع أكبر لعرض المزيد من المحتوى
          child: PageView.builder(
            controller: _mobilePageController,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ProjectCard(
                  title: project.title,
                  category: project.category,
                  date: project.date,
                  description: project.description,
                  images: project.images,
                  thumbnailUrl: project.thumbnailUrl,
                  projectUrl: project.projectUrl,
                  appStoreUrl: project.appStoreUrl,
                  playStoreUrl: project.playStoreUrl,
                  technologies: project.technologies,
                  isDark: isDark,
                  delay: 0.1, // تأخير ثابت لتجنب التأخير التراكمي
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        // مؤشرات الصفحات
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(projects.length, (index) {
            return GestureDetector(
              onTap: () {
                _mobilePageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentMobileIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentMobileIndex == index
                      ? AppColors.primaryColor
                      : (isDark
                            ? AppColors.darkTertiary
                            : AppColors.lightTertiary),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 15),

        // أزرار التنقل
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationButton(
              icon: Icons.arrow_back_ios,
              onPressed: _currentMobileIndex > 0
                  ? () {
                      _mobilePageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              isDark: isDark,
            ),
            SizedBox(width: 10),
            Text(
              '${_currentMobileIndex + 1} / ${projects.length}',
              style: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
            SizedBox(width: 10),
            _buildNavigationButton(
              icon: Icons.arrow_forward_ios,
              onPressed: _currentMobileIndex < projects.length - 1
                  ? () {
                      _mobilePageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isDark,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        padding: EdgeInsets.all(12),
        elevation: 3,
        disabledBackgroundColor: isDark
            ? AppColors.darkTertiary
            : AppColors.lightTertiary,
        disabledForegroundColor: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
      child: Icon(icon, size: 16),
    );
  }

  Widget _buildProjectDetail(BuildContext context, bool isDark) {
    return ProjectDetail(
      project: _selectedProject!,
      isDark: isDark,
      onBack: () {
        setState(() {
          _selectedProject = null;
        });
      },
    );
  }
}

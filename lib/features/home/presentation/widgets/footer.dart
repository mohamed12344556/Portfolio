import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import 'social_media_icons.dart';

class Footer extends StatelessWidget {
  final Function(int) onNavItemTap;

  const Footer({super.key, required this.onNavItemTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: ResponsivePadding.getAll(context),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsivePadding.getContentWidth(context),
          ),
          child: Column(
            children: [
              _buildMainContent(context, isDark),
              _buildDividerSection(),
              _buildCopyright(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isDark) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktopLayout(isDark);
    } else if (Responsive.isTablet(context)) {
      return _buildTabletLayout(isDark);
    } else {
      return _buildMobileLayout(isDark);
    }
  }

  Widget _buildDesktopLayout(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Section
        _buildLogoSection(),

        // Navigation Links
        Expanded(
          flex: 2,
          child: _buildNavigationGrid(isDark, crossAxisCount: 4),
        ),

        // Social Media Section
        _buildSocialMediaSection(isDark),
      ],
    );
  }

  Widget _buildTabletLayout(bool isDark) {
    return Column(
      children: [
        // Top Row: Logo and Social Media
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildLogoSection(), _buildSocialMediaSection(isDark)],
        ),

        const SizedBox(height: 30),

        // Navigation Grid
        _buildNavigationGrid(isDark, crossAxisCount: 3),
      ],
    );
  }

  Widget _buildMobileLayout(bool isDark) {
    return Column(
      children: [
        // Logo
        _buildLogoSection(),

        const SizedBox(height: 20),

        // Navigation Grid - 2 columns on mobile
        _buildNavigationGrid(isDark, crossAxisCount: 2),

        const SizedBox(height: 20),

        // Social Media
        _buildSocialMediaSection(isDark),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => _showLogoDialog(context),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: _getLogoSize(context),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/m7m71.png',
                  height: _getLogoSize(context) * 2,
                  width: _getLogoSize(context) * 2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (Responsive.isDesktop(context)) ...[
              const SizedBox(height: 10),
              Text(
                AppStrings.appName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.textDark
                      : AppColors.textLight,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _getLogoSize(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 25;
    } else if (Responsive.isTablet(context)) {
      return 30;
    } else {
      return 35;
    }
  }

  Widget _buildNavigationGrid(bool isDark, {required int crossAxisCount}) {
    return Builder(
      builder: (context) {
        final maxItems = _getMaxNavigationItems(context);
        final itemsToShow = AppStrings.navItems.take(maxItems).toList();

        return Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: itemsToShow.map((item) {
            final index = AppStrings.navItems.indexOf(item);
            return TextButton(
              onPressed: () => onNavItemTap(index),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 8 : 12,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: _getNavigationFontSize(context),
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  int _getMaxNavigationItems(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 8;
    } else if (Responsive.isTablet(context)) {
      return 6;
    } else {
      return 6; // للموبايل، سنعرض 6 عناصر في شبكة 2x3
    }
  }

  double _getNavigationFontSize(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 13;
    } else if (Responsive.isTablet(context)) {
      return 14;
    } else {
      return 15;
    }
  }

  Widget _buildSocialMediaSection(bool isDark) {
    return Builder(
      builder: (context) => Column(
        children: [
          if (Responsive.isDesktop(context)) ...[
            Text(
              'Follow Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? AppColors.textDark : AppColors.textLight,
              ),
            ),
            const SizedBox(height: 12),
          ],
          SocialMediaIcons(isDark: isDark),
        ],
      ),
    );
  }

  Widget _buildDividerSection() {
    return const Column(
      children: [SizedBox(height: 30), Divider(), SizedBox(height: 20)],
    );
  }

  Widget _buildCopyright(BuildContext context, bool isDark) {
    return Text(
      AppStrings.copyright,
      style: TextStyle(
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
        fontSize: _getCopyrightFontSize(context),
      ),
      textAlign: TextAlign.center,
    );
  }

  double _getCopyrightFontSize(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 12;
    } else {
      return 14;
    }
  }

  void _showLogoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightCard,
        title: const Text(
          'Choice',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Do you want to go back to the top of the page or view the image?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onNavItemTap(0);
              _scrollToTop(context);
            },
            child: const Text('Back to Top'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showImageDialog(context);
            },
            child: const Text('View Image'),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightCard,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.width * 0.9
                : 400,
            maxHeight: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.height * 0.7
                : 500,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '👀❤️‍🩹 قولي رأيك بصراحة ',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 18 : 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    'assets/images/m7m71.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToTop(BuildContext context) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

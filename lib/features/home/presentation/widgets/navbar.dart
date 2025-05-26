import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../../core/utils/responsive.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavItemTap;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final VoidCallback? onMenuTap;

  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.onNavItemTap,
    required this.isDarkMode,
    required this.onThemeToggle,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: _getToolbarHeight(context),
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: _buildTitle(context),
        actions: _buildActions(context),
      ),
    );
  }

  double _getToolbarHeight(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 60;
    } else if (Responsive.isTablet(context)) {
      return 70;
    } else {
      return 80;
    }
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _showLogoDialog(context),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: _getLogoSize(context),
            child: ClipOval(
              child: Image.asset(
                "assets/images/splash.png",
                height: _getLogoSize(context) * 2,
                width: _getLogoSize(context) * 2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        if (Responsive.isDesktop(context)) ...[
          const SizedBox(width: 20),

          // يمكن إضافة عنوان التطبيق هنا إذا رغبت
        ],
      ],
    );
  }

  double _getLogoSize(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 20;
    } else if (Responsive.isTablet(context)) {
      return 25;
    } else {
      return 27.5;
    }
  }

  List<Widget> _buildActions(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktopActions(context);
    } else if (Responsive.isTablet(context)) {
      return _buildTabletActions(context);
    } else {
      return _buildMobileActions(context);
    }
  }

  List<Widget> _buildDesktopActions(BuildContext context) {
    return [
      // Navigation items
      ...AppStrings.navItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TextButton(
            onPressed: () => onNavItemTap(index),
            style: TextButton.styleFrom(
              foregroundColor: selectedIndex == index
                  ? AppColors.primaryColor
                  : isDarkMode
                  ? AppColors.textDark
                  : AppColors.textLight,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: selectedIndex == index
                    ? Border(
                        bottom: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      )
                    : null,
              ),
              child: Text(
                item,
                style: TextStyle(
                  fontWeight: selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }),
      const SizedBox(width: 16),
      // Theme toggle
      IconButton(
        icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 22),
        onPressed: onThemeToggle,
        color: isDarkMode ? AppColors.textDark : AppColors.textLight,
        tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      ),
      const SizedBox(width: 20),
    ];
  }

  List<Widget> _buildTabletActions(BuildContext context) {
    // عرض بعض العناصر المهمة مع قائمة للباقي
    final importantItemsCount = AppStrings.navItems.length > 3
        ? 5
        : AppStrings.navItems.length;

    return [
      // عرض أول عنصرين فقط
      ...AppStrings.navItems
          .take(importantItemsCount)
          .toList()
          .asMap()
          .entries
          .map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TextButton(
                onPressed: () => onNavItemTap(index),
                style: TextButton.styleFrom(
                  foregroundColor: selectedIndex == index
                      ? AppColors.primaryColor
                      : isDarkMode
                      ? AppColors.textDark
                      : AppColors.textLight,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontWeight: selectedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }),

      // قائمة منسدلة للعناصر المتبقية إذا كانت موجودة
      if (AppStrings.navItems.length > importantItemsCount)
        PopupMenuButton<int>(
          icon: Icon(
            Icons.more_horiz,
            color: isDarkMode ? AppColors.textDark : AppColors.textLight,
          ),
          onSelected: (index) => onNavItemTap(index),
          itemBuilder: (context) => AppStrings.navItems
              .skip(importantItemsCount)
              .toList()
              .asMap()
              .entries
              .map((entry) {
                final actualIndex = entry.key + importantItemsCount;
                final item = entry.value;
                return PopupMenuItem<int>(
                  value: actualIndex,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: selectedIndex == actualIndex
                          ? AppColors.primaryColor
                          : isDarkMode
                          ? AppColors.textDark
                          : AppColors.textLight,
                      fontWeight: selectedIndex == actualIndex
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              })
              .toList(),
        ),

      const SizedBox(width: 8),
      IconButton(
        icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 20),
        onPressed: onThemeToggle,
        color: isDarkMode ? AppColors.textDark : AppColors.textLight,
      ),
      const SizedBox(width: 16),
    ];
  }

  List<Widget> _buildMobileActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 20),
        onPressed: onThemeToggle,
        color: isDarkMode ? AppColors.textDark : AppColors.textLight,
      ),
      IconButton(
        icon: const Icon(Icons.menu, size: 20),
        onPressed: onMenuTap,
        color: isDarkMode ? AppColors.textDark : AppColors.textLight,
      ),
      const SizedBox(width: 16),
    ];
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
              // Scroll to the top of the page
              Scrollable.ensureVisible(
                context,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
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
                    // "assets/images/m7m71.png",
                    "assets/images/Untitled.png",
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
}

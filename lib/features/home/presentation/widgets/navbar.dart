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
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Choice'),
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
                    child: const Text('Back to the top of the page'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Show the image in a dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkCard
                              : AppColors.lightCard,
                          title: Text(
                            '👀❤️‍🩹 قولي رأيك بصراحة ',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close'),
                            ),
                          ],
                          content: Image.asset(
                            'assets/images/m7m71.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    child: const Text('View the image'),
                  ),
                ],
              ),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
                'assets/images/m7m71.png',
                height: 55,
                width: 55,
                fit: BoxFit.cover,
                scale: 1.5,
              ),
            ),
          ),
        ),
        actions: [
          if (!Responsive.isMobile(context)) ...[
            ...AppStrings.navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return TextButton(
                onPressed: () => onNavItemTap(index),
                style: TextButton.styleFrom(
                  foregroundColor: selectedIndex == index
                      ? AppColors.primaryColor
                      : isDarkMode
                      ? AppColors.textDark
                      : AppColors.textLight,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
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
                    ),
                  ),
                ),
              );
            }),
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: onThemeToggle,
              color: isDarkMode ? AppColors.textDark : AppColors.textLight,
            ),
            const SizedBox(width: 20),
          ] else ...[
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: onThemeToggle,
              color: isDarkMode ? AppColors.textDark : AppColors.textLight,
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuTap,
              color: isDarkMode ? AppColors.textDark : AppColors.textLight,
            ),
            const SizedBox(width: 20),
          ],
        ],
      ),
    );
  }
}

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
        // backgroundBlendMode: const ColorFilter.mode(
        //   Colors.transparent,
        //   BlendMode.multiply,
        // ),
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Text(
              'MA',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
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

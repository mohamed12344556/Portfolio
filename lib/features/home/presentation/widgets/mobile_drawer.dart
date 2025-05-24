import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';

class MobileDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavItemTap;
  final bool isDarkMode;

  const MobileDrawer({
    super.key,
    required this.selectedIndex,
    required this.onNavItemTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode
          ? AppColors.darkSecondary
          : AppColors.lightSecondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ...AppStrings.navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return ListTile(
              leading: Icon(
                _getNavIcon(index),
                color: selectedIndex == index
                    ? AppColors.primaryColor
                    : isDarkMode
                    ? AppColors.textDark
                    : AppColors.textLight,
              ),
              title: Text(
                item,
                style: TextStyle(
                  color: selectedIndex == index
                      ? AppColors.primaryColor
                      : isDarkMode
                      ? AppColors.textDark
                      : AppColors.textLight,
                  fontWeight: selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () => onNavItemTap(index),
            );
          }),
        ],
      ),
    );
  }

  IconData _getNavIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.person;
      case 2:
        return Icons.work;
      case 3:
        return Icons.folder;
      case 4:
        return Icons.business_center;
      case 5:
        return Icons.school;
      case 6:
        return Icons.contact_mail;
      default:
        return Icons.circle;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';

import '../../../../core/utils/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
              if (!Responsive.isMobile(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MA',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: AppStrings.navItems.take(5).map((item) {
                        return TextButton(
                          onPressed: () {},
                          child: Text(
                            item,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.code),
                          onPressed: () {},
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        IconButton(
                          icon: const Icon(Icons.work),
                          onPressed: () {},
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        IconButton(
                          icon: const Icon(Icons.language),
                          onPressed: () {},
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ],
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      'MA',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.code),
                          onPressed: () {},
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        IconButton(
                          icon: const Icon(Icons.work),
                          onPressed: () {},
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        IconButton(
                          icon: const Icon(Icons.language),
                          onPressed: () {},
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Text(
                AppStrings.copyright,
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';

import '../../../../core/utils/responsive.dart';

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
              if (!Responsive.isMobile(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
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
                                child: const Text(
                                  'Back to the top of the page',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Show the image in a dialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
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
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
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
                    Row(
                      children: AppStrings.navItems.take(8).map((item) {
                        return TextButton(
                          onPressed: () {
                            onNavItemTap(AppStrings.navItems.indexOf(item));
                          },
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

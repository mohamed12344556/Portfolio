import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isDark;
  final double delay;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isDark,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (delay * 1000).toInt()),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppTheme.darkSecondary
                      : AppTheme.lightSecondary,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.05),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.accentColor],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(icon, color: Colors.white, size: 35),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark ? AppTheme.textDark : AppTheme.textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondaryLight,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

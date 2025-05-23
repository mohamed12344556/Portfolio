import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/utils/url_launcher.dart';
import 'package:personal_portfolio/core/widgets/hover_widget.dart';

class SocialButtons extends StatelessWidget {
  final double size;
  final bool isDark;
  final Axis direction;
  final bool showLabels;

  const SocialButtons({
    super.key,
    this.size = 24,
    required this.isDark,
    this.direction = Axis.horizontal,
    this.showLabels = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<SocialButton> buttons = [
      SocialButton(
        icon: Icons.email,
        label: 'Email',
        onTap: () =>
            UrlLauncher.launchEmail(AppStrings.email, context: context),
      ),
      SocialButton(
        icon: Icons.phone,
        label: 'Phone',
        onTap: () =>
            UrlLauncher.launchPhone(AppStrings.phone, context: context),
      ),
      SocialButton(icon: Icons.location_on, label: 'Location', onTap: () {}),
      SocialButton(
        icon: Icons.code,
        label: 'GitHub',
        onTap: () => UrlLauncher.launchURL(AppStrings.github, context: context),
      ),
      SocialButton(
        icon: Icons.business,
        label: 'LinkedIn',
        onTap: () =>
            UrlLauncher.launchURL(AppStrings.linkedin, context: context),
      ),
    ];

    return direction == Axis.horizontal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildButtons(buttons),
          )
        : Column(children: _buildButtons(buttons));
  }

  List<Widget> _buildButtons(List<SocialButton> buttons) {
    List<Widget> widgets = [];

    for (int i = 0; i < buttons.length; i++) {
      widgets.add(
        ScaleOnHover(
          scale: 1.2,
          child: showLabels
              ? _buildLabeledButton(buttons[i])
              : _buildIconButton(buttons[i]),
        ),
      );

      if (i < buttons.length - 1) {
        widgets.add(
          direction == Axis.horizontal
              ? SizedBox(width: showLabels ? 20 : 12)
              : SizedBox(height: showLabels ? 20 : 12),
        );
      }
    }

    return widgets;
  }

  Widget _buildIconButton(SocialButton button) {
    return Container(
      width: size + 20,
      height: size + 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(button.icon, size: size),
        color: AppColors.primaryColor,
        onPressed: button.onTap,
        padding: EdgeInsets.zero,
        splashRadius: size,
      ),
    );
  }

  Widget _buildLabeledButton(SocialButton button) {
    return InkWell(
      onTap: button.onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(button.icon, color: Colors.white, size: size),
            const SizedBox(width: 10),
            Text(
              button.label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialButton {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

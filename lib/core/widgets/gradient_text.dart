import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient? gradient;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    this.gradient,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => (gradient ?? AppColors.primaryGradient)
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
        textAlign: textAlign,
      ),
    );
  }
}

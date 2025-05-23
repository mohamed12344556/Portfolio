import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/shared/animations/float_animation.dart';

import '../../../../core/themes/app_colors.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FloatAnimation(
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Center(
              //   child: Image.asset(
              //     'assets/images/profile.jpg',
              //     fit: BoxFit.cover,
              //   ),
              //   // Column(
              //   //   mainAxisAlignment: MainAxisAlignment.center,
              //   //   children: [
              //   //     Icon(Icons.code, size: 120, color: AppColors.primaryColor),
              //   //     const SizedBox(height: 20),
              //   //     Text(
              //   //       'Flutter Developer',
              //   //       style: TextStyle(
              //   //         color: AppColors.primaryColor,
              //   //         fontSize: 24,
              //   //         fontWeight: FontWeight.bold,
              //   //       ),
              //   //     ),
              //   //   ],
              //   // ),
              // ),
            ),
            // Decorative elements
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentColor.withOpacity(0.5),
                      AppColors.primaryColor.withOpacity(0.5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentColor.withOpacity(0.3),
                      blurRadius: 25,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

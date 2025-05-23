import 'package:flutter/material.dart';
import 'package:personal_portfolio/features/hero/presentation/widgets/hero_content.dart';
import 'package:personal_portfolio/features/hero/presentation/widgets/hero_image.dart';

import '../../../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      padding: ResponsivePadding.getAll(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsivePadding.getContentWidth(context),
          ),
          child: Responsive(
            mobile: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                HeroImage(),
                SizedBox(height: 40),
                HeroContent(),
              ],
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(child: HeroContent()),
                SizedBox(width: 60),
                HeroImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

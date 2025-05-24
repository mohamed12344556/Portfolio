import 'package:flutter/material.dart';
import '../../../../core/shared/data/models/service_model.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_title.dart';
import 'service_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: ResponsivePadding.getAll(context),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsivePadding.getContentWidth(context),
          ),
          child: Column(
            children: [
              const SectionTitle(
                title: AppStrings.servicesTitle,
                subtitle: AppStrings.servicesSubtitle,
              ),
              const SizedBox(height: 60),
              _buildServiceGrid(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context, bool isDark) {
    return ResponsiveGridView(
      children: ServicesData.services.asMap().entries.map((entry) {
        final index = entry.key;
        final service = entry.value;

        return ServiceCard(
          icon: service.icon,
          title: service.title,
          description: service.description,
          isDark: isDark,
          delay: index * 0.1,
        );
      }).toList(),
    );
  }
}

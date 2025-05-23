import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';

class FilterChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const FilterChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            isSelected: selectedCategory == 'All',
            onTap: () => onCategorySelected('All'),
            isDark: isDark,
          ),
          const SizedBox(width: 12),
          ...categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _FilterChip(
                label: category,
                isSelected: selectedCategory == category,
                onTap: () => onCategorySelected(category),
                isDark: isDark,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: widget.isSelected || _isHovered
                ? AppColors.primaryGradient
                : null,
            color: widget.isSelected || _isHovered
                ? null
                : widget.isDark
                ? AppColors.darkCard
                : AppColors.lightCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isSelected || _isHovered
                  ? Colors.transparent
                  : AppColors.primaryColor.withOpacity(0.3),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isSelected || _isHovered
                  ? Colors.white
                  : widget.isDark
                  ? AppColors.textDark
                  : AppColors.textLight,
              fontWeight: widget.isSelected
                  ? FontWeight.bold 
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

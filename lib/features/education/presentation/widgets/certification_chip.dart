import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class CertificationChip extends StatelessWidget {
  final String title;
  final bool isDark;

  const CertificationChip({
    super.key,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified, size: 16, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: isDark ? AppTheme.textDark : AppTheme.textLight,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// تعديل كيفية عرض الشهادات
class CertificationsGrid extends StatelessWidget {
  final List<String> certifications;
  final bool isDark;

  const CertificationsGrid({
    super.key,
    required this.certifications,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: certifications.map((cert) {
        return Tooltip(
          message: cert,
          child: CertificationChip(
            title: _shortenCertName(cert),
            isDark: isDark,
          ),
        );
      }).toList(),
    );
  }

  // تقصير أسماء الشهادات للعرض
  String _shortenCertName(String fullName) {
    // إذا كان الاسم يحتوي على فاصلة، نأخذ الجزء الأول فقط
    if (fullName.contains(',')) {
      return fullName.split(',')[0];
    }

    // إذا كان الاسم طويلاً، نقصره
    if (fullName.length > 30) {
      final parts = fullName.split(' ');
      if (parts.length > 3) {
        return '${parts[0]} ${parts[1]}...';
      }
    }

    return fullName;
  }
}

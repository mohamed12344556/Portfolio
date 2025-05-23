import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/utils/url_launcher.dart';
import 'package:personal_portfolio/features/portfolio/presentation/widgets/project_gallery.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String category;
  final String date;
  final String description;
  final List<String> images;
  final String? thumbnailUrl;
  final String? projectUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final List<String> technologies;
  final bool isDark;
  final double delay;

  const ProjectCard({
    super.key,
    required this.title,
    required this.category,
    required this.date,
    required this.description,
    this.images = const [],
    this.thumbnailUrl,
    this.projectUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    this.technologies = const [],
    required this.isDark,
    required this.delay,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600 + (widget.delay * 1000).toInt()),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // تأخير البدء حسب قيمة التأخير المقدمة
    Future.delayed(Duration(milliseconds: (widget.delay * 300).toInt()), () {
      if (mounted) _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.identity()
                  ..translate(0.0, _isHovered ? -10.0 : 0.0),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? AppColors.darkCard
                      : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(
                        _isHovered ? 0.2 : 0.05,
                      ),
                      blurRadius: _isHovered ? 30 : 20,
                      spreadRadius: _isHovered ? 10 : 5,
                    ),
                  ],
                ),
                // إضافة تمرير للتأكد من عدم تجاوز المحتوى
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // هام: تقليل الارتفاع الكلي
                    children: [
                      _buildProjectImage(),
                      // استخدم Flexible بدلاً من Expanded لمنع تجاوز المحتوى
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize:
                                MainAxisSize.min, // هام: تقليل الارتفاع الكلي
                            children: [
                              _buildTitle(),
                              const SizedBox(height: 5),
                              _buildCategoryAndDate(),
                              const SizedBox(height: 10),
                              _buildDescription(),
                              const SizedBox(height: 10),
                              // استخدم عدد محدود من التقنيات لتجنب تجاوز المحتوى
                              _buildTechnologies(),
                              const SizedBox(height: 10),
                              _buildButtons(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
            height: 180, // تم تقليل الارتفاع من 200 إلى 180
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.7),
                  AppColors.accentColor.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: widget.thumbnailUrl != null && widget.thumbnailUrl!.isNotEmpty
              ? Image.asset(
                widget.thumbnailUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                  _buildDefaultProjectImage(),
                )
              : _buildDefaultProjectImage(),
          ),

          // تأثير الهوفر
          if (_isHovered)
            Container(
              height: 180, // تحديث الارتفاع لمطابقة الصورة
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.images.isNotEmpty)
                      _buildActionButton(
                        icon: Icons.photo_library,
                        label: 'Gallery',
                        onTap: () => _showGallery(context),
                      ),
                    if (widget.images.isNotEmpty &&
                        (widget.projectUrl != null ||
                            widget.appStoreUrl != null ||
                            widget.playStoreUrl != null))
                      const SizedBox(width: 15),
                    if (widget.projectUrl != null)
                      _buildActionButton(
                        icon: Icons.link,
                        label: 'View Project',
                        onTap: () => UrlLauncher.launchURL(
                          widget.projectUrl!,
                          context: context,
                        ),
                      )
                    else if (widget.appStoreUrl != null ||
                        widget.playStoreUrl != null)
                      _buildPlatformActionButton(context),
                  ],
                ),
              ),
            ),

          // وسم الفئة
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // زر يختلف حسب منصة التشغيل
  Widget _buildPlatformActionButton(BuildContext context) {
    final platform = Theme.of(context).platform;

    // للأجهزة المحمولة
    if (platform == TargetPlatform.android && widget.playStoreUrl != null) {
      return _buildActionButton(
        icon: Icons.android,
        label: 'Play Store',
        onTap: () =>
            UrlLauncher.launchURL(widget.playStoreUrl!, context: context),
      );
    } else if (platform == TargetPlatform.iOS && widget.appStoreUrl != null) {
      return _buildActionButton(
        icon: Icons.apple,
        label: 'App Store',
        onTap: () =>
            UrlLauncher.launchURL(widget.appStoreUrl!, context: context),
      );
    }
    // إذا كانت المنصة غير محددة أو على الويب أو متصفح
    else {
      return _buildActionButton(
        icon: Icons.get_app,
        label: 'Download',
        onTap: () => _showDownloadOptions(context),
      );
    }
  }

  // عرض خيارات التنزيل في حالة الويب
  void _showDownloadOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Download Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.appStoreUrl != null)
              ListTile(
                leading: Icon(Icons.apple, color: AppColors.primaryColor),
                title: Text('App Store'),
                onTap: () {
                  Navigator.pop(context);
                  UrlLauncher.launchURL(widget.appStoreUrl!, context: context);
                },
              ),
            if (widget.playStoreUrl != null)
              ListTile(
                leading: Icon(Icons.android, color: AppColors.primaryColor),
                title: Text('Google Play'),
                onTap: () {
                  Navigator.pop(context);
                  UrlLauncher.launchURL(widget.playStoreUrl!, context: context);
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultProjectImage() {
    return Center(
      child: Icon(
        _getCategoryIcon(widget.category),
        size: 80,
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'mobile app':
        return Icons.phone_android;
      case 'e-commerce':
        return Icons.shopping_cart;
      case 'education':
        return Icons.school;
      case 'communication':
        return Icons.chat;
      case 'web':
        return Icons.web;
      case 'productivity':
        return Icons.task_alt;
      default:
        return Icons.folder;
    }
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title,
      style: TextStyle(
        color: widget.isDark ? AppColors.textDark : AppColors.textLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCategoryAndDate() {
    return Row(
      children: [
        Icon(
          _getCategoryIcon(widget.category),
          size: 14,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 5),
        Text(
          widget.category,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: widget.isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Icon(
          Icons.calendar_today,
          size: 14,
          color: widget.isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            widget.date,
            style: TextStyle(
              color: widget.isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.description,
      style: TextStyle(
        color: widget.isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
        fontSize: 14,
        height: 1.5,
      ),
      maxLines: 2, // تقليل عدد الأسطر من 3 إلى 2
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTechnologies() {
    // حد عدد التقنيات المعروضة لتجنب تجاوز المحتوى
    final displayedTechnologies = widget.technologies.length > 3
        ? widget.technologies.sublist(0, 3)
        : widget.technologies;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: displayedTechnologies.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: widget.isDark
                ? AppColors.darkSecondary
                : AppColors.lightSecondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
          ),
          child: Text(
            tech,
            style: TextStyle(
              color: widget.isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              fontSize: 12,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButtons() {
    // استخدام زر واحد فقط لتجنب تجاوز المحتوى
    if (widget.projectUrl != null) {
      return TextButton.icon(
        onPressed: () =>
            UrlLauncher.launchURL(widget.projectUrl!, context: context),
        icon: const Icon(Icons.link, size: 18),
        label: const Text('View Project'),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          visualDensity: VisualDensity.compact,
        ),
      );
    }
    if (widget.images.isNotEmpty) {
      return TextButton.icon(
        onPressed: () => _showGallery(context),
        icon: const Icon(Icons.photo_library, size: 18),
        label: const Text('Gallery'),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          visualDensity: VisualDensity.compact,
        ),
      );
    }
    if (widget.appStoreUrl != null || widget.playStoreUrl != null) {
      return TextButton.icon(
        onPressed: () => _showDownloadOptions(context),
        icon: const Icon(Icons.download, size: 18),
        label: const Text('Download Options'),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          visualDensity: VisualDensity.compact,
        ),
      );
    } else {
      return const SizedBox(); // لا تظهر أي أزرار إذا لم تكن هناك روابط أو صور
    }
  }

  void _showGallery(BuildContext context) {
    if (widget.images.isEmpty) return;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        child: ProjectGallery(
          title: widget.title,
          images: widget.images,
          isDark: widget.isDark,
        ),
      ),
    );
  }
}

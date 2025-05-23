import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/utils/responsive.dart';
import 'package:personal_portfolio/features/about/presentation/widgets/about_section.dart';
import 'package:personal_portfolio/features/contact/presentation/widgets/contact_section.dart';
import 'package:personal_portfolio/features/contact/presentation/widgets/hire_me_handler.dart';
import 'package:personal_portfolio/features/education/presentation/widgets/education_section.dart';
import 'package:personal_portfolio/features/experience/presentation/widgets/experience_section.dart';
import 'package:personal_portfolio/features/hero/presentation/widgets/hero_section.dart';
import 'package:personal_portfolio/features/home/presentation/widgets/footer.dart';
import 'package:personal_portfolio/features/home/presentation/widgets/mobile_drawer.dart';
import 'package:personal_portfolio/features/home/presentation/widgets/navbar.dart';
import 'package:personal_portfolio/features/portfolio/presentation/widgets/portfolio_section.dart';
import 'package:personal_portfolio/features/services/presentation/widgets/services_section.dart';
import 'package:personal_portfolio/features/skills/presentation/widgets/skills_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedNavIndex = 0;
  bool _isDarkMode = true;

  // تحكم في الرسوم المتحركة عند التمرير
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<GlobalKey> _sectionKeys = List.generate(
    AppStrings.navItems.length,
    (index) => GlobalKey(),
  );

  // ضبط علامات تأكد ما إذا تم تنشيط القسم بالفعل
  final Map<String, bool> _sectionActivated = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // تهيئة وحدة تحكم الرسوم المتحركة
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // بدء الرسوم المتحركة
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // تحديث مؤشر التنقل المحدد بناءً على موضع التمرير
    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      if (key.currentContext != null) {
        final RenderBox renderBox =
            key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.of(context).size.height;

        if (position.dy <= screenHeight / 2 &&
            position.dy + renderBox.size.height >= screenHeight / 2) {
          if (_selectedNavIndex != i) {
            setState(() => _selectedNavIndex = i);
          }

          // تسجيل أن القسم نشط
          _sectionActivated[AppStrings.navItems[i]] = true;
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
    setState(() => _selectedNavIndex = index);
  }

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Navbar(
            selectedIndex: _selectedNavIndex,
            onNavItemTap: _scrollToSection,
            isDarkMode: _isDarkMode,
            onThemeToggle: _toggleTheme,
            onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ),
        endDrawer: Responsive.isMobile(context)
            ? MobileDrawer(
                selectedIndex: _selectedNavIndex,
                onNavItemTap: (index) {
                  Navigator.pop(context);
                  _scrollToSection(index);
                },
                isDarkMode: _isDarkMode,
              )
            : null,
        floatingActionButton: FadeTransition(
          opacity: _fadeAnimation,
          child: FloatingActionButton(
            onPressed: () => HireMeHandler.showHireMeDialog(context),
            backgroundColor: AppColors.primaryColor,
            tooltip: 'Hire Me',
            child: const Icon(Icons.work_outline, color: Colors.white),
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // قسم الرئيسية
                HeroSection(key: _sectionKeys[0]),

                // قسم حول
                AboutSection(
                  key: _sectionKeys[1],
                  scrollController: _scrollController,
                ),

                // قسم الخدمات
                ServicesSection(key: _sectionKeys[2]),

                // قسم المشاريع
                PortfolioSection(
                  key: _sectionKeys[3],
                  scrollController: _scrollController,
                ),

                // قسم الخبرات
                ExperienceSection(
                  key: _sectionKeys[4],
                  scrollController: _scrollController,
                ),

                // قسم التعليم
                EducationSection(
                  key: _sectionKeys[5],
                  scrollController: _scrollController,
                ),

                // قسم المهارات
                SkillsSection(
                  key: GlobalKey(),
                  scrollController: _scrollController,
                ),

                // قسم الاتصال
                ContactSection(key: _sectionKeys[6]),

                // التذييل
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

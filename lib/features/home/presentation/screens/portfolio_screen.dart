import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../about/presentation/widgets/about_section.dart';
import '../../../contact/presentation/widgets/contact_section.dart';
import '../../../contact/presentation/widgets/hire_me_handler.dart';
import '../../../education/presentation/widgets/education_section.dart';
import '../../../experience/presentation/widgets/experience_section.dart';
import '../../../hero/presentation/widgets/hero_section.dart';
import '../../../portfolio/presentation/widgets/portfolio_section.dart';
import '../../../services/presentation/widgets/services_section.dart';
import '../../../skills/presentation/widgets/skills_section.dart';
import '../widgets/footer.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/navbar.dart';
// import 'animation_config.dart';

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

  // Animation controllers
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Section-specific animations
  final Map<int, AnimationController> _sectionControllers = {};
  final Map<int, Map<String, Animation>> _sectionAnimations = {};
  final Map<int, bool> _sectionVisible = {};

  // Animation config
  AnimationConfig? _animationConfig;

  final List<GlobalKey> _sectionKeys = List.generate(8, (index) => GlobalKey());
  final Map<String, bool> _sectionActivated = {};

  @override
  void initState() {
    super.initState();
    _loadAnimationConfig();
    _scrollController.addListener(_onScroll);
    _initializeAnimations();
  }

  Future<void> _loadAnimationConfig() async {
    try {
      // لو عندك الملف في assets
      // final String response = await rootBundle.loadString('assets/animations/config.json');

      // مؤقتاً هنستخدم الداتا المباشرة
      final configData = {
        "animations": {
          "fadeIn": {"duration": 800, "curve": "easeOutCubic", "delay": 0},
          "slideUp": {
            "duration": 1000,
            "curve": "easeOutBack",
            "delay": 200,
            "offset": {"x": 0, "y": 0.3},
          },
          "scale": {
            "duration": 1200,
            "curve": "elasticOut",
            "delay": 400,
            "from": 0.8,
            "to": 1.0,
          },
        },
        "sections": [
          {
            "name": "hero",
            "index": 0,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "bottom",
            "triggerOffset": 0.2,
          },
          {
            "name": "about",
            "index": 1,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "left",
            "triggerOffset": 0.3,
          },
          {
            "name": "services",
            "index": 2,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "right",
            "triggerOffset": 0.25,
          },
          {
            "name": "portfolio",
            "index": 3,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "bottom",
            "triggerOffset": 0.3,
          },
          {
            "name": "experience",
            "index": 4,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "left",
            "triggerOffset": 0.25,
          },
          {
            "name": "education",
            "index": 5,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "right",
            "triggerOffset": 0.3,
          },
          {
            "name": "skills",
            "index": 6,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "bottom",
            "triggerOffset": 0.25,
          },
          {
            "name": "contact",
            "index": 7,
            "animations": ["fadeIn", "slideUp", "scale"],
            "slideDirection": "top",
            "triggerOffset": 0.3,
          },
        ],
        "globalSettings": {
          "staggerDelay": 100,
          "visibilityThreshold": 0.2,
          "enableParallax": true,
          "enableHover": true,
        },
      };

      setState(() {
        _animationConfig = AnimationConfig.fromJson(configData);
      });

      _setupSectionAnimations();
    } catch (e) {
      print('Error loading animation config: $e');
      _setupDefaultAnimations();
    }
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _fadeController.forward();
  }

  void _setupSectionAnimations() {
    if (_animationConfig == null) return;

    for (final section in _animationConfig!.sections) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 1000 + (section.index * 100)),
        vsync: this,
      );

      _sectionControllers[section.index] = controller;
      _sectionAnimations[section.index] = {};
      _sectionVisible[section.index] = false;

      // إنشاء الأنيميشن حسب الـ config
      _sectionAnimations[section.index]!['fade'] =
          Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
            ),
          );

      _sectionAnimations[section.index]!['slide'] =
          Tween<Offset>(begin: section.slideOffset, end: Offset.zero).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
            ),
          );

      _sectionAnimations[section.index]!['scale'] =
          Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
            ),
          );
    }

    // تشغيل أنيميشن القسم الأول
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateSection(0);
    });
  }

  void _setupDefaultAnimations() {
    // إعداد افتراضي في حالة فشل تحميل الـ config
    for (int i = 0; i < 8; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 800 + (i * 100)),
        vsync: this,
      );

      _sectionControllers[i] = controller;
      _sectionAnimations[i] = {};
      _sectionVisible[i] = false;

      _sectionAnimations[i]!['fade'] = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(controller);

      _sectionAnimations[i]!['slide'] = Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(controller);

      _sectionAnimations[i]!['scale'] = Tween<double>(
        begin: 0.9,
        end: 1.0,
      ).animate(controller);
    }
  }

  void _animateSection(int index) {
    if (_sectionVisible[index] == false &&
        _sectionControllers.containsKey(index)) {
      _sectionVisible[index] = true;
      _sectionControllers[index]?.forward();
    }
  }

  void _onScroll() {
    final screenHeight = MediaQuery.of(context).size.height;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      if (key.currentContext != null) {
        final RenderBox renderBox =
            key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);

        // تحديد الـ trigger threshold من الـ config
        double threshold = 0.3;
        if (_animationConfig != null && i < _animationConfig!.sections.length) {
          threshold = _animationConfig!.sections[i].triggerOffset;
        }

        // تشغيل الأنيميشن عند ظهور العنصر
        if (position.dy <= screenHeight * (1 - threshold) &&
            position.dy + renderBox.size.height >= 0) {
          _animateSection(i);
        }

        // تحديث الـ nav index
        if (position.dy <= screenHeight / 2 &&
            position.dy + renderBox.size.height >= screenHeight / 2) {
          if (_selectedNavIndex != i) {
            setState(() => _selectedNavIndex = i);
          }
          _sectionActivated[AppStrings.navItems[i]] = true;
          break;
        }
      }
    }
  }

  Widget _buildAnimatedSection(Widget section, int index) {
    if (!_sectionControllers.containsKey(index) ||
        !_sectionAnimations.containsKey(index)) {
      return section;
    }

    return AnimatedBuilder(
      animation: _sectionControllers[index]!,
      builder: (context, child) {
        final fadeAnim =
            _sectionAnimations[index]!['fade'] as Animation<double>;
        final slideAnim =
            _sectionAnimations[index]!['slide'] as Animation<Offset>;
        final scaleAnim =
            _sectionAnimations[index]!['scale'] as Animation<double>;

        return FadeTransition(
          opacity: fadeAnim,
          child: SlideTransition(
            position: slideAnim,
            child: ScaleTransition(
              scale: scaleAnim,
              child: Transform.translate(
                offset: Offset(0, (1 - fadeAnim.value) * 15),
                child: section,
              ),
            ),
          ),
        );
      },
    );
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
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    for (var controller in _sectionControllers.values) {
      controller.dispose();
    }
    super.dispose();
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
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: _fadeController,
                curve: Curves.elasticOut,
              ),
            ),
            child: FloatingActionButton(
              onPressed: () => HireMeHandler.showHireMeDialog(context),
              backgroundColor: AppColors.primaryColor,
              tooltip: 'Hire Me',
              elevation: 8,
              child: const Icon(Icons.work_outline, color: Colors.white),
            ),
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildAnimatedSection(HeroSection(key: _sectionKeys[0]), 0),
                _buildAnimatedSection(
                  AboutSection(
                    key: _sectionKeys[1],
                    scrollController: _scrollController,
                  ),
                  1,
                ),
                _buildAnimatedSection(ServicesSection(key: _sectionKeys[2]), 2),
                _buildAnimatedSection(
                  PortfolioSection(
                    key: _sectionKeys[3],
                    scrollController: _scrollController,
                  ),
                  3,
                ),
                _buildAnimatedSection(
                  ExperienceSection(
                    key: _sectionKeys[4],
                    scrollController: _scrollController,
                  ),
                  4,
                ),
                _buildAnimatedSection(
                  EducationSection(
                    key: _sectionKeys[5],
                    scrollController: _scrollController,
                  ),
                  5,
                ),
                _buildAnimatedSection(
                  SkillsSection(
                    key: _sectionKeys[6],
                    scrollController: _scrollController,
                  ),
                  6,
                ),
                _buildAnimatedSection(ContactSection(key: _sectionKeys[7]), 7),
                Footer(onNavItemTap: _scrollToSection),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Animation Config Classes (inline للتبسيط)
class AnimationConfig {
  final Map<String, AnimationData> animations;
  final List<SectionConfig> sections;
  final GlobalSettings globalSettings;

  AnimationConfig({
    required this.animations,
    required this.sections,
    required this.globalSettings,
  });

  factory AnimationConfig.fromJson(Map<String, dynamic> json) {
    return AnimationConfig(
      animations: (json['animations'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, AnimationData.fromJson(value)),
      ),
      sections: (json['sections'] as List)
          .map((section) => SectionConfig.fromJson(section))
          .toList(),
      globalSettings: GlobalSettings.fromJson(json['globalSettings']),
    );
  }
}

class AnimationData {
  final int duration;
  final String curve;
  final int delay;

  AnimationData({
    required this.duration,
    required this.curve,
    required this.delay,
  });

  factory AnimationData.fromJson(Map<String, dynamic> json) {
    return AnimationData(
      duration: json['duration'],
      curve: json['curve'],
      delay: json['delay'],
    );
  }
}

class SectionConfig {
  final String name;
  final int index;
  final List<String> animations;
  final String slideDirection;
  final double triggerOffset;

  SectionConfig({
    required this.name,
    required this.index,
    required this.animations,
    required this.slideDirection,
    required this.triggerOffset,
  });

  factory SectionConfig.fromJson(Map<String, dynamic> json) {
    return SectionConfig(
      name: json['name'],
      index: json['index'],
      animations: List<String>.from(json['animations']),
      slideDirection: json['slideDirection'],
      triggerOffset: json['triggerOffset'],
    );
  }

  Offset get slideOffset {
    switch (slideDirection) {
      case 'left':
        return const Offset(-0.3, 0);
      case 'right':
        return const Offset(0.3, 0);
      case 'top':
        return const Offset(0, -0.3);
      case 'bottom':
      default:
        return const Offset(0, 0.3);
    }
  }
}

class GlobalSettings {
  final int staggerDelay;
  final double visibilityThreshold;
  final bool enableParallax;
  final bool enableHover;

  GlobalSettings({
    required this.staggerDelay,
    required this.visibilityThreshold,
    required this.enableParallax,
    required this.enableHover,
  });

  factory GlobalSettings.fromJson(Map<String, dynamic> json) {
    return GlobalSettings(
      staggerDelay: json['staggerDelay'],
      visibilityThreshold: json['visibilityThreshold'],
      enableParallax: json['enableParallax'],
      enableHover: json['enableHover'],
    );
  }
}

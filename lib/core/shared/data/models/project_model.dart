class ProjectModel {
  final String title;
  final String category;
  final String date;
  final String description;
  final List<String> images; // تعديل لدعم عدة صور
  final String? thumbnailUrl; // صورة مصغرة للعرض الرئيسي
  final String? projectUrl; // رابط المشروع
  final String? appStoreUrl; // رابط App Store
  final String? playStoreUrl; // رابط Play Store
  final List<String> technologies; // التقنيات المستخدمة في المشروع
  final bool isPrivate; // لتحديد ما إذا كان المشروع خاصًا أم لا

  const ProjectModel({
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
    this.isPrivate = false, // القيمة الافتراضية للمشاريع العامة
  });
}

class ProjectData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Sherkety App',
      category: 'Mobile App',
      date: 'Nov 2024 – present',
      description:
          'Developed a comprehensive company formation app with detailed guides on business types and registration processes. Integrated AI-powered chatbot for real-time assistance, alongside a business card system with scanning/sharing capabilities.',
      projectUrl: 'https://github.com/mohamed12344556/sherkety',
      thumbnailUrl: "assets/images/projects/sherkety_thumbnail.png",
      images: [
        "assets/images/projects/sherkety1.png",
        "assets/images/projects/sherkety2.png",
        "assets/images/projects/sherkety3.png",
        "assets/images/projects/sherkety4.png",
        "assets/images/projects/sherkety5.png",
        "assets/images/projects/sherkety6.png",
        "assets/images/projects/sherkety7.png",
        "assets/images/projects/sherkety8.png",
      ],
      technologies: [
        'Flutter',
        'Bloc',
        'Firebase',
        'AI Chatbot',
        'Business Card System',
        'Scanning',
        'Sharing',
        'payments',
        'Responsive Design',
      ],
      isPrivate: true, // تحديد المشروع كخاص
    ),
    ProjectModel(
      title: 'Tkween',
      category: 'E-commerce',
      date: 'Mar 2025',
      description:
          'Developed a fully featured book store app using Flutter with secure JWT authentication, guest mode, integrated payment system and order tracking.',
      appStoreUrl:
          'https://apps.apple.com/ph/app/tkween-%D8%AA%D9%83%D9%88%D9%8A%D9%86/id6743707369',
      thumbnailUrl: "assets/images/projects/tkween_thumbnail.png",
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.tkweenstore.tkween_app',
      images: [
        "assets/images/projects/tkween1.png",
        "assets/images/projects/tkween2.png",
        "assets/images/projects/tkween3.png",
        "assets/images/projects/tkween4.png",
        "assets/images/projects/tkween5.png",
        "assets/images/projects/tkween6.png",
        "assets/images/projects/tkween7.png",
        "assets/images/projects/tkween8.png",
        "assets/images/projects/tkween9.png",
        "assets/images/projects/tkween10.png",
        "assets/images/projects/tkween11.png",
        "assets/images/projects/tkween12.png",
        "assets/images/projects/tkween13.png",
        "assets/images/projects/tkween14.png",
        "assets/images/projects/tkween15.png",
        "assets/images/projects/tkween16.png",
        "assets/images/projects/tkween17.png",
        "assets/images/projects/tkween18.png",
      ],
      technologies: [
        'Flutter',
        'cubit',
        'RESTful API',
        'Payment Integration',
        'JWT Authentication',
        'Responsive Design',
        'Order Tracking',
        'Guest Mode',
      ],
    ),
    ProjectModel(
      title: 'Ease Of Learn (EOL)',
      category: 'Education',
      date: 'Jun 2023 - Jul 2024',
      description:
          'Graduation project that helps students improve their academic performance by creating personalized study schedules and providing round-the-clock support via chatbot.',
      projectUrl: 'https://github.com/mohamed12344556/ease-of-learn',
      images: [],
      technologies: ['Flutter', 'Firebase', 'ML', 'Chatbot'],
    ),
    ProjectModel(
      title: 'Chat App',
      category: 'Communication',
      date: 'Sep 2024',
      description: 'A chat app using Firebase and a custom AI model.',
      projectUrl: 'https://github.com/mohamed12344556/chat-app',
      images: [],
      technologies: ['Flutter', 'Firebase', 'Cloud Functions', 'AI Model'],
    ),
    ProjectModel(
      title: 'Portfolio Website',
      category: 'Web',
      date: 'May 2025',
      description:
          'Personal portfolio website built with Flutter Web showcasing projects and skills.',
      projectUrl: 'https://github.com/mohamed12344556/portfolio',
      images: [],
      technologies: ['Flutter Web', 'Animations', 'Responsive Design'],
    ),
    ProjectModel(
      title: 'Task Manager',
      category: 'Productivity',
      date: 'Jan 2025',
      description:
          'A task management application with Firebase integration for data synchronization.',
      projectUrl: 'https://github.com/mohamed12344556/task-manager',
      images: [],
      technologies: ['Flutter', 'Firebase', 'State Management'],
    ),
  ];

  static List<String> getCategories() {
    final Set<String> categories = {};
    for (var project in projects) {
      categories.add(project.category);
    }
    return categories.toList();
  }
}

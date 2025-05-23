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
  });
}

class ProjectData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Sherkety App',
      category: 'Mobile App',
      date: 'Nov 2024 - present',
      description:
          'Developed a comprehensive company formation app with detailed guides on business types and registration processes. Integrated AI-powered chatbot for real-time assistance, alongside a business card system with scanning/sharing capabilities.',
      projectUrl: 'https://github.com/mohamed12344556/sherkety',
      thumbnailUrl: "assets/images/test.jpg",
      images: ["assets/images/test.jpg"],
      technologies: ['Flutter', 'Firebase', 'Bloc', 'AI Integration'],
    ),
    ProjectModel(
      title: 'Tkween',
      category: 'E-commerce',
      date: 'Mar 2025',
      description:
          'Developed a fully featured book store app using Flutter with secure JWT authentication, guest mode, integrated payment system and order tracking.',
      appStoreUrl: 'https://apps.apple.com/app/tkween',
      thumbnailUrl: "assets/images/test.jpg",
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.mohamed.tkween',
      images: ["assets/images/test.jpg", "assets/images/test.jpg"],
      technologies: [
        'Flutter',
        'RESTful API',
        'Payment Integration',
        'Firebase',
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

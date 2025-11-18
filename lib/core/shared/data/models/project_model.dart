class ProjectModel {
  final String id;
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
  final bool isPrivate;

  const ProjectModel({
    required this.id,
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
    this.isPrivate = false,
  });

  // Convert ProjectModel to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'date': date,
      'description': description,
      'images': images,
      'thumbnailUrl': thumbnailUrl,
      'projectUrl': projectUrl,
      'appStoreUrl': appStoreUrl,
      'playStoreUrl': playStoreUrl,
      'technologies': technologies,
      'isPrivate': isPrivate,
    };
  }

  // Create ProjectModel from Firebase JSON
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      thumbnailUrl: json['thumbnailUrl'],
      projectUrl: json['projectUrl'],
      appStoreUrl: json['appStoreUrl'],
      playStoreUrl: json['playStoreUrl'],
      technologies: List<String>.from(json['technologies'] ?? []),
      isPrivate: json['isPrivate'] ?? false,
    );
  }

  // Create a copy with updated fields
  ProjectModel copyWith({
    String? id,
    String? title,
    String? category,
    String? date,
    String? description,
    List<String>? images,
    String? thumbnailUrl,
    String? projectUrl,
    String? appStoreUrl,
    String? playStoreUrl,
    List<String>? technologies,
    bool? isPrivate,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
      images: images ?? this.images,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      projectUrl: projectUrl ?? this.projectUrl,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      technologies: technologies ?? this.technologies,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}

class ProjectData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      id: 'yalla_rehla',
      title: 'Yalla Rehla',
      category: 'Mobile App',
      date: 'June 2025',
      description:
          'a travel booking app with dark/light mode support and localization. Integrated AI-powered search (including image-based search) and an AI chatbot for product recommendations. Implemented a complete booking system with online payments using Paymob.',
      projectUrl: 'https://github.com/mohamed12344556/yalla_r7la2.git',
      thumbnailUrl: "assets/images/projects/yalla_r7la2_27.png",
      images: [
        "assets/images/projects/yalla_r7la2_1.png",
        "assets/images/projects/yalla_r7la2_2.png",
        "assets/images/projects/yalla_r7la2_3.png",
        "assets/images/projects/yalla_r7la2_4.png",
        "assets/images/projects/yalla_r7la2_5.png",
        "assets/images/projects/yalla_r7la2_6.png",
        "assets/images/projects/yalla_r7la2_7.png",
        "assets/images/projects/yalla_r7la2_8.png",
        "assets/images/projects/yalla_r7la2_9.png",
        "assets/images/projects/yalla_r7la2_10.png",
        "assets/images/projects/yalla_r7la2_11.png",
        "assets/images/projects/yalla_r7la2_12.png",
        "assets/images/projects/yalla_r7la2_13.png",
        "assets/images/projects/yalla_r7la2_14.png",
        "assets/images/projects/yalla_r7la2_15.png",
        "assets/images/projects/yalla_r7la2_16.png",
        "assets/images/projects/yalla_r7la2_17.png",
        "assets/images/projects/yalla_r7la2_18.png",
        "assets/images/projects/yalla_r7la2_19.png",
        "assets/images/projects/yalla_r7la2_20.png",
        "assets/images/projects/yalla_r7la2_21.png",
        "assets/images/projects/yalla_r7la2_22.png",
        "assets/images/projects/yalla_r7la2_23.png",
        "assets/images/projects/yalla_r7la2_24.png",
        "assets/images/projects/yalla_r7la2_25.png",
        "assets/images/projects/yalla_r7la2_26.png",
        "assets/images/projects/yalla_r7la2_27.png",
        "assets/images/projects/yalla_r7la2_28.png",
        "assets/images/projects/yalla_r7la2_29.png",
        "assets/images/projects/yalla_r7la2_30.png",
        "assets/images/projects/yalla_r7la2_31.png",
        "assets/images/projects/yalla_r7la2_32.png",
      ],
      technologies: [
        'Flutter',
        'Animations',
        'Responsive Design',
        'AI Chatbot',
        'AI Search',
        'Paymob',
      ],
    ),
    ProjectModel(
      id: 'sherkety_app',
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
        'Bloc/Cubit',
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
      id: 'tkween',
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
      id: 'ease_of_learn',
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
      id: 'chat_app',
      title: 'Chat App',
      category: 'Communication',
      date: 'Sep 2024',
      description: 'A chat app using Firebase and a custom AI model.',
      projectUrl: 'https://github.com/mohamed12344556/chat-app',
      images: [],
      technologies: ['Flutter', 'Firebase', 'Cloud Functions', 'AI Model'],
    ),
    ProjectModel(
      id: 'portfolio_website',
      title: 'Portfolio Website',
      category: 'Web',
      date: 'May 2025',
      description:
          'Personal portfolio website built with Flutter Web showcasing projects and skills.',
      projectUrl: 'https://github.com/mohamed12344556/portfolio',
      images: [],
      technologies: ['Flutter Web', 'Animations', 'Responsive Design'],
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

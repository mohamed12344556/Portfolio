class ExperienceModel {
  final String company;
  final String role;
  final String duration;
  final String location;
  final List<String> description;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    required this.location,
    required this.description,
  });
}

class ExperienceData {
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      company: 'Cellula Technologies',
      role: 'Flutter Developer',
      duration: 'Feb 2025 – Apr 2025',
      location: 'Egypt',
      description: [
        'Cellula Robotics Ltd. develops autonomous underwater vehicles (AUVs) with sustainable, hydrogen-powered solutions.',
        'The company provides advanced robotics for defense, resource exploration, and marine energy.',
        'As a Flutter Developer intern, I worked on app performance, UI design, and system integration for smart robotics.',
      ],
    ),
    ExperienceModel(
      company: 'Sherkety',
      role: 'Mobile Application Developer',
      duration: 'Oct 2024 – May 2025',
      location: 'Germany',
      description: [
        'Practical training on entrepreneurship and startup development.',
        'Comprehensive coverage of legal, administrative, and technical essentials.',
        'Designed to equip participants with tools for successful business growth.',
      ],
    ),
    ExperienceModel(
      company: 'Career180 (LearnIT Academy)',
      role: 'Flutter Developer Intern',
      duration: 'Sep 2024 – Nov 2024',
      location: 'Egypt',
      description: [
        'Participation in a training program for developing mobile applications using Flutter.',
        'Enhancing technical skills in navigating between screens and creating distinct user interfaces.',
        'Apply the Clean Architecture concept to design applications efficiently.',
      ],
    ),
    ExperienceModel(
      company: 'Internship Pakistan',
      role: 'Flutter Developer',
      duration: 'Sep 2024 – Nov 2024',
      location: 'Pakistan',
      description: [
        'Develop Flutter applications oriented to use interactive and elegant user interfaces.',
        'Commitment to specified working hours and gaining experience in an international work environment.',
      ],
    ),
    ExperienceModel(
      company: 'CodeAlpha Internship',
      role: 'App Development Intern',
      duration: 'Sep 2024 – Nov 2024',
      location: 'India',
      description: [
        'Implemented practical mobile application projects using Flutter, focusing on improving performance and user experience.',
        'Collaborate with a diverse technical team to develop MVVM architectural applications.',
      ],
    ),
    ExperienceModel(
      company: 'ITI',
      role: 'Mobile Development using Flutter',
      duration: 'Sep 2022 – Dec 2022',
      location: 'Egypt',
      description: [
        'The internship focused on developing applications using Flutter.',
        'I learned the basics of Dart and Flutter, navigating between pages, and other essential skills required to build a complete project with a user interface.',
      ],
    ),
  ];
}

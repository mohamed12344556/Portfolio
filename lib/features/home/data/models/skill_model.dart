import 'package:flutter/material.dart';

class SkillCategory {
  final String name;
  final List<String> skills;
  final IconData icon;

  const SkillCategory({
    required this.name,
    required this.skills,
    required this.icon,
  });
}

class SkillData {
  static const List<SkillCategory> categories = [
    SkillCategory(
      name: 'Programming Languages',
      icon: Icons.code,
      skills: ['Dart & OOP & SOLID', 'C++'],
    ),
    SkillCategory(
      name: 'Frameworks',
      icon: Icons.widgets,
      skills: ['Flutter', 'Firebase'],
    ),
    SkillCategory(
      name: 'State Management',
      icon: Icons.storage,
      skills: ['Bloc/Cubit', 'Riverpod'],
    ),
    SkillCategory(
      name: 'Databases',
      icon: Icons.data_usage,
      skills: ['Local databases', 'RESTful APIs'],
    ),
    SkillCategory(
      name: 'Version Control',
      icon: Icons.history,
      skills: ['Git & version control systems'],
    ),
    SkillCategory(
      name: 'Architecture',
      icon: Icons.architecture,
      skills: ['Clean Architecture', 'MVVM Architecture'],
    ),
    SkillCategory(
      name: 'UI/UX',
      icon: Icons.design_services,
      skills: ['User Interface Design', 'Animation'],
    ),
  ];

  // Skill proficiency data for skill bars
  static const Map<String, double> skillProficiency = {
    'Flutter': 0.90,
    'Dart': 0.85,
    'Firebase': 0.80,
    'Bloc/Cubit': 0.85,
    'Riverpod': 0.75,
    'Clean Architecture': 0.70,
    'MVVM Architecture': 0.65,
    'UI/UX': 0.80,
    'RESTful APIs': 0.75,
    'Git': 0.70,
  };
}

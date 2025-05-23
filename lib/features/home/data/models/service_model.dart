import 'package:flutter/material.dart';

class ServiceModel {
  final IconData icon;
  final String title;
  final String description;

  const ServiceModel({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class ServicesData {
  static const List<ServiceModel> services = [
    ServiceModel(
      icon: Icons.phone_android,
      title: 'Mobile App Development',
      description:
          'Building high-performance cross-platform mobile applications using Flutter for both Android and iOS.',
    ),
    ServiceModel(
      icon: Icons.web,
      title: 'Web Development',
      description:
          'Creating responsive and modern web applications using Flutter Web with seamless user experience.',
    ),
    ServiceModel(
      icon: Icons.api,
      title: 'API Integration',
      description:
          'Seamlessly integrating RESTful APIs and third-party services to enhance app functionality.',
    ),
    ServiceModel(
      icon: Icons.storage,
      title: 'State Management',
      description:
          'Implementing efficient state management solutions using Bloc/Cubit and Riverpod patterns.',
    ),
    ServiceModel(
      icon: Icons.architecture,
      title: 'Clean Architecture',
      description:
          'Designing scalable and maintainable applications following Clean Architecture principles.',
    ),
    ServiceModel(
      icon: Icons.brush,
      title: 'UI/UX Design',
      description:
          'Creating beautiful and intuitive user interfaces with smooth animations and interactions.',
    ),
  ];
}
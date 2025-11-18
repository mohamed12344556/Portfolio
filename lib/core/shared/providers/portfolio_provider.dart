import 'package:flutter/material.dart';
import '../data/models/project_model.dart';
import '../data/models/experience_model.dart';
import '../data/models/personal_info_model.dart';
import '../data/repositories/firebase_repository.dart';

/// Provider for managing portfolio data from Firebase
/// This provides real-time data updates to all widgets
class PortfolioProvider extends ChangeNotifier {
  final FirebaseRepository _repository = FirebaseRepository();

  // Personal Info
  PersonalInfoModel _personalInfo = PersonalInfoData.defaultInfo;
  PersonalInfoModel get personalInfo => _personalInfo;

  // Skills
  Map<String, dynamic> _skills = {};
  Map<String, dynamic> get skills => _skills;

  PortfolioProvider() {
    _initializeListeners();
  }

  void _initializeListeners() {
    // Listen to Personal Info changes
    _repository.getPersonalInfo().listen((info) {
      if (info != null) {
        _personalInfo = info;
        notifyListeners();
      }
    }, onError: (error) {
      debugPrint('Error loading personal info: $error');
    });

    // Listen to Skills changes
    _repository.getSkills().listen((skillsData) {
      if (skillsData.isNotEmpty) {
        _skills = skillsData;
        notifyListeners();
      }
    }, onError: (error) {
      debugPrint('Error loading skills: $error');
    });
  }

  // Get projects stream (used directly in widgets)
  Stream<List<ProjectModel>> getProjects() => _repository.getProjects();

  // Get experiences stream (used directly in widgets)
  Stream<List<ExperienceModel>> getExperiences() => _repository.getExperiences();
}

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/personal_info_model.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collections
  static const String projectsCollection = 'projects';
  static const String experiencesCollection = 'experiences';
  static const String personalInfoCollection = 'personal_info';
  static const String skillsCollection = 'skills';

  // ==================== Projects ====================

  Stream<List<ProjectModel>> getProjects() {
    return _firestore
        .collection(projectsCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProjectModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Future<ProjectModel?> getProjectById(String id) async {
    try {
      final doc = await _firestore.collection(projectsCollection).doc(id).get();
      if (doc.exists) {
        return ProjectModel.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      print('Error getting project: $e');
      return null;
    }
  }

  Future<void> addProject(ProjectModel project) async {
    try {
      await _firestore
          .collection(projectsCollection)
          .doc(project.id)
          .set(project.toJson());
    } catch (e) {
      print('Error adding project: $e');
      rethrow;
    }
  }

  Future<void> updateProject(ProjectModel project) async {
    try {
      await _firestore
          .collection(projectsCollection)
          .doc(project.id)
          .update(project.toJson());
    } catch (e) {
      print('Error updating project: $e');
      rethrow;
    }
  }

  Future<void> deleteProject(String id) async {
    try {
      await _firestore.collection(projectsCollection).doc(id).delete();
    } catch (e) {
      print('Error deleting project: $e');
      rethrow;
    }
  }

  // ==================== Experiences ====================

  Stream<List<ExperienceModel>> getExperiences() {
    return _firestore
        .collection(experiencesCollection)
        .orderBy('duration', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ExperienceModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Future<void> addExperience(ExperienceModel experience) async {
    try {
      await _firestore
          .collection(experiencesCollection)
          .doc(experience.id)
          .set(experience.toJson());
    } catch (e) {
      print('Error adding experience: $e');
      rethrow;
    }
  }

  Future<void> updateExperience(ExperienceModel experience) async {
    try {
      await _firestore
          .collection(experiencesCollection)
          .doc(experience.id)
          .update(experience.toJson());
    } catch (e) {
      print('Error updating experience: $e');
      rethrow;
    }
  }

  Future<void> deleteExperience(String id) async {
    try {
      await _firestore.collection(experiencesCollection).doc(id).delete();
    } catch (e) {
      print('Error deleting experience: $e');
      rethrow;
    }
  }

  // ==================== Personal Info ====================

  Stream<PersonalInfoModel?> getPersonalInfo() {
    return _firestore
        .collection(personalInfoCollection)
        .doc('default')
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return PersonalInfoModel.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    });
  }

  Future<void> updatePersonalInfo(PersonalInfoModel info) async {
    try {
      await _firestore
          .collection(personalInfoCollection)
          .doc('default')
          .set(info.toJson(), SetOptions(merge: true));
    } catch (e) {
      print('Error updating personal info: $e');
      rethrow;
    }
  }

  // ==================== Skills ====================

  Stream<Map<String, dynamic>> getSkills() {
    return _firestore
        .collection(skillsCollection)
        .doc('default')
        .snapshots()
        .map((doc) => doc.exists ? doc.data()! : {});
  }

  Future<void> updateSkills(Map<String, dynamic> skills) async {
    try {
      await _firestore
          .collection(skillsCollection)
          .doc('default')
          .set(skills, SetOptions(merge: true));
    } catch (e) {
      print('Error updating skills: $e');
      rethrow;
    }
  }

  // ==================== Storage (Images) ====================

  Future<String> uploadImage(String path, List<int> imageData) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putData(imageData as Uint8List);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> deleteImage(String path) async {
    try {
      await _storage.ref().child(path).delete();
    } catch (e) {
      print('Error deleting image: $e');
      rethrow;
    }
  }

  // ==================== Initialize with Default Data ====================

  Future<void> initializeWithDefaultData() async {
    try {
      // Add default projects
      for (var project in ProjectData.projects) {
        await addProject(project);
      }

      // Add default experiences
      for (var experience in ExperienceData.experiences) {
        await addExperience(experience);
      }

      // Add default personal info
      await updatePersonalInfo(PersonalInfoData.defaultInfo);

      print('Default data initialized successfully');
    } catch (e) {
      print('Error initializing default data: $e');
      rethrow;
    }
  }
}

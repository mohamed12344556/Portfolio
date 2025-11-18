import 'package:flutter/material.dart';
import '../repositories/firebase_repository.dart';

/// Helper class to initialize Firebase with default data
/// USE THIS ONLY ONCE to upload your local data to Firebase
class FirebaseDataInitializer {
  final FirebaseRepository _repository = FirebaseRepository();

  /// Initialize Firebase with all default data
  /// Call this function ONCE after setting up Firebase
  Future<void> initializeAllData() async {
    try {
      debugPrint('🚀 Starting Firebase data initialization...');

      await _repository.initializeWithDefaultData();

      debugPrint('✅ Firebase initialization completed successfully!');
      debugPrint('💡 You can now edit data from Firebase Console');
    } catch (e) {
      debugPrint('❌ Error initializing Firebase data: $e');
      rethrow;
    }
  }

  /// Check if Firebase data exists
  Future<bool> hasData() async {
    try {
      final projects = await _repository.getProjects().first;
      return projects.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking Firebase data: $e');
      return false;
    }
  }

  /// Show initialization dialog
  static void showInitializationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Initialize Firebase Data'),
        content: const Text(
          'This will upload all your local data to Firebase.\n\n'
          'Do this ONLY ONCE.\n\n'
          'After initialization, you can edit data from Firebase Console.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final initializer = FirebaseDataInitializer();

              // Show loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );

              try {
                await initializer.initializeAllData();

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Data initialized successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('❌ Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Initialize'),
          ),
        ],
      ),
    );
  }
}

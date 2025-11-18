import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../core/shared/data/repositories/firebase_repository.dart';
import '../firebase_options.dart';

/// Standalone script to upload all local data to Firebase
///
/// Run this ONCE after setting up Firebase:
/// ```
/// flutter run lib/scripts/upload_data_to_firebase.dart
/// ```

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 Starting Firebase data upload...\n');

  try {
    // Initialize Firebase
    print('📱 Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully\n');

    // Create repository
    final repository = FirebaseRepository();

    // Upload data
    print('📤 Uploading all data to Firebase...');
    await repository.initializeWithDefaultData();

    print('\n✅ SUCCESS! All data has been uploaded to Firebase!\n');
    print('🎉 You can now:');
    print('   1. Go to Firebase Console');
    print('   2. Open Firestore Database');
    print('   3. Edit your data directly');
    print('   4. Changes will appear in your app immediately!\n');
    print('⚠️  Remember to remove the "Init Firebase" button from your app');

  } catch (e, stackTrace) {
    print('\n❌ ERROR: Failed to upload data');
    print('Error: $e');
    print('Stack trace: $stackTrace\n');
    print('💡 Make sure you have:');
    print('   1. Run "flutterfire configure"');
    print('   2. Enabled Firestore Database in Firebase Console');
    print('   3. Set Security Rules to allow write access');
  }
}

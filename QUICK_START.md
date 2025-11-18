# 🚀 Quick Start - Firebase Setup

## TL;DR - Fast Setup (5 minutes)

### 1. Install Firebase CLI & FlutterFire
```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login
```

### 2. Configure Firebase
```bash
cd "C:\Users\amaz8\OneDrive\Documents\Flutter Projects\Portfolio"
flutterfire configure
```

### 3. Enable Firestore & Storage
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Enable **Firestore Database** (Test mode)
4. Enable **Storage** (Test mode)

### 4. Set Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: true;
    }
  }
}
```

### 5. Set Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: true;
    }
  }
}
```

### 6. Update main.dart
Add this import after running `flutterfire configure`:
```dart
import 'firebase_options.dart';

// Update Firebase.initializeApp() to:
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### 7. Run the app
```bash
flutter run
```

---

## What Changed?

✅ **Models** - Now support JSON serialization (fromJson/toJson)
✅ **Repository** - FirebaseRepository for CRUD operations
✅ **Real-time** - Data updates automatically from Firebase
✅ **Storage** - Image upload support
✅ **Admin** - Edit data from Firebase Console without code changes

---

## Firebase Collections Structure

```
projects/          → Your portfolio projects
experiences/       → Work experience
personal_info/     → Personal information
skills/            → Technical skills
```

---

## How to Edit Data

### Option 1: Firebase Console (Recommended)
1. Open [Firebase Console](https://console.firebase.google.com/)
2. Go to Firestore Database
3. Click on any collection → document → field
4. Edit and save
5. Changes appear in app instantly! 🎉

### Option 2: Initialize with Current Data
Run this once to upload your hardcoded data to Firebase:
```dart
final repo = FirebaseRepository();
await repo.initializeWithDefaultData();
```

---

## Need Help?

📖 Read full guide: [FIREBASE_SETUP_AR.md](./FIREBASE_SETUP_AR.md) (Arabic)

---

**Made with ❤️ by Claude Code**

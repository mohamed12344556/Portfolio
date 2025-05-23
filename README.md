
## 🚀 Features

- ✨ **Responsive Design**: Works perfectly on all devices (Desktop, Tablet, Mobile)
- 🎨 **Dark/Light Theme**: Smooth theme switching with persistent state
- 🎭 **Smooth Animations**: Beautiful animations and transitions
- 📱 **Mobile-First**: Designed with mobile users in mind
- 🎯 **Clean Architecture**: Well-organized and maintainable code structure
- 🌈 **Gradient Effects**: Modern gradient effects throughout the app
- 📄 **PDF CV Generation**: Download CV as PDF
- 📧 **Contact Form**: Functional contact form with validation

## 📋 Requirements

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0

## 🛠️ Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/flutter-portfolio.git
cd flutter-portfolio
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# For web
flutter run -d chrome

# For mobile
flutter run

# Build for production
flutter build web --release
flutter build apk --release
```

## 📁 Project Structure

```
lib/
├── main.dart                    # Entry point
├── app.dart                     # App configuration
├── core/                        # Core functionality
│   ├── constants/              # App constants
│   ├── theme/                  # Theme configuration
│   ├── utils/                  # Utility functions
│   └── widgets/                # Shared widgets
├── features/                    # Feature modules
│   ├── home/                   # Home/Navigation
│   ├── hero/                   # Hero section
│   ├── about/                  # About section
│   ├── services/               # Services section
│   ├── portfolio/              # Portfolio section
│   ├── experience/             # Experience section
│   ├── education/              # Education section
│   ├── skills/                 # Skills section
│   └── contact/                # Contact section
└── shared/                      # Shared components
    ├── animations/             # Custom animations
    └── models/                 # Data models
```

## 🎨 Customization

### Colors
Edit `lib/core/constants/app_colors.dart` to change the color scheme.

### Personal Information
Update `lib/core/constants/app_strings.dart` with your personal information.

### Adding Projects
Add new projects in the portfolio data file located in the features folder.

## 🚀 Deployment

### Web Deployment
```bash
flutter build web --release
# Deploy the build/web folder to your hosting service
```

### Mobile Deployment
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📄 License

This project is licensed under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

Made with ❤️ by Mohamed Abdelqawi
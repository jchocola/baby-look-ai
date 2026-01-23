# BabyLook AI - Baby Face Prediction App

<p align="center">
  <img src="assets/logo.png" alt="BabyLook Logo" width="200"/>
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-%5E3.9.2-blue.svg" alt="Flutter Version"></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-%5E3.9.2-0175C2.svg" alt="Dart Version"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
  <a href="https://github.com/yourusername/baby_look/stargazers"><img src="https://img.shields.io/github/stars/yourusername/baby_look.svg" alt="GitHub Stars"></a>
</p>

BabyLook AI is a cutting-edge mobile application that uses artificial intelligence to predict what your unborn baby might look like. By analyzing ultrasound scans and parental photos, our advanced AI generates realistic predictions of your baby's future appearance.

## 🌟 Features

### Core Functionality
- **AI-Powered Baby Prediction**: Utilizes Google's Gemini AI to create realistic baby face predictions
- **Multi-Image Analysis**: Processes ultrasound scans along with parental photos for enhanced accuracy
- **Realistic Rendering**: Generates photorealistic images of predicted baby faces
- **Cross-Platform Support**: Available on iOS, Android, and web platforms

### User Experience
- **Intuitive Interface**: Clean, user-friendly design with step-by-step guidance
- **Multi-Language Support**: Available in English, Russian, and Vietnamese
- **Secure Authentication**: Phone number verification with Firebase Authentication
- **Prediction Gallery**: Save and organize your baby predictions
- **Social Sharing**: Share predictions with family and friends

### Technical Features
- **Background Processing**: Non-blocking image processing using Flutter isolates
- **Cloud Storage**: Firebase integration for secure image storage
- **Push Notifications**: Real-time updates and reminders
- **Offline Capabilities**: Core functionality available without internet

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Android Studio or VS Code
- Firebase account
- Google Cloud Platform account (for Gemini API)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/baby_look.git
   cd baby_look
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Environment Setup**
   Create a `.env` file in the root directory:
   ```env
   # Firebase Configuration
   FIREBASE_API_KEY=your_firebase_api_key
   FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
   FIREBASE_PROJECT_ID=your_project_id
   FIREBASE_STORAGE_BUCKET=your_project.appspot.com
   FIREBASE_MESSAGING_SENDER_ID=your_sender_id
   FIREBASE_APP_ID=your_app_id
   
   # Gemini AI Configuration
   GEMINI_API_KEY=your_gemini_api_key
   
   # Wiredash Feedback
   WIREDASH_PROJECT_ID=your_wiredash_project_id
   WIREDASH_SECRET_KEY=your_wiredash_secret_key
   ```

4. **Firebase Setup**
   - Create a Firebase project
   - Enable Authentication, Cloud Firestore, and Storage
   - Download and place `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in respective directories

5. **Run the application**
   ```bash
   flutter run
   ```

## 🏗️ Architecture

### Tech Stack

**Frontend**
- Flutter Framework
- Dart Programming Language
- BLoC State Management
- Go Router for Navigation
- Firebase SDK

**Backend Services**
- Google Gemini AI (gemini-3-pro-image-preview)
- Firebase Authentication
- Cloud Firestore Database
- Firebase Cloud Storage

**Development Tools**
- Flutter Lints for code quality
- Easy Localization for multi-language support
- Wiredash for user feedback
- Logger for debugging

### Project Structure

```
lib/
├── core/                    # Core application components
│   ├── app_constant/       # Application constants
│   ├── app_enum/          # Enumerations
│   ├── app_icon/          # Custom icons
│   ├── app_theme/         # Theming
│   ├── di/               # Dependency injection
│   ├── router/           # Application routing
│   └── bloc/             # Global BLoC patterns
├── features/              # Feature modules
│   ├── feature_auth/     # Authentication system
│   ├── feature_dashboard/ # Home dashboard
│   ├── feature_gallery/  # Prediction gallery
│   ├── feature_generate/ # AI prediction generation
│   └── feature_user/     # User profile management
├── shared/               # Shared widgets and utilities
└── main.dart            # Application entry point
```

## 🎯 Key Components

### AI Service (`BananaProService`)
Handles communication with Google's Gemini AI for image generation with built-in background processing to prevent UI blocking.

### State Management
Uses BLoC pattern for predictable state management across features:
- `PrepareDataBloc`: Handles image selection and form data
- `GeneratingBloc`: Manages AI prediction generation process
- `PredictionsBloc`: Controls gallery and saved predictions
- `AuthBloc`: Handles user authentication
- `UserBloc`: Manages user profile and settings

### Image Processing Pipeline
1. **Input Collection**: Ultrasound scan + optional parental photos
2. **Preprocessing**: Image validation and optimization
3. **AI Generation**: Gemini API processing with custom prompts
4. **Post-processing**: Background image optimization
5. **Storage**: Secure cloud storage with Firebase

## 📱 Screenshots

<div align="center">
  <img src="screenshots/home.png" width="200" alt="Home Screen"/>
  <img src="screenshots/step1.png" width="200" alt="Step 1"/>
  <img src="screenshots/step2.png" width="200" alt="Step 2"/>
  <img src="screenshots/step3.png" width="200" alt="Step 3"/>
  <img src="screenshots/result.png" width="200" alt="Result"/>
  <img src="screenshots/gallery.png" width="200" alt="Gallery"/>
</div>

## 🤝 Contributing

We welcome contributions to BabyLook AI! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter's official style guide
- Write meaningful commit messages
- Add tests for new functionality
- Update documentation when necessary
- Ensure all tests pass before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Google's Gemini AI team for the powerful image generation capabilities
- Flutter community for excellent documentation and packages
- Firebase team for reliable backend services
- All contributors who have helped shape this project

## 📞 Support

For support, email bak_nguen@vk.com.

---

<p align="center">Made with ❤️ for expecting parents everywhere</p>

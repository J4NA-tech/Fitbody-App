# FitBody — Mobile Fitness Application

<p align="center">
  <strong>A Flutter-based mobile fitness application for personalized workouts, progress tracking, and a better fitness experience.</strong>
</p>

<p align="center">
  <img src="images/Home%20Screen%20%E2%80%93%20Recommendations%20%26%20Motivation.png" width="230"/>
  <img src="images/Workout%20Plans.png" width="230"/>
  <img src="images/Progress%20%26%20Workout%20History.png" width="230"/>
</p>

## 📱 About

**FitBody** is a mobile fitness application developed with **Flutter and Dart** as a Computer Engineering graduation project.

The application allows users to create a personalized fitness experience based on their goals and activity levels. Users can explore workout plans, watch exercise videos, track completed workouts, monitor their progress, and access motivational and health-related content.

The project combines a modern mobile UI with cloud-based authentication and data management using **Supabase** and **Firebase Firestore**.

## ✨ Features

* 🔐 User registration and authentication
* 👤 Personalized user profiles
* 🎯 Fitness goal and activity-level selection
* 🏋️ Workout plans
* 💪 Strength, Endurance, and Flexibility categories
* 🎥 Exercise video integration
* 📊 Workout history and progress tracking
* 🔥 Calories and workout statistics
* 📰 Motivational and health-related content
* ⚙️ User settings
* 🌙 Dark mode
* 🌍 Language preferences

## 🛠️ Tech Stack

| Technology             | Purpose                                       |
| ---------------------- | --------------------------------------------- |
| **Flutter**            | Cross-platform mobile application development |
| **Dart**               | Application programming language              |
| **Supabase**           | Authentication and session management         |
| **Firebase Firestore** | User data storage                             |
| **Android Studio**     | Development environment                       |
| **Git & GitHub**       | Version control                               |

## 📸 Screenshots

### 🔐 Login Screen

User authentication interface for signing in and accessing the application.

<p align="center">
  <img src="images/Login%20Screen.png" width="260"/>
</p>

---

### 🏠 Home Screen — Recommendations & Motivation

The main dashboard provides workout recommendations, motivational content, and health-related articles.

<p align="center">
  <img src="images/Home%20Screen%20%E2%80%93%20Recommendations%20%26%20Motivation.png" width="260"/>
</p>

---

### 🏋️ Workout Plans

Users can explore workout plans based on their fitness level and training category.

<p align="center">
  <img src="images/Workout%20Plans.png" width="260"/>
</p>

---

### 📊 Progress & Workout History

Users can track completed workouts, calories burned, total workout time, and their overall workout history.

<p align="center">
  <img src="images/Progress%20%26%20Workout%20History.png" width="260"/>
</p>

---

### 🚀 Splash Screen

The initial screen displayed when launching the FitBody application.

<p align="center">
  <img src="images/Splash%20Screen.png" width="260"/>
</p>

---

### 👋 Onboarding

The onboarding flow introduces users to the application's main concept and features.

<p align="center">
  <img src="images/Onboarding%20%E2%80%93%20Welcome.png" width="200"/>
  <img src="images/Onboarding%20%E2%80%93%20Get%20Active.png" width="200"/>
  <img src="images/Onboarding%20%E2%80%93%20Start%20Your%20Journey.png" width="200"/>
  <img src="images/Onboarding%20%E2%80%93%20Join%20the%20Community.png" width="200"/>
</p>

---

### ⚙️ Settings Screen

Users can manage their profile information, language preferences, dark mode, and account settings.

<p align="center">
  <img src="images/Settings%20Screen.png" width="260"/>
</p>

## 🏗️ Project Structure

```text
lib/
├── Homepage/
│   ├── home_screen.dart
│   ├── plans_page.dart
│   ├── log_page.dart
│   └── settings_page.dart
│
├── User information/
│   └── User profile and authentication functionality
│
├── Onboarding/
│   └── Onboarding screens
│
├── Login pages/
│   └── Login and registration screens
│
└── main.dart
```

## 🔐 Backend & Security

FitBody uses:

* **Supabase Authentication** for user registration, login, and session management.
* **Firebase Firestore** for storing and retrieving user-related information.

Sensitive credentials and private backend keys should **not** be committed to the repository.

Backend secrets are intentionally excluded from the public source code.

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio
* Android Emulator or a physical Android device
* Git

### Clone the Repository

```bash
git clone https://github.com/J4NA-tech/Fitbody-App.git
```

### Navigate to the Project

```bash
cd Fitbody-App
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

```bash
flutter run
```

## 🎓 Academic Project

**Project:** Mobile Fitness Application
**Developer:** Jana El Samra
**Department:** Computer Engineering
**Faculty:** Faculty of Engineering and Natural Sciences
**Semester:** Spring 2025

**Project Supervisor:** Dr. Öğr. Perihan Pehlivanoğlu

## 🔮 Future Improvements

Possible future improvements include:

* 🤖 AI-powered personalized workout recommendations
* 🥗 Diet and nutrition tracking
* 😴 Sleep tracking
* 📈 Advanced performance analytics
* 🧠 AI-based motivational and behavioral analysis
* 📱 Improved cross-platform support

## 📄 Project Background

FitBody was developed as a graduation project with the goal of creating a simple, modern, and personalized digital fitness experience.

The project covers mobile application development, UI/UX design, authentication, cloud database integration, user data management, and workout progress tracking.

## 📌 Disclaimer

This project was developed for educational and portfolio purposes as part of a Computer Engineering graduation project.

# FitBody – Mobile Fitness Application

<p align="center">
  <strong>A personalized mobile fitness application built with Flutter</strong>
</p>

<p align="center">
  <img src="images/fitbody_logo.png" alt="FitBody Logo" width="120"/>
</p>

## 📱 About the Project

**FitBody** is a mobile fitness application developed as a Computer Engineering graduation project.

The application helps users discover workout plans based on their fitness goals and experience levels, track completed workouts, monitor their progress, and access motivational fitness content.

The project focuses on providing a **clean, modern, and user-friendly mobile experience** while integrating cloud-based authentication and data storage.

---

## ✨ Features

* 🔐 **User Authentication**

  * User registration and login
  * Session management
  * Password recovery

* 👤 **User Profile**

  * Personal information management
  * Fitness goal selection
  * Activity level selection

* 🏋️ **Workout Plans**

  * Beginner, Intermediate, and Advanced levels
  * Strength, Endurance, and Flexibility categories
  * Workout details and exercise videos

* 📊 **Workout History & Progress**

  * Completed workout tracking
  * Workout duration
  * Estimated calories burned
  * Completed exercise statistics

* 📰 **Fitness & Motivational Content**

  * Daily workout recommendations
  * Motivational messages
  * Fitness-related articles

* ⚙️ **Settings**

  * Profile information
  * Language preferences
  * Dark mode
  * Logout functionality

---

## 🛠️ Tech Stack

| Technology             | Purpose                                       |
| ---------------------- | --------------------------------------------- |
| **Flutter**            | Cross-platform mobile application development |
| **Dart**               | Application programming language              |
| **Supabase**           | Authentication and user session management    |
| **Firebase Firestore** | Cloud data storage                            |
| **Android Studio**     | Development environment                       |
| **Git & GitHub**       | Version control and source code management    |

---

## 🏗️ Application Architecture

The application follows a modular structure where UI screens and functionality are organized into separate components.

### Main Layers

**Presentation / UI Layer**

* Login and registration screens
* Onboarding screens
* Home screen
* Workout plans
* Workout history
* Settings

**Authentication Layer**

* Supabase Authentication
* User registration
* User login
* Session management
* Password recovery

**Data Layer**

* Firebase Firestore
* User profile data
* Workout history
* Application-related data

### Simplified Architecture

```text
┌─────────────────────────────┐
│       Flutter Application   │
│                             │
│  UI / Screens / Navigation  │
└──────────────┬──────────────┘
               │
       ┌───────┴────────┐
       │                │
       ▼                ▼
┌──────────────┐  ┌───────────────┐
│   Supabase   │  │    Firebase   │
│              │  │   Firestore   │
│ Authentication│  │               │
│ & Sessions   │  │ User Data     │
└──────────────┘  └───────────────┘
```

---

# 📸 Screenshots

## Onboarding

<p align="center">
  <img src="images/onboarding1.png" width="220"/>
  <img src="images/onboarding2.png" width="220"/>
  <img src="images/onboarding3.png" width="220"/>
  <img src="images/onboarding4.png" width="220"/>
</p>

## Authentication

<p align="center">
  <img src="images/login.png" width="250"/>
</p>

Users can securely register and log in using their email and password.

## Home Screen

<p align="center">
  <img src="images/home.png" width="250"/>
</p>

The home screen provides workout recommendations, motivational content, and fitness-related articles.

## Workout Plans

<p align="center">
  <img src="images/workout_plans.png" width="250"/>
</p>

Users can browse workout plans according to their experience level and fitness goals.

## Progress & Workout History

<p align="center">
  <img src="images/progress.png" width="250"/>
</p>

Users can review completed workouts and track their overall workout progress.

## Settings

<p align="center">
  <img src="images/settings.png" width="250"/>
</p>

The settings page allows users to manage their profile, preferences, and account session.

> **Note:** Replace the image filenames above with the actual filenames inside the project's `images/` directory.

---

# 📁 Project Structure

```text
fitbodys/
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
├── images/
│
├── lib/
│   ├── Homepages/
│   ├── User information/
│   ├── Onboarding/
│   ├── Login pages/
│   └── main.dart
│
├── test/
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

---

# 🚀 Getting Started

## Prerequisites

Make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio
* Android Emulator or a physical Android device

## Installation

Clone the repository:

```bash
git clone https://github.com/J4NA-tech/Fitbody-App.git
```

Navigate to the project directory:

```bash
cd Fitbody-App
```

Install the dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

# 🔐 Backend Configuration

The application uses **Supabase** for authentication and **Firebase Firestore** for cloud data storage.

For security reasons, private credentials and service-level keys should **not** be committed to the repository.

Before running the application, configure your own backend credentials according to the project's configuration.

> Never expose Supabase `service_role` keys, database passwords, private API keys, or other server-side credentials in source control.

---

# 🔮 Future Improvements

Possible future improvements include:

* 🤖 AI-powered personalized workout recommendations
* 🥗 Nutrition and diet tracking
* 😴 Sleep tracking
* 📈 More advanced progress analytics
* 🔔 Workout reminders and notifications
* 👥 Social/community features
* 🎯 More advanced personalization based on workout history

These features represent potential future extensions of the current application.

---

# 🎓 Academic Project

This application was developed as a **Computer Engineering Graduation Project** in 2025.

The project focuses on mobile application development, cloud-based authentication, data management, and user-centered interface design.

---

# 👩‍💻 Author

**Jana El Samra**

Computer Engineering

GitHub:
https://github.com/J4NA-tech

---

## 📄 License

This project was developed for educational and portfolio purposes.


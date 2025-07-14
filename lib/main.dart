import 'package:firebase_core/firebase_core.dart';
import 'package:fitbodys/homepage/HomeScreen.dart';
import 'package:fitbodys/homepage/log_page.dart';
import 'package:fitbodys/homepage/plans_page.dart';
import 'package:fitbodys/homepage/settings_page.dart';
import 'package:fitbodys/login_pages/login_screen.dart';
import 'package:fitbodys/login_pages/reset_password_screen.dart';
import 'package:fitbodys/login_pages/signup.dart';
import 'package:fitbodys/onboarding/Onboarding_page1.dart';
import 'package:fitbodys/onboarding/Onboarding_page2.dart';
import 'package:fitbodys/onboarding/Onboarding_page3.dart';
import 'package:fitbodys/onboarding/Onboarding_page4.dart';
import 'package:fitbodys/user_informations/Agepage.dart';
import 'package:fitbodys/user_informations/DatabasePage.dart';
import 'package:fitbodys/user_informations/OnboardingStartPage.dart';
import 'package:fitbodys/user_informations/activity_level_page.dart';
import 'package:fitbodys/user_informations/gender_page.dart';
import 'package:fitbodys/user_informations/goal_page.dart';
import 'package:fitbodys/user_informations/profilepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'LaunchScreen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pczwiyvaredxclyglyrs.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBjendpeXZhcmVkeGNseWdseXJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkwNjA0NzEsImV4cCI6MjA1NDYzNjQ3MX0.1cIqXVNHGis4nNUhbccsWPgfYqkPzISfsI_meaHJVgs',

  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitBody',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LaunchScreen(),
        '/onboarding1': (context) => OnboardingPage1(),
        '/onboarding2': (context) => OnboardingPage2(),
        '/onboarding3': (context) => OnboardingPage3(),
        '/onboarding4': (context) => OnboardingPage4(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ResetPasswordScreen(),
        '/onboarding-start': (context) => OnboardingStartPage(),
        '/gender': (context) => GenderPage(),
        '/age': (context) => AgePage(),
        '/goal': (context) => GoalPage(),
        '/activity-level': (context) => ActivityLevelPage(),
        '/profile': (context) => ProfilePage(),
        '/home': (context) => HomeScreen(),
        '/log': (context) => LogPage(),
        '/plans': (context) =>  PlansPage(),
        '/settings': (context) => const SettingsPage(),

      },
      // '/database' rotası için özel yönlendirme
      onGenerateRoute: (settings) {
        if (settings.name == '/database') {
          return MaterialPageRoute(
            builder: (context) => FutureBuilder(
              future: _fetchUserData(),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(body: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError) {
                  return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
                }
                final userData = snapshot.data!;
                return DatabasePage(
                  fullName: userData['full_name'],
                  gender: userData['gender'],
                  age: userData['age'],
                  goal: userData['goal'],
                  activityLevel: userData['activity_level'],
                );
              },
            ),
          );
        }
        return null;
      },
    );
  }
// Supabase'ten kullanıcı verilerini çekmek için
  Future<Map<String, dynamic>> _fetchUserData() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser!;

    final response = await supabase
        .from('users')
        .select('full_name, gender, age, goal, activity_level')
        .eq('id', user.id)
        .maybeSingle();

    return response ?? {
      'full_name': 'New User',
      'gender': '',
      'age': '',
      'goal': '',
      'activity_level': ''
    };
  }

}


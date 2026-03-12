import 'package:flutter/material.dart';
import 'package:towh/core/storage/app_preferences.dart';
import 'package:towh/features/onboarding/screens/onboarding_screen.dart';
import 'package:towh/core/storage/local_database.dart';
import 'package:towh/features/home/screens/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.instance.init();
  await AppPreferences.instance.init();
  runApp(
    MyApp(hasSeenOnboarding: AppPreferences.instance.hasSeenOnboarding),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.hasSeenOnboarding});

  final bool hasSeenOnboarding;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: AppBarTheme(centerTitle: false)),
      home: hasSeenOnboarding ? const HomeView() : const OnboardingScreen(),
    );
  }
}

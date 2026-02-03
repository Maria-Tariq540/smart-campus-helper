import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app_design.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Firebase.initializeApp() will need configuration files 
  // (google-services.json / GoogleService-Info.plist) to work.
  // I will wrap it in a try-catch for now to allow initial UI development.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase not initialized yet: $e');
  }
  
  runApp(
    const ProviderScope(
      child: SmartCampusApp(),
    ),
  );
}

class SmartCampusApp extends ConsumerWidget {
  const SmartCampusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Smart Campus Helper',
      debugShowCheckedModeBanner: false,
      theme: AppDesign.darkTheme, // Defaulting to the elegant dark theme
      darkTheme: AppDesign.darkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}

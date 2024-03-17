import 'package:fb_test/pages/Settings.dart';
import 'package:flutter/material.dart';
import 'package:fb_test/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/settings': (context) => SettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

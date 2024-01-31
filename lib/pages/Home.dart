import 'package:fb_test/pages/Sommeil.dart';
import 'package:fb_test/pages/Training.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fb_test/pages/Nutrition.dart';
import 'package:fb_test/pages/Settings.dart';
import 'package:fb_test/pages/Accueil.dart';

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class Home extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        Accueil(),
        NutritionScreen(),
        TrainingScreen(),
        SommeilScreen(),
        SettingsScreen(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Nutrition',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_volleyball),
            label: 'Training',
          ),
          NavigationDestination(icon: Icon(Icons.bed), label: 'Sommeil'),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

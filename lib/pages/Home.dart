import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fb_test/pages/Sommeil.dart';
import 'package:fb_test/pages/Training.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.transparent,
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        activeColor: Colors.black,
        inactiveColor: Colors.black,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.sportscourt,
            ),
            label: 'Training',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
            ),
            label: 'Nutrition',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bed_double,
            ),
            label: 'Sommeil',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings,
            ),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return [
          TrainingScreen(),
          const NutritionScreen(),
          const Accueil(),
          SommeilScreen(),
          const SettingsScreen(),
        ][index];
      },
    );
  }
}

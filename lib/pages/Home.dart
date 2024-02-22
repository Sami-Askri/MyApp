import 'package:cloud_firestore/cloud_firestore.dart';
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
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              color: currentPageIndex == 0 ? Colors.black : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
              color: currentPageIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.sportscourt,
              color: currentPageIndex == 2 ? Colors.black : Colors.grey,
            ),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bed_double,
              color: currentPageIndex == 3 ? Colors.black : Colors.grey,
            ),
            label: 'Sommeil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings,
              color: currentPageIndex == 4 ? Colors.black : Colors.grey,
            ),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return [
          Accueil(),
          NutritionScreen(),
          TrainingScreen(),
          SommeilScreen(),
          SettingsScreen(),
        ][index];
      },
    );
  }
}

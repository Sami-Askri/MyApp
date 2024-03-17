import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_test/pages/Settings/Data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fb_test/pages/Home.dart';
import 'package:fb_test/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            // User is signed in, check if user data exists in Firestore
            print('User is signed in.');
            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (userSnapshot.hasData && userSnapshot.data!.exists) {
                  print(
                      'User data exists and is not empty, navigating to Home.');
                  return Home();
                } else {
                  print(
                      'User data does not exist or is empty, navigating to DataScreen.');
                  return DataScreen();
                }
              },
            );
          } else {
            // User is not signed in, navigate to login page
            print('User is not signed in, navigating to LoginPage.');
            return LoginPage();
          }
        },
      ),
    );
  }
}

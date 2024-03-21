import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserData?> getUserData() async {
    User? user = _auth.currentUser;

    try {
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        print('User Snapshot: $userSnapshot');

        if (userSnapshot.exists) {
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          print('User Data: $userData');

          if (userData != null &&
              userData.containsKey('Username') &&
              userData.containsKey('DateOfBirth') &&
              userData.containsKey('Height') &&
              userData.containsKey('Weight') &&
              userData.containsKey('Goal Weight') &&
              userData.containsKey('Data') &&
              userData.containsKey('Gender') &&
              userData.containsKey('Objectif') &&
              userData.containsKey('nb_sech')) {
            // Calcul de l'âge
            int age =
                calculateAge(userData['DateOfBirth']?.toDate() as DateTime?);

            return UserData(
              Username: userData['Username'] as String?,
              DateOfBirth: userData['DateOfBirth']?.toDate() as DateTime?,
              Height: userData['Height'] as double?,
              Weight: userData['Weight'] as int?,
              goalWeight: userData['Goal Weight'] as int?,
              sleepData: userData['Data'] as String?,
              Gender: userData['Gender'] as String?,
              Age: age,
              Objectif: userData['Objectif'] as String?,
              nb_sech: userData['nb_sech'] as int?,
            );
          }
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des données utilisateur: $e');
    }

    return null;
  }

  // Fonction pour calculer l'âge à partir de la date de naissance
  int calculateAge(DateTime? DateOfBirth) {
    if (DateOfBirth == null) {
      return 0;
    }

    DateTime currentDate = DateTime.now();
    int Age = currentDate.year - DateOfBirth.year;

    if (currentDate.month < DateOfBirth.month ||
        (currentDate.month == DateOfBirth.month &&
            currentDate.day < DateOfBirth.day)) {
      Age--;
    }

    return Age;
  }
}

// Classe pour stocker les données utilisateur
class UserData {
  final String? Username;
  final DateTime? DateOfBirth;
  final double? Height;
  final int? Weight;
  final int? goalWeight;
  final String? sleepData;
  final String? Gender;
  final int? Age;
  final String? Objectif;
  final int? nb_sech;

  UserData({
    this.Username,
    this.DateOfBirth,
    this.Height,
    this.Weight,
    this.goalWeight,
    this.sleepData,
    this.Gender,
    this.Age,
    this.Objectif,
    this.nb_sech,
  });
}

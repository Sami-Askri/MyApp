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

          // Vérifiez que les données essentielles sont présentes avant de créer l'instance UserData
          if (userData != null &&
              userData.containsKey('Username') &&
              userData.containsKey('DateOfBirth') &&
              userData.containsKey('Weight') &&
              userData.containsKey('Gender')) {
            return UserData(
              Username: userData['Username'] as String?,
              DateOfBirth: userData['DateOfBirth']?.toDate() as DateTime?,
              Weight: userData['Weight'] as int?,
              Gender: userData['Gender'] as String?,
            );
          }
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des données utilisateur: $e');
      // Gérez l'erreur selon vos besoins
    }

    return null;
  }
}

// Classe pour stocker les données utilisateur
class UserData {
  final String? Username;
  final DateTime? DateOfBirth;
  final int? Weight;
  final String? Gender;

  UserData({this.Username, this.DateOfBirth, this.Weight, this.Gender});
}

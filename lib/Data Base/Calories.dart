import 'package:fb_test/Data%20Base/Data_collector.dart';

class CalorieCalculator {
  static Future<void> calculateCalories() async {
    try {
      UserData? userData = await UserService().getUserData();

      if (userData != null) {
        String? username = userData.Username;
        double height = userData.Height!.toDouble();
        String? gender = userData.Gender;
        int? weight = userData.Weight?.toInt();
        int? goalWeight = userData.goalWeight?.toInt();
        int? age = userData.Age?.toInt();
        String? objectif = userData.Objectif;

        if (age != null) {
          double calculatedCalories = calories(
              calories_maintien(weight, height, age, gender), objectif);
          print('Calculated Calories: $calculatedCalories');
        } else {
          print('La date de naissance est nulle.');
        }
      } else {
        print('Les données utilisateur sont nulles.');
      }
    } catch (e) {
      print('Une erreur s\'est produite : $e');
    }
  }

  static double calories_maintien(
      int? weight, double height, int age, String? gender) {
    if (gender == 'Male') {
      // Formule pour les hommes
      return (1.375 *
          ((13.7516 * weight! + 500.33 * height - 6.7550 * age) + 66.479));
    } else if (gender == 'Female') {
      // Formule pour les femmes (ajustez cela en fonction de vos besoins)
      return (1.375 *
          ((9.740 * weight! + 184.96 * height - 4.6756 * age) + 655.0955));
    } else {
      print('Genre non reconnu');
      return 0.0;
    }
  }

  static double calories(double calories_maintien, String? objectif) {
    if (objectif == "Remise_frm") {
      return calories_maintien;
    } else if (objectif == "Pdm") {
      return calories_maintien + 250;
    } else if (objectif == "Sch") {
      return calories_maintien - 250;
    } else {
      return 0.0;
    }
  }
}

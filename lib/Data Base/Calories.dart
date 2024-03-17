import 'package:fb_test/Data%20Base/Data_collector.dart';

class CalorieCalculator {
  static Future<double> calculateCalories() async {
    try {
      UserData? userData = await UserService().getUserData();

      if (userData != null) {
        double height = userData.Height!.toDouble();
        String? gender = userData.Gender;
        int? weight = userData.Weight?.toInt();
        int? age = userData.Age?.toInt();
        String? objectif = userData.Objectif;

        if (age != null) {
          double calculatedCalories =
              caloriesMaintenance(weight, height, age, gender);
          double adjustedCalories =
              calculateAdjustedCalories(calculatedCalories, objectif);
          return adjustedCalories;
        } else {
          throw Exception('La date de naissance est nulle.');
        }
      } else {
        throw Exception('Les données utilisateur sont nulles.');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite : $e');
    }
  }

  static double caloriesMaintenance(
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
      throw Exception('Genre non reconnu');
    }
  }

  static double calculateAdjustedCalories(
      double caloriesMaintenance, String? objectif) {
    if (objectif == "Remise_frm") {
      return caloriesMaintenance;
    } else if (objectif == "Pdm") {
      return caloriesMaintenance + 250;
    } else if (objectif == "Sch") {
      return caloriesMaintenance - 250;
    } else {
      return 0.0;
    }
  }
}

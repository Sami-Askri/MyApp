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

        // récupération de la date de naissance
        DateTime? dateOfBirth = userData.DateOfBirth;

        if (dateOfBirth != null) {
          // calcul de calories
          double calculatedCalories =
              calculateCaloriesForUser(weight, height, dateOfBirth);
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

  static double calculateCaloriesForUser(
      int? weight, double height, DateTime dateOfBirth) {
    int age = DateTime.now().year - dateOfBirth.year;
    return (1.375 *
        ((13.7516 * weight! + 500.33 * height - 6.7550 * age) + 66.479));
  }
}

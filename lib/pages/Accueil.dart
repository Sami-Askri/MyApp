import 'package:fb_test/Data%20Base/Calories.dart';
import 'package:fb_test/Data%20Base/Data_collector.dart';
import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double weight;
  final double goalWeight;

  const ProgressCircle({
    required this.weight,
    required this.goalWeight,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (weight / goalWeight).clamp(0.0, 5.0);
    return Column(
      children: [
        const SizedBox(height: 30),
        Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              strokeWidth: 100,
              color: Colors.grey[500],
              backgroundColor: Colors.grey[200],
            ),
            Text(
              '${(progress * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  late double calculatedCalories;

  @override
  void initState() {
    super.initState();
    fetchCalories();
  }

  void fetchCalories() async {
    calculatedCalories = await CalorieCalculator.calculateCalories();
    setState(
        () {}); // Mettre à jour l'interface après avoir récupéré les données
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder<UserData?>(
        future: UserService().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            UserData? userData = snapshot.data;
            String username = userData?.Username ?? '';
            int weight = userData?.Weight?.toInt() ?? 0;
            int goalWeight = userData?.goalWeight?.toInt() ?? 0;
            int age = userData?.Age ?? 0;
            String objectif = userData?.Objectif ?? '';

            // Contrôle de l'affichage de l'objectif en fonction de conditions
            Widget objectifWidget;
            if (objectif == 'Remise_frm') {
              objectifWidget = Text(
                'Objectif: Remise en forme',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            } else if (objectif == 'Pdm') {
              objectifWidget = Text(
                'Objectif: Prise de masse',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            } else if (objectif == 'Sch') {
              objectifWidget = Text(
                'Objectif: Sèche',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            } else {
              objectifWidget = Text(
                'Objectif inconnu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }

            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Bienvenue $username',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  height: 15,
                                  thickness: 2,
                                ),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Poids actuel:  $weight kg ',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      objectifWidget,
                                      const SizedBox(height: 5),
                                      Text(
                                        'Poids objectif: $goalWeight kg',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Age: $age',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Besoin calorique journalier: ${calculatedCalories.toStringAsFixed(2)} kcal',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        'Progression',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      ProgressCircle(
                                        weight: weight.toDouble(),
                                        goalWeight: goalWeight.toDouble(),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

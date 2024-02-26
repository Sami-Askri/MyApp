// ignore_for_file: prefer_const_constructors

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
        const Text(
          'Weight Progress',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 70),
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

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: FutureBuilder<UserData?>(
          future: UserService().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              UserData? userData = snapshot.data;
              String username = userData?.Username ?? '';
              int weight = userData?.Weight?.toInt() ?? 0;
              int goalWeight = userData?.goalWeight?.toInt() ?? 0;
              int age = userData?.Age ?? 0;

              return Stack(
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
                  Column(
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
                              'Welcome Back $username',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 15,
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    'Current Weight:  $weight kg ',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Main Activity: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Goal Weight: $goalWeight kg',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Age: $age',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await CalorieCalculator
                                          .calculateCalories();
                                    },
                                    child: const Text('Calories'),
                                  ),
                                  const SizedBox(height: 20),
                                  ProgressCircle(
                                    weight: weight.toDouble(),
                                    goalWeight: goalWeight.toDouble(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

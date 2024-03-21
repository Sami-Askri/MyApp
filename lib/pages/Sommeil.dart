import 'package:flutter/material.dart';
import 'package:fb_test/Data%20Base/Data_collector.dart';
import 'package:fb_test/graph.dart';

class SommeilScreen extends StatelessWidget {
  static String routeName = "/sommeil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserData?>(
        future: UserService().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            UserData? userData = snapshot.data;
            String sleepData = userData?.sleepData ?? '';

            // Analyser les données de sommeil
            Map<String, double> sleepHours = {};
            RegExp regExp = RegExp(r'"(\d+)":\s*([\d.]+)');
            Iterable<Match> matches = regExp.allMatches(sleepData);
            for (Match match in matches) {
              int seconds = int.parse(match.group(1)!);
              double duration = double.parse(match.group(2)!);
              sleepHours[seconds.toString()] = duration;
            }

            // Maintenant que vous avez récupéré sleepData, analysé les données et créé le map,
            // vous pouvez afficher le widget
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        'Analyse de Sommeil',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                          child: BarChartWidget(
                            data: sleepHours,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            // Affichez un indicateur de chargement si les données ne sont pas encore disponibles
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

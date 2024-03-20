import 'package:fb_test/graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SommeilScreen extends StatelessWidget {
  static String routeName = "/sommeil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    child: const BarChartWidget(
                      data: {
                        "500": 2.3,
                        "1204": 1.8,
                        "2000": 2.65,
                        "2001": 3.2,
                        "3000": 1.5,
                        "12568": 2
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

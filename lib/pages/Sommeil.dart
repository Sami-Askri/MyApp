import 'package:flutter/material.dart';

class SommeilScreen extends StatelessWidget {
  static String routeName = "/sommeil";

  @override
  Widget build(BuildContext context) {
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
                    'Sommeil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 15,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(
                'lib/images/courbe.png',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

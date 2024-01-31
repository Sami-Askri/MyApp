import 'package:flutter/material.dart';

class SommeilScreen extends StatelessWidget {
  static String routeName = "/sommeil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sommeil'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Interface de Sommeil',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

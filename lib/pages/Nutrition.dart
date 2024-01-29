import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  static String routeName = "/nutrition";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Interface de Nutrition',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

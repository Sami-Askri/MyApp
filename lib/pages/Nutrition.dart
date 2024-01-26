import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NutritionScreen(),
    );
  }
}

class NutritionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition'),
      ),
      body: Container(
        // Tu peux personnaliser ce conteneur selon tes besoins
        alignment: Alignment.center,
        child: Text(
          'Interface de Nutrition',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

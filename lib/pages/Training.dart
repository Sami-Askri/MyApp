import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  static String routeName = "/Training";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Training',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

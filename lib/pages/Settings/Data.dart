import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  static String routeName = "/data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Interface de Data',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

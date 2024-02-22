import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_test/pages/Accueil.dart';
import 'package:fb_test/pages/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fb_test/components/text_Field.dart';

class DataScreen extends StatefulWidget {
  static String routeName = "/data";

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final usernameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final goalWeightController = TextEditingController();
  String selectedGender = '';
  DateTime? selectedDate;

  Future<void> addData(String username, double height, int weight,
      int goalWeight, String gender, DateTime? date, User? user) async {
    try {
      if (user != null) {
        var userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'Username': username.isNotEmpty ? username : userDoc['Username'],
            'Height': height != 0 ? height : userDoc['Height'],
            'Weight': weight != 0 ? weight : userDoc['Weight'],
            'Goal Weight':
                goalWeight != 0 ? goalWeight : userDoc['Goal Weight'],
            'Gender': gender.isNotEmpty ? gender : userDoc['Gender'],
            'DateOfBirth': date != null ? date : userDoc['DateOfBirth'],
          });

          // Afficher le popup de succès
          _showSuccessPopup(context);
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'Username': username.isNotEmpty ? username : '',
            'Height': height != 0 ? height : 0,
            'Weight': weight != 0 ? weight : 0,
            'Goal Weight': goalWeight != 0 ? goalWeight : 0,
            'Gender': gender.isNotEmpty ? gender : '',
            'DateOfBirth': date != null ? date : null,
          });

          // Afficher le popup de succès
          _showSuccessPopup(context);
        }
      } else {
        print(
            'Utilisateur non authentifié. Impossible de mettre à jour la donnée.');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour de la donnée : $e');
    }
  }

  Future<void> _showSuccessPopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Succès'),
          content: Text('Données mises à jour avec succès'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Text('Accueil'),
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Update your personal data!',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              SizedBox(height: 16.0),
              MyTextField(
                controller: heightController,
                hintText: 'Height (m)',
                obscureText: false,
              ),
              SizedBox(height: 16.0),
              MyTextField(
                controller: weightController,
                hintText: 'Weight (kg)',
                obscureText: false,
              ),
              SizedBox(height: 16.0),
              MyTextField(
                controller: goalWeightController,
                hintText: 'Goal Weight (kg)',
                obscureText: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  SizedBox(width: 5.0),
                  Container(
                    height: 40.0,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down_circle_outlined),
                      onSelected: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem<String>(
                          child: Text('Male'),
                          value: 'Male',
                        ),
                        const PopupMenuItem<String>(
                          child: Text('Female'),
                          value: 'Female',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Date of Birth: ',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  selectedDate != null
                      ? Text(
                          '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          style: TextStyle(fontSize: 17.0),
                        )
                      : Text(
                          'Not selected',
                          style: TextStyle(fontSize: 17.0),
                        ),
                  SizedBox(width: 5.0),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    },
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  addData(
                    usernameController.text,
                    double.tryParse(heightController.text) ?? 0,
                    int.tryParse(weightController.text) ?? 0,
                    int.tryParse(goalWeightController.text) ?? 0,
                    selectedGender,
                    selectedDate,
                    user,
                  );
                },
                child: Text('Save Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

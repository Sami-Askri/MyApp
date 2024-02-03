import 'package:cloud_firestore/cloud_firestore.dart';
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
  final weightController = TextEditingController();
  String selectedGender = '';
  DateTime? selectedDate;

  Future<void> addData(String username, int weight, String gender,
      DateTime? date, User? user) async {
    try {
      if (user != null) {
        // Vérifier si le document de l'utilisateur existe déjà
        var userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // Mettre à jour les données de l'utilisateur existant
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'Username': username.isNotEmpty ? username : userDoc['Username'],
            'Weight': weight != 0 ? weight : userDoc['Weight'],
            'Gender': gender.isNotEmpty ? gender : userDoc['Gender'],
            'DateOfBirth': date != null ? date : userDoc['DateOfBirth'],
          });
          print('Donnée mise à jour avec succès ');
        } else {
          // Créer un nouveau document pour le nouvel utilisateur
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'Username': username.isNotEmpty ? username : '',
            'Weight': weight != 0 ? weight : 0,
            'Gender': gender.isNotEmpty ? gender : '',
            'DateOfBirth': date != null ? date : null,
          });
          print('Nouvel utilisateur ajouté avec succès ');
        }
      } else {
        print(
            'Utilisateur non authentifié. Impossible de mettre à jour la donnée.');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour de la donnée : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Center(
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
                controller: weightController,
                hintText: 'Weight',
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
                    int.tryParse(weightController.text) ?? 0,
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

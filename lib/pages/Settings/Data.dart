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
  String Objectif = '';
  int nb_sech = 0;
  DateTime? selectedDate;

  Future<void> addData(
      String username,
      double height,
      int weight,
      int goalWeight,
      String gender,
      String Objectif,
      int nb_sech,
      DateTime? date,
      User? user) async {
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
            'Objectif': Objectif.isNotEmpty ? Objectif : userDoc['Objectif'],
            'nb_sech': nb_sech != 0 ? nb_sech : userDoc['nb_sech'],
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
            'Objectif': Objectif.isNotEmpty ? Objectif : '',
            'nb_sech': nb_sech != 0 ? nb_sech : 0,
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
          title: const Text('Succès'),
          content: const Text('Données mises à jour avec succès'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text('Accueil'),
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 50),
                    const Expanded(
                      child: Text(
                        'Données personnelles',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  height: 15,
                ),
                SizedBox(height: 20),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: heightController,
                  hintText: 'Height (m)',
                  obscureText: false,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: weightController,
                  hintText: 'Weight (kg)',
                  obscureText: false,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: goalWeightController,
                  hintText: 'Goal Weight (kg)',
                  obscureText: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Objectif',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                        onSelected: (value) {
                          setState(() {
                            Objectif = value;
                          });
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'Pdm',
                            child: Text('Prise de masse'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Sch',
                            child: Text('Sèche'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Pdp',
                            child: Text('Prise de poids'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Nombre de séances',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: PopupMenuButton<int>(
                        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                        onSelected: (value) {
                          setState(() {
                            nb_sech = value;
                          });
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<int>(
                            value: 1,
                            child: Text('1'),
                          ),
                          const PopupMenuItem<int>(
                            value: 2,
                            child: Text('2'),
                          ),
                          const PopupMenuItem<int>(
                            value: 3,
                            child: Text('3'),
                          ),
                          const PopupMenuItem<int>(
                            value: 4,
                            child: Text('4'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                        onSelected: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Date of Birth: ',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    selectedDate != null
                        ? Text(
                            '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                            style: const TextStyle(fontSize: 17.0),
                          )
                        : const Text(
                            'Not selected',
                            style: TextStyle(fontSize: 17.0),
                          ),
                    const SizedBox(width: 5.0),
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
                      child: const Text('Pick Date'),
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
                      Objectif,
                      nb_sech,
                      selectedDate,
                      user,
                    );
                  },
                  child: const Text('Save Data'),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

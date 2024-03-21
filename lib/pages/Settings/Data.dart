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
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final goalWeightController = TextEditingController();
  final sleepdataController = TextEditingController();
  String selectedGender = '';
  String Objectif = '';
  int nb_sech = 0;
  DateTime? selectedDate;

  Future<void> addData(
      String username,
      double height,
      int weight,
      int goalWeight,
      String sleepData,
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
            'Sleep Data': sleepData,
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
            'Data': sleepData,
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
        SingleChildScrollView(
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
                  hintText: "Nom d'utilisateur",
                  obscureText: false,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: heightController,
                  hintText: 'Taille (m)',
                  obscureText: false,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: weightController,
                  hintText: 'Poids actuel (kg)',
                  obscureText: false,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: goalWeightController,
                  hintText: 'Poids objectif',
                  obscureText: false,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: sleepdataController,
                  hintText: 'Données de sommeil',
                  obscureText: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Objectif',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                        iconColor: Colors.white,
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

                          //const PopupMenuItem<String>(
                          // value: 'Pdp',
                          // child: Text('Prise de poids'),
                          //),const PopupMenuItem<String>(
                          // value: 'Perte_pds',
                          // child: Text('Perte de poids'),
                          // ),
                          const PopupMenuItem<String>(
                            value: 'Remise_frm',
                            child: Text('Remise en forme'),
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
                      'Nombre de séances (par semaine)',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                        iconColor: Colors.white,
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
                          const PopupMenuItem<int>(
                            value: 5,
                            child: Text('5'),
                          ),
                          const PopupMenuItem<int>(
                            value: 6,
                            child: Text('6'),
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
                      'Sexe',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                        iconColor: Colors.white,
                        onSelected: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'Male',
                            child: Text('Mâle'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Female',
                            child: Text('Femelle'),
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
                      'Date de naissance: ',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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
                      child: const Text(
                        'Sélectionner une date',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    )
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
                      sleepdataController.text,
                      selectedGender,
                      Objectif,
                      nb_sech,
                      selectedDate,
                      user,
                    );
                  },
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

import 'package:fb_test/training/Prise%20de%20masse/1.dart';
import 'package:fb_test/training/Prise%20de%20masse/2.dart';
import 'package:fb_test/training/Prise%20de%20masse/3.dart';
import 'package:fb_test/training/Prise%20de%20masse/4.dart';
import 'package:fb_test/training/Prise%20de%20masse/5.dart';
import 'package:fb_test/training/Prise%20de%20masse/6.dart';
import 'package:fb_test/training/Remise%20en%20forme/1.dart';
import 'package:fb_test/training/Remise%20en%20forme/2.dart';
import 'package:fb_test/training/Remise%20en%20forme/3.dart';
import 'package:fb_test/training/Remise%20en%20forme/4.dart';
import 'package:fb_test/training/Remise%20en%20forme/5.dart';
import 'package:fb_test/training/Remise%20en%20forme/6.dart';
import 'package:flutter/material.dart';
import 'package:fb_test/Data%20Base/Data_collector.dart';

class CustomTrainingScreen extends StatelessWidget {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserData?>(
        future: _userService.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur de chargement des données');
          } else if (snapshot.hasData) {
            return buildInfoScreen(context, snapshot.data!);
          } else {
            return Text('Aucune donnée utilisateur disponible');
          }
        },
      ),
    );
  }

  Widget buildInfoScreen(BuildContext context, UserData userData) {
    if (userData.nb_sech != null && userData.Objectif == 'Remise_frm') {
      if (userData.nb_sech == 1) {
        return Remise_frm1();
      } else if (userData.nb_sech == 2) {
        return Remise_frm2();
      } else if (userData.nb_sech == 3) {
        return Remise_frm3();
      } else if (userData.nb_sech == 4) {
        return Remise_frm4();
      } else if (userData.nb_sech == 5) {
        return Remise_frm5();
      } else if (userData.nb_sech == 6) {
        return Remise_frm6();
      }
    } else if (userData.nb_sech != null && userData.Objectif == 'Pdm') {
      if (userData.nb_sech == 1) {
        return Pdm1();
      } else if (userData.nb_sech == 2) {
        return Pdm2();
      } else if (userData.nb_sech == 3) {
        return Pdm3();
      } else if (userData.nb_sech == 4) {
        return Pdm4();
      } else if (userData.nb_sech == 5) {
        return Pdm5();
      } else if (userData.nb_sech == 6) {
        return Pdm6();
      }
    }

    // Default case or return an empty container if needed
    return Container();
  }
}

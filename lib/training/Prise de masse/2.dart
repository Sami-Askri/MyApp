import 'package:flutter/material.dart';
import 'package:fb_test/Data%20Base/Data_collector.dart';

class Pdm2 extends StatelessWidget {
  static String routeName = "/Pdm2";

  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              FutureBuilder<UserData?>(
                future: _userService.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur de chargement des données');
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'La Prise de masse en ${snapshot.data!.nb_sech} séances par semaine est indisponible',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Text("Full Body"),
                                      SizedBox(height: 16.0),
                                      Text("------------------"),
                                      Image.asset(
                                        'lib/images/remise_frm 1.png',
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text("Séance n°1"),
                        ),
                      ],
                    );
                  } else {
                    return Text('Aucune donnée utilisateur disponible');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

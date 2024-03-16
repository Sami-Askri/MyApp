import 'package:flutter/material.dart';
import 'package:fb_test/Data%20Base/Data_collector.dart';

class Pdm4 extends StatelessWidget {
  static String routeName = "/Pdm4";

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
                          'Programme : Prise de masse en ${snapshot.data!.nb_sech} séances par semaine',
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
                                      Text("Push"),
                                      SizedBox(height: 16.0),
                                      Text("------------------"),
                                      Image.asset(
                                        'lib/images/pdm3 sch1.png',
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
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Text("Pull"),
                                      SizedBox(height: 16.0),
                                      Text("------------------"),
                                      Image.asset(
                                        'lib/images/pdm3 sch2.png',
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
                          child: Text("Séance n°2"),
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
                                      Text("Legs"),
                                      SizedBox(height: 16.0),
                                      Text("------------------"),
                                      Image.asset(
                                        'lib/images/pdm3 sch3.png',
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
                          child: Text("Séance n°3"),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Text("Arms"),
                                          SizedBox(height: 16.0),
                                          Text("------------------"),
                                          Image.asset(
                                            'lib/images/pdm4 sch41.png',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                              child: Text("Séance n°4"),
                            ),
                            SizedBox(width: 30),
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Text("chest & Back"),
                                          SizedBox(height: 16.0),
                                          Text("------------------"),
                                          Image.asset(
                                            'lib/images/pdm4 sch42.png',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                              child: Text("Séance n°4"),
                            ),
                          ],
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

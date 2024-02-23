// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Pdp extends StatelessWidget {
  static String routeName = "/pdp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Column(
            children: [
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
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
                        SizedBox(width: 75),
                        const Expanded(
                          child: Text(
                            'Prise de poids',
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
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Détails du repas"),
                        content: Text(
                          "150g de steak haché (environ 50g de protéines)\n\n320g de pommes de terre au four (environ 20g de glucides)\n\nRatatouille maison (mélange de courgettes, d'aubergines, de poivrons et de tomates) pour les fibres et les vitamines",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 15),
                        blurRadius: 20,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'lib/images/stk.webp',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'Steak haché avec pommes de terre au four et ratatouille',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

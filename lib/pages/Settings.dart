// ignore_for_file: prefer_const_constructors

import 'package:fb_test/pages/Settings/Data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Text at the top center
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // SettingsList
                Expanded(
                  child: Container(
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: SettingsList(
                        sections: [
                          SettingsSection(
                            title: Text('Common'),
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                leading: Icon(Icons.language),
                                title: Text('Language'),
                                value: Text('English'),
                              ),
                            ],
                          ),
                          SettingsSection(
                            title: Text('User'),
                            tiles: <SettingsTile>[
                              SettingsTile(
                                title: Text('Data'),
                                leading: Icon(Icons.data_saver_on_sharp),
                                onPressed: (BuildContext context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DataScreen()),
                                  );
                                },
                              ),
                              SettingsTile(
                                title: Text('Sign Out'),
                                leading: Icon(Icons.logout),
                                onPressed: (value) {
                                  signUserOut();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fb_test/pages/Settings/Data.dart';
import 'package:fb_test/pages/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        SettingsTile.switchTile(
                          onToggle: (value) {},
                          initialValue: true,
                          leading: Icon(Icons.format_paint),
                          title: Text('Enable custom theme'),
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: Text('User'),
                      tiles: <SettingsTile>[
                        SettingsTile(
                          title: Text('Sign Out'),
                          leading: Icon(Icons.logout),
                          onPressed: (value) {
                            signUserOut();
                          },
                        ),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:quraanproject/feedback/feedback.dart';
import 'package:quraanproject/screens/playlist/playlist_screen.dart';
import 'package:quraanproject/terms%20and%20policy/policy.dart';
    bool isSwitched = false;

class SettingsPage extends StatefulWidget {

  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    // bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "SETTINGS",
            style: TextStyle(fontFamily: "font4", fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: Column(children: [
            ListTile(
                leading: Icon(Icons.sunny),
                title: Text("Dark Mode"),
                trailing: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;

                         isSwitched
                             ? AdaptiveTheme.of(context).setDark()
                           : AdaptiveTheme.of(context).setLight();
                      });
                    })),
            ListTile(
              leading: Icon(Icons.playlist_add),
              title: Text("Playlist"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Playlist())));
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback_outlined),
              title: Text("Feddback"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => ContactPage())));
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Quran"),
              onTap: () {
                share();
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text(
                "Privacy Policy",
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(mdFileName: "privacy_policy.md");
                    });
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About Us"),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset("assets/quranlogoicon.jpg",
                        width: 30, height: 30),
                    applicationName: "Noble Quran App",
                    applicationVersion:
                        "Version 1.0.0\n\nCopyright © 2022-2023",
                    applicationLegalese: "Devoloped by Muhammad Malik ");
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 270),
              child: Text(
                "Version\n  1.0.0",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ])),
        ));
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'app share',
      linkUrl: 'https://quran.com/en',
    );
  }
}

Widget settingsIcon({required settingicon}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(settingicon),
      ],
    ),
  );
}

import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/user/alert_page.dart';
import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/screens/user/community_page.dart';
import 'package:disaster_safety/screens/user/raise_incident.dart';
import 'package:disaster_safety/screens/user/settings_page.dart';
import 'package:disaster_safety/screens/user/tips_page.dart';
import 'package:disaster_safety/screens/user/updates_page.dart';
import 'package:disaster_safety/services/auth.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<Widget> pages = const [
    RaiseIncidentPage(
      latitude: 0,
      longitude: 0,
    ),
    CommunityPage(),
    AlertPage(),
    TipsPage(),
    UpdatesPage(),
    SettingsPage()
  ];

  List<String> pagetitle = [
    "Raise Incident",
    "Community",
    "Alerts",
    "Tips",
    "Updates",
    "Settings"
  ];

  List<IconData> pageIcons = [
    Icons.new_label,
    Icons.group_add,
    Icons.warning_outlined,
    Icons.tips_and_updates,
    Icons.update,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    // Provider.of(context).
    // String username =  SecureStorage().getUserId();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome Admin"),
          actions: [
            IconButton(
              onPressed: () async {
                await context.read<AuthMethods>().signOut();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(pages.length, (index) {
                return PageBtn(
                    title: pagetitle[index],
                    icon: pageIcons[index],
                    onpress: () {
                      Routes.push(context, pages[index]);
                    },
                    index: index);
              })),
        ));
  }
}

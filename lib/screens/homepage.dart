import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/alert_page.dart';
import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/screens/community_page.dart';
import 'package:disaster_safety/screens/raise_incident.dart';
import 'package:disaster_safety/screens/settings_page.dart';
import 'package:disaster_safety/screens/tips_page.dart';
import 'package:disaster_safety/services/auth.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Widget> pages = const [
    RaiseIncidentPage(),
    CommunityPage(),
    AlertPage(),
    TipsPage(),
    SettingsPage()
  ];

  List<String> pagetitle = [
    "Raise Incident",
    "Community",
    "Alerts",
    "Tips",
    "Settings"
  ];

  List<IconData> pageIcons = [
    Icons.new_label,
    Icons.group_add,
    Icons.warning_outlined,
    Icons.tips_and_updates,
    Icons.settings,
  ];
  @override
  Widget build(BuildContext context) {
    // Provider.of(context).
    // String username =  SecureStorage().getUserId();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome "),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthMethods>().signOut();
              // Routes.pushReplace(context, )
              // Navigator.of(context).popUntil((route) )
              // Navigator.of(context).popUntil((route) => MaterialPageRoute)
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
              // String? userid = await SecureStorage().getUserId();
              // print(userid);
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
                  onpress: () {},
                  index: index);
            })),
      ),
    );
  }
}

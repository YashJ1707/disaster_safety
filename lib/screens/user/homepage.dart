import 'package:disaster_safety/models/user_model.dart';
import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/user/HelpDesk.dart';
import 'package:disaster_safety/screens/user/alert_page.dart';
import 'package:disaster_safety/screens/user/settings_page.dart';
import 'package:disaster_safety/screens/user/tips_page.dart';
import 'package:disaster_safety/screens/user/updates_page.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/maps/complete_maps_screen.dart';
import 'package:disaster_safety/services/maps/register_disaster_screen.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserModel user;

  List<Widget> pages = [
    RegisterDisasterScreen(),
    MapsScreen(),
    AlertPage(),
    TipsPage(),
    UpdatesPage(),
    SettingsPage(),
    HelpDesk(),
  ];

  List<String> pagetitle = [
    "Register Disaster",
    "View Map",
    "Alerts",
    "Tips",
    "Updates",
    "Settings",
    "Help Desk"
  ];

  List<IconData> pageIcons = [
    Icons.new_label,
    Icons.map,
    Icons.warning_outlined,
    Icons.tips_and_updates,
    Icons.update,
    Icons.settings,
    Icons.call,
  ];
  bool loading = true;
  @override
  void initState() {
    super.initState();

    DbMethods().loadUserData().then(
          (value) => setState(
            () {
              user = value!;
              loading = false;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of(context).
    // String username =  SecureStorage().getUserId();
    print(loading);
    return loading == true
        ? Scaffold(body: Loadings.staticLoader())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Welcome ${user.name}",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
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

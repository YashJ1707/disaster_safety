import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/dept/add_alert.dart';
import 'package:disaster_safety/screens/dept/check_status.dart';
import 'package:disaster_safety/screens/dept/pending_requests.dart';
import 'package:disaster_safety/screens/dept/reports.dart';
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

class DeptHome extends StatefulWidget {
  DeptHome({super.key});

  @override
  State<DeptHome> createState() => _DeptHomeState();
}

class _DeptHomeState extends State<DeptHome> {
  List<Widget> pages = [
    AddAlerts(),
    PendingRequests(),
    StatusPage(),
    ReportsPage(),
  ];
  List<String> pagetitle = [
    "Add Alert",
    "Pending Request",
    "Status Page",
    "Reports",
  ];

  List<IconData> pageIcons = [
    Icons.edit_calendar_rounded,
    Icons.pending_actions_rounded,
    Icons.update_sharp,
    Icons.file_copy
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome "),
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
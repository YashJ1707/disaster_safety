import 'package:disaster_safety/core/router.dart';
import 'package:disaster_safety/screens/dept/active_incidents.dart';
import 'package:disaster_safety/screens/dept/add_alert.dart';
import 'package:disaster_safety/screens/dept/check_status.dart';
import 'package:disaster_safety/screens/dept/pending_requests.dart';
import 'package:disaster_safety/screens/dept/reports.dart';
import 'package:disaster_safety/screens/user/alert_page.dart';
import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/services/auth.dart';
import 'package:disaster_safety/services/maps/complete_maps_screen.dart';
import 'package:disaster_safety/services/maps/register_disaster_screen.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeptHome extends StatefulWidget {
  const DeptHome({super.key});

  @override
  State<DeptHome> createState() => _DeptHomeState();
}

class _DeptHomeState extends State<DeptHome> {
  List<Widget> pages = [
    const RegisterDisasterScreen(),
    const AddAlerts(),
    const MapsScreen(),
    const AlertPage(),
    const PendingRequests(),
    const ActiveIncidents(),
    const StatusPage(),
    const ReportsPage(),
  ];
  List<String> pagetitle = [
    "Register Disaster",
    "Add Alert",
    "Show Map",
    "Alerts",
    "Approve Requests",
    "All Incidets",
    "Status Page",
    "Reports",
  ];

  List<IconData> pageIcons = [
    Icons.new_label,
    Icons.edit_calendar_rounded,
    Icons.map,
    Icons.warning,
    Icons.pending_actions_rounded,
    Icons.ads_click,
    Icons.update_sharp,
    Icons.file_copy
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome Admin"),
          actions: [
            IconButton(
              onPressed: () async {
                await context.read<AuthMethods>().signOut();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
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

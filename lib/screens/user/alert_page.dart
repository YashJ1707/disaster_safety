import 'package:disaster_safety/services/maps/maps_screen.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alerts "),
        leading: Icon(Icons.warning),
      ),
      // body: SingleChildScrollView(
      //     child: SafeArea(
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      //     child: Column(children: []),
      //   ),
      // )),
      body: MapsScreen(),
    );
  }
}

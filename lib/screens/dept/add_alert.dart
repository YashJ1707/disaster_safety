import 'package:flutter/material.dart';

class AddAlerts extends StatelessWidget {
  const AddAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Alert "),
        leading: Icon(Icons.settings),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(children: []),
        ),
      )),
    );
  }
}

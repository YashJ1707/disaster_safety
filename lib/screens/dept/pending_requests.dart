import 'package:flutter/material.dart';

class PendingRequests extends StatelessWidget {
  const PendingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Approvals"),
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

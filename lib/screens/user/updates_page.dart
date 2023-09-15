import 'package:flutter/material.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Updates"),
        leading: Icon(Icons.update_sharp),
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

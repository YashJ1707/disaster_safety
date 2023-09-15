import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tips"),
        leading: Icon(Icons.tips_and_updates),
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

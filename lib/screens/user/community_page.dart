import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
        leading: Icon(Icons.group_add),
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

import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/text_styles.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings "),
        leading: Icon(Icons.settings),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Container(
            width: width * 0.8,
            child: Column(children: [
              profile_row("Name", "Dhananjay"),
              profile_row("Email", "abc@gmail.com"),
              profile_row("Phone No", "9484938993"),
              profile_row("Account Type", "role"),
              const SizedBox(
                height: 40,
              ),
              BtnPrimary(
                  title: "LOG OUT",
                  bgColor: Consts.klight,
                  txtColor: Consts.kdark,
                  onpress: () async {
                    await context.read<AuthMethods>().signOut();

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  })
            ]),
          ),
        ),
      )),
    );
  }

  Widget profile_row(String label1, String label2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Texts.h2(title: label1 + " : "),
        Texts.h2(title: label2),
      ],
    );
  }
}

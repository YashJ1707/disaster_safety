import 'package:disaster_safety/models/user_model.dart';
import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/loading.dart';
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
        title: const Text("Settings "),
        leading: const Icon(Icons.settings),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Container(
            width: width * 0.8,
            child: FutureBuilder<UserModel?>(
              future: DbMethods().loadUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data!;
                    return Column(children: [
                      profile_row("Name", user.name!),
                      profile_row("Email", user.email!),
                      profile_row("Account Type", user.role!),
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
                    ]);
                  }
                }
                return Loadings.staticLoader();
              },
            ),
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

import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/services/auth.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/dropdown.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:disaster_safety/shared/text_styles.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final List<String> roleTypes = ["user", "local_body"];
  String selectedRole = "user";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Texts.h1(title: "Join a Community of Preparedness"),
                ),
                SizedBox(
                  height: 10,
                ),
                Tinput(
                    hint: "Enter Name",
                    label: "Name",
                    controller: _nameController),
                Tinput(
                  hint: "Enter Email id",
                  label: "Email",
                  controller: _emailController,
                  keytype: TextInputType.emailAddress,
                ),
                Tinput(
                  hint: "Enter password",
                  label: "Password",
                  controller: _passController,
                  isobsecure: true,
                ),
                Text(
                  "Select Role",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                CustomDropdown(
                    options: roleTypes,
                    selectedValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    }),
                selectedRole == "local_body"
                    ? Column(
                        children: [
                          Tinput(
                            controller: TextEditingController(),
                            hint: "Enter department name",
                            label: "Department",
                          ),
                        ],
                      )
                    : Container(),
                BtnPrimary(
                    title: "SIGN UP",
                    txtColor: Consts.kwhite,
                    onpress: () async {
                      Loadings.showLoadingDialog(context, _keyLoader);
                      try {
                        Map<String, dynamic> data = {
                          "name": _nameController.text.toString(),
                          "useremail": _emailController.text.toString(),
                          "role": selectedRole,
                        };

                        UserCredential? user = await context
                            .read<AuthMethods>()
                            .signUp(
                                context: context,
                                email: _emailController.text,
                                password: _passController.text);

                        if (user != null) {
                          // add records into database
                          data['uid'] = user.user!.uid;
                          await DbMethods().signUp(data);
                          // navigate to login page
                          Navigator.of(_keyLoader.currentContext!,
                                  rootNavigator: true)
                              .pop();
                          Routes.push(context, LoginPage());
                        }
                      } catch (e) {
                        print(e);
                        Navigator.of(_keyLoader.currentContext!,
                                rootNavigator: true)
                            .pop();
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Texts.span("Already have an account ? "),
                      ),
                      BtnText(
                          title: "Login",
                          onpress: () {
                            Routes.push(context, LoginPage());
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

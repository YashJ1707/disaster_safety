import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/admin/home.dart';
import 'package:disaster_safety/screens/auth/sign_up.dart';
import 'package:disaster_safety/screens/dept/home.dart';
import 'package:disaster_safety/screens/user/homepage.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("WELCOME BACK !"),
              ),

              Container(
                child: Image(
                  image: AssetImage("assets/help.png"),
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Tinput(
                  hint: "Enter username",
                  label: "Username",
                  controller: _usernameController),
              Tinput(
                hint: "Enter password",
                label: "Password",
                controller: _passController,
                isobsecure: true,
              ),
              BtnPrimary(
                  title: "Login",
                  txtColor: Consts.kwhite,
                  onpress: () async {
                    //  sign in code
                    Loadings.showLoadingDialog(context, _keyLoader);
                    try {
                      UserCredential? user = await context
                          .read<AuthMethods>()
                          .signIn(
                              context: context,
                              email: _usernameController.text.toString(),
                              password: _passController.text.toString());

                      if (user != null) {
                        Navigator.of(_keyLoader.currentContext!,
                                rootNavigator: true)
                            .pop();

                        //get user role

                        String? userRole = await DbMethods()
                            .getRole(FirebaseAuth.instance.currentUser!.uid);

                        switch (userRole) {
                          case "user":
                            Routes.pushReplace(context, HomePage());
                            break;
                          case "local_body":
                            print("right case");
                            Routes.pushReplace(context, DeptHome());

                            break;
                          case "admin":
                            Routes.pushReplace(context, AdminHome());
                            break;
                          default:
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Error !! Please try later")));
                        }
                      }
                    } catch (e) {
                      // Navigator.of(_keyLoader.currentContext!,
                      //         rootNavigator: true)
                      //     .pop();
                      Navigator.of(_keyLoader.currentContext!,
                              rootNavigator: true)
                          .pop();
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              // BtnPrimary(
              //     bgColor: Consts.klight,
              //     title: "Continue with Google",
              //     txtColor: Consts.kblack,
              //     onpress: () async {
              //       await context.read<AuthMethods>().signInWithGoogle();
              //       FirebaseAuth.instance
              //           .authStateChanges()
              //           .listen((User? user) {
              //         if (user != null) {
              //           Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => HomePage(),
              //             ),
              //           );
              //         } else {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //               content: Text("Failed login"),
              //             ),
              //           );
              //         }
              //       });
              //     }),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Don't have an account ? "),
              ),
              BtnText(
                  title: "Create New Account",
                  onpress: () {
                    Routes.push(context, SignUpPage());
                  })
            ],
          ),
        ),
      ),
    );
  }
}

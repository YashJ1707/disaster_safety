import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/auth/sign_up.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                padding: const EdgeInsets.all(8.0),
                child: Text("WELCOME BACK !!"),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text("Login"),
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
                  txtColor: Consts.kblack,
                  onpress: () async {
                    //  sign in code
                  }),
              const SizedBox(
                height: 15,
              ),
              BtnPrimary(
                  bgColor: Consts.kprimary,
                  title: "Continue with Google",
                  txtColor: Consts.kblack,

                  onpress: () async {

                    // await context.read<AuthMethods>().signInWithGoogle();
                    // FirebaseAuth.instance
                    //     .authStateChanges()
                    //     .listen((User? user) {
                    //   if (user != null) {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => HomePage(),
                    //       ),
                    //     );
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text("Failed login"),
                    //     ),
                    //   );
                    // }
                    // });
                  }),
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

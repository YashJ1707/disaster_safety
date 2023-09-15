import 'package:disaster_safety/router.dart';
import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/shared/buttons.dart';
import 'package:disaster_safety/shared/text_field.dart';
import 'package:disaster_safety/shared/text_styles.dart';
import 'package:disaster_safety/shared/themes.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _cpassController = TextEditingController();
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Texts.h1(title: "Hey there !!"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Texts.h2(title: "REGISTER", txtcolor: Consts.kdark),
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
                hint: "Enter mobile number",
                label: "Mobile No",
                controller: _mobileController,
                keytype: TextInputType.phone,
              ),
              Tinput(
                hint: "Enter password",
                label: "Password",
                controller: _passController,
                isobsecure: true,
              ),
              BtnPrimary(
                  title: "SIGN UP",
                  txtColor: Consts.kblack,
                  onpress: () async {
                    String username = _emailController.text.toString();
                    String pass = _passController.text.toString();
                    Map<String, dynamic> data = {
                      "name": _nameController.text.toString(),
                      "email": _emailController.text.toString(),
                      "mobile": _mobileController.text.toString(),
                      "role": _roleController.text.toString(),
                      "passw": pass,
                    };
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
    );
  }
}

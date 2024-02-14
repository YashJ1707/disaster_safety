import 'package:disaster_safety/core/router.dart';
import 'package:disaster_safety/features/auth/data/datasource/auth_datasource.dart';
import 'package:disaster_safety/features/auth/data/datasource/db_datasource.dart';
import 'package:disaster_safety/features/auth/data/model/user_model.dart';
import 'package:disaster_safety/features/auth/data/repository/auth_repository_impl.dart';
import 'package:disaster_safety/features/auth/domain/repository/auth_repository.dart';
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
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                const Image(
                  image: AssetImage("assets/help.png"),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
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
                      final AuthRepositoryImpl repository = AuthRepositoryImpl(
                          authDatasource: AuthDatasourceImpl(),
                          dbDatasource: DbDatasourceImpl());
                      repository.updateAccount(
                        const UserModel(
                            latitude: 23432,
                            longitude: 234234,
                            id: "zNFXNNgwD5Ni0LRkDkcPlHLPCgx1",
                            name: "test name",
                            email: "email@email.com",
                            role: "role"),
                      );
                      //  sign in code
                      // Loadings.showLoadingDialog(context, _keyLoader);
                      // try {
                      //   UserCredential? user = await context
                      //       .read<AuthMethods>()
                      //       .signIn(
                      //           context: context,
                      //           email: _usernameController.text.toString(),
                      //           password: _passController.text.toString());

                      //   if (user != null) {
                      //     Navigator.of(_keyLoader.currentContext!,
                      //             rootNavigator: true)
                      //         .pop();

                      //     //get user role

                      //     String? userRole = await DbMethods()
                      //         .getRole(FirebaseAuth.instance.currentUser!.uid);

                      //     switch (userRole) {
                      //       case "user":
                      //         Routes.pushReplace(context, const HomePage());
                      //         break;
                      //       case "local_body":
                      //         print("right case");
                      //         Routes.pushReplace(context, const DeptHome());

                      //         break;
                      //       case "admin":
                      //         Routes.pushReplace(context, const AdminHome());
                      //         break;
                      //       default:
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //             const SnackBar(
                      //                 content:
                      //                     Text("Error !! Please try later")));
                      //     }
                      //   }
                      // } catch (e) {
                      //   // Navigator.of(_keyLoader.currentContext!,
                      //   //         rootNavigator: true)
                      //   //     .pop();
                      //   Navigator.of(_keyLoader.currentContext!,
                      //           rootNavigator: true)
                      //       .pop();
                      // }
                    }),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("Don't have an account ? "),
                ),
                BtnText(
                    title: "Create New Account",
                    onpress: () {
                      Routes.push(context, const SignUpPage());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:disaster_safety/firebase_options.dart';
import 'package:disaster_safety/screens/user/homepage.dart';
import 'package:disaster_safety/services/auth.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/maps/register_disaster_screen.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    StreamProvider(
      initialData: null,
      create: (context) =>
          Provider.of<AuthMethods>(context, listen: false).authStateChanges,
    ),
    Provider<AuthMethods>(
      create: (context) => AuthMethods(FirebaseAuth.instance),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            elevation: 2.0,
          )),
      home: AuthStatusPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthStatusPage extends StatelessWidget {
  const AuthStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SecureStorage().getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            // if(snpashot.data )
            return const RegisterDisasterScreen();
          } else {
            return HomePage();
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

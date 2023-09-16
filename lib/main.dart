import 'package:disaster_safety/firebase_options.dart';
import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/screens/admin/home.dart';
import 'package:disaster_safety/screens/auth/login.dart';
import 'package:disaster_safety/screens/dept/home.dart';
import 'package:disaster_safety/screens/user/homepage.dart';
import 'package:disaster_safety/services/auth.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/maps/complete_maps_screen.dart';
import 'package:disaster_safety/services/maps/register_disaster_screen.dart';
import 'package:disaster_safety/services/push_notification.dart';
import 'package:disaster_safety/services/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseMessaging.onBackgroundMessage(
  //     PushNotificationService().backgroundHandler);

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

class AuthStatusPage extends StatefulWidget {
  AuthStatusPage({super.key});

  @override
  State<AuthStatusPage> createState() => _AuthStatusPageState();
}

class _AuthStatusPageState extends State<AuthStatusPage> {
  String? userrole;

  String? userid;

  Future<List<String?>?> loadinfo() async {
    // userrole = await SecureStorage().getUserRole
    // ();
    userid = await SecureStorage().getUserId();
    if (userid != null) {}
    String? userRole = await DbMethods().getRole(userid);

    if (userid != null && userrole != null) {
      await SecureStorage().setUserId(null);
      await SecureStorage().setUsername(null);
      return [userid, userrole];
    }
    return null;

    // return true;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadinfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              if (snapshot.data![1] == "user") {
                return HomePage();
              } else {
                return DeptHome();
              }
            }
            return LoginPage();
          }
        }
        return LoginPage();
      },
    );
  }
}

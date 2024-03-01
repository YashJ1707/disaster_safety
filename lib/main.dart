import 'package:disaster_safety/core/router/app_router_config.dart';
import 'package:disaster_safety/features/auth/presentation/pages/auth_landing_page.dart';
import 'package:disaster_safety/features/auth/presentation/pages/login_page.dart';
import 'package:disaster_safety/features/auth/presentation/pages/signup_page.dart';
import 'package:disaster_safety/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              elevation: 2.0,
            )),
        routerConfig: AppRouterConfig.router,
        // home: SignUpPage(),
        // routerConfig: AppRouterConfig.router,
        // routerDelegate: AppRouterConfig.router.routerDelegate,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

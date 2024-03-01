import 'package:disaster_safety/core/color_const.dart';
import 'package:disaster_safety/core/router/app_router_const.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/auth_backgound.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundScaffold(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "assets/logo.png",
          width: 100.w,
        ),
        Text(
          "Rescue Wave",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30.sp,
              color: Colors.white),
        ),
        // ElevatedButton(onPressed: (){}, child: )
        SizedBox(height: 60.h),
        LoginButton(
          "Login",
          onPressed: () => context.goNamed(AppRouterConstants.loginRouteName),
        ),
        SizedBox(height: 20.h),
        SignupButton(
          onPressed: () => context.goNamed(AppRouterConstants.signupRouteName),
        ),
      ]),
    );
  }
}

import 'package:disaster_safety/core/color_const.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(),
        decoration: BoxDecoration(gradient: ColorConstants.loginGradient),
      ),
    );
  }
}

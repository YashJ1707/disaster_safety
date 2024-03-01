import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Routes {
  static Future<void> push(BuildContext context, Widget child) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => child),
      ),
    );
  }

  static Future<void> pushReplace(BuildContext context, Widget child) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: ((context) => child),
      ),
      (route) => false,
    );
  }

  static Future<bool> pop(BuildContext context) async {
    return await Navigator.of(context).maybePop();
  }

  // Snackbar

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(
      BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 800),
        backgroundColor: Colors.red,
        content: Center(
            child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}

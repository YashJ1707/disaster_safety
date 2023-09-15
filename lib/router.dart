import 'package:flutter/material.dart';

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
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }
}

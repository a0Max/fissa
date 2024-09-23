import 'package:flutter/material.dart';

class Utils {
  static Future<void> navigateTo(Widget screen, BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  static void navigateAndRemoveUntilTo(Widget child, BuildContext context,
          {bool rootNavigator = false}) async =>
      Navigator.of(context, rootNavigator: rootNavigator).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => child,
          ),
          (route) => false);

  static void navigateToAndReplacement(Widget child, BuildContext context) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => child));
}

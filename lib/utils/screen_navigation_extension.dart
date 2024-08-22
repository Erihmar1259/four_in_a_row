

import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateAndRemoveUntil(Widget newRoute, bool predicate) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => newRoute),
          (Route<dynamic> route) => predicate,
    );
  }
}

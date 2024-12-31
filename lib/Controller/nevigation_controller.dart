import 'package:flutter/material.dart';

class NavigationmenuController {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationmenuController({required this.navigatorKey});

  // Back function (pop)
  void goBack() {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    }
  }

  // Forward function (push)
  Future<void> goForward(Widget page) async {
    await navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

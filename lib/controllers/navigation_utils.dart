// navigation_extension.dart
import 'package:flutter/material.dart';
import 'package:infinicalc/ui/home_screen.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(String routeName) {
    if (routeName == '/') {
      Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushNamed(this, routeName);
    }
  }
}

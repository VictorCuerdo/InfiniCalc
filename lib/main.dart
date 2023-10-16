import 'package:flutter/material.dart';

import 'ui/home_screen.dart';

void main() => runApp(const InfiniCalc());

class InfiniCalc extends StatelessWidget {
  const InfiniCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfiniCalc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

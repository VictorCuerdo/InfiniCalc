import 'package:flutter/material.dart';
import 'package:infinicalc/controllers/font_size_provider.dart';
import 'package:infinicalc/ui/home_screen.dart';
import 'package:infinicalc/widgets/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const InfiniCalc());
}

class InfiniCalc extends StatelessWidget {
  const InfiniCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = FontSizeProvider();
        // Adding a listener to print the font size whenever it changes
        provider.addListener(() {
          print('Font Size Updated: ${provider.fontSize}');
        });
        return provider;
      },
      child: MaterialApp(
        title: 'InfiniCalc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

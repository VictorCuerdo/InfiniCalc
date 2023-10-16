import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String text;

  const CalculatorDisplay({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Black Container
        Container(
          height: 80,
          color: Colors.black,
        ),
        // Your existing Container
        Container(
          padding:
              const EdgeInsets.only(top: 150, left: 0, right: 0, bottom: 16),
          width: double.infinity,
          color: const Color(0xFFEDF2F6),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}

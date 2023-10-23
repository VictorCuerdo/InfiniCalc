import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String text;

  const CalculatorDisplay({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the screen height for adaptive layouts
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Black Container
        Container(
          height: screenHeight * 0.1, // 5% of the screen height
          color: Colors.black,
        ),
        // Your existing Container
        Container(
          padding: EdgeInsets.only(
            top: screenHeight * 0.13, // 10% of the screen height
            bottom: screenHeight * 0.07, // 7% of the screen height
          ),
          width: double.infinity,
          color: const Color(0xFFEDF2F6),
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenHeight * 0.03, // 3% of the screen height
            ),
          ),
        ),
      ],
    );
  }
}

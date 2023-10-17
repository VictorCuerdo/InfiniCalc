import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final dynamic label; // Change data type to dynamic
  final Function() onPressed;
  final Color bgColor;
  final Color textColor;
  final double textSize;

  const CalculatorButton({
    super.key,
    required this.label, // Keep label as it is
    required this.onPressed,
    required this.bgColor,
    this.textColor = Colors.black,
    this.textSize = 9.5,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
          ),
          child: label is IconData
              ? Icon(label, color: textColor, size: textSize)
              : Text(label,
                  style: TextStyle(
                      color: textColor,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

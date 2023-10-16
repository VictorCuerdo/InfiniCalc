import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final dynamic label; // Change data type to dynamic
  final Function() onPressed;
  final Color bgColor;

  const CalculatorButton({
    super.key,
    required this.label, // Keep label as it is
    required this.onPressed,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed, // Render text otherwise
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
          ),
          child: label is IconData // Check if label is of type IconData
              ? Icon(label,
                  color: Colors.black, size: 18) // Render icon if true
              : Text(label,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

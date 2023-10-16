import 'package:flutter/material.dart';

import 'calculator_button.dart';

class ButtonRow extends StatelessWidget {
  final List<dynamic>
      labels; // Adjusted this to handle both String and IconData
  final Function(dynamic) onPressed; // Adjusted this to pass label to onPressed
  final Color bgColor;

  const ButtonRow({
    Key? key,
    required this.labels,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: labels.map((label) {
        return CalculatorButton(
          label: label,
          onPressed: () =>
              onPressed(label), // Here, we pass the label to onPressed
          bgColor: bgColor,
        );
      }).toList(),
    );
  }
}

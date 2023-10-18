// /lib/widgets/button_row.dart

import 'package:flutter/material.dart';

import 'calculator_button.dart';

class ButtonRow extends StatelessWidget {
  final List<dynamic> labels;
  final Function(dynamic) onPressed;
  final List<String> tags;
  final List<Color> bgColors;

  const ButtonRow({
    Key? key,
    required this.labels,
    required this.onPressed,
    required this.bgColors,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(labels.length, (index) {
        final label = labels[index];
        return Column(
          children: [
            Text(
              tags[index], // Render the tag/label here
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 8.0,
              ),
            ),
            CalculatorButton(
              label: label,
              onPressed: () => onPressed(label),
              bgColor: bgColors[index], // Use individual bg color
              fontWeight: FontWeight.normal,
            ),
          ],
        );
      }),
    );
  }
}

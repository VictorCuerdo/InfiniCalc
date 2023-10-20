// /lib/widgets/button_row.dart

import 'package:flutter/material.dart';

import 'calculator_button.dart';

class ButtonRow extends StatelessWidget {
  final List<dynamic> labels;
  final Function(dynamic) onPressed;
  final List<dynamic> tags;
  final List<Color> bgColors;
  final double? buttonHeight;
  final double? buttonWidth;

  const ButtonRow({
    Key? key,
    required this.labels,
    required this.onPressed,
    required this.bgColors,
    required this.tags,
    this.buttonHeight,
    this.buttonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(labels.length, (index) {
        final label = labels[index];

        final hasTag = index < tags.length;

        // Check if the index exists within the bgColors list
        final bgColor = index < bgColors.length
            ? bgColors[index]
            : Colors.grey; // Default color if not provided

        return Column(
          children: [
            if (hasTag)
              if (tags[index] is String)
                Text(
                  tags[index],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 8.0,
                  ),
                )
              else if (tags[index] is Widget)
                tags[index],
            const SizedBox(height: 0.5),
            CalculatorButton(
              label: label,
              onPressed: () => onPressed(label),
              bgColor: bgColor,
              fontWeight: FontWeight.normal,
              height: buttonHeight,
              width: buttonWidth,
            ),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';

import 'calculator_button.dart';

class ButtonRow extends StatelessWidget {
  final List<dynamic> labels;
  final Function(dynamic) onPressed;
  final List<dynamic> tags;
  final List<Color> bgColors;
  final bool isFirstRow; // Added this parameter
  final double? buttonWidth;
  final double? buttonHeight;

  const ButtonRow({
    Key? key,
    required this.labels,
    required this.onPressed,
    required this.bgColors,
    required this.tags,
    this.isFirstRow = false,
    this.buttonWidth, // adding the new parameter here
    this.buttonHeight, // and here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(labels.length, (index) {
        final label = labels[index];
        final hasTag = !isFirstRow && index < tags.length;
        final bgColor = index < bgColors.length ? bgColors[index] : Colors.grey;

        return Expanded(
          child: Column(
            children: [
              if (hasTag)
                if (tags[index] is String && tags[index].isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                        bottom:
                            0.005 * screenWidth), // Reduced padding for tags
                    child: Text(
                      tags[index],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 0.02 * screenWidth,
                      ),
                    ),
                  )
                else if (tags[index] is Widget)
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 0.005 *
                            screenWidth), // Reduced padding for widget tags
                    child: tags[index],
                  ),
              CalculatorButton(
                label: label,
                onPressed: () => onPressed(label),
                bgColor: bgColor,
                fontWeight: FontWeight.normal,
                customWidth: buttonWidth, // pass the custom width here
                customHeight: buttonHeight, // pass the custom height here
              ),
            ],
          ),
        );
      }),
    );
  }
}

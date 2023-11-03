import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/controllers/font_size_provider.dart';
import 'calculator_button.dart';

class ButtonRow extends StatelessWidget {
  final List<dynamic> labels;
  final Function(dynamic) onPressed;
  final void Function(dynamic label)? onLongPressed;
  final List<dynamic> tags;
  final List<Color> bgColors;
  final bool isFirstRow;
  final double? buttonWidth;
  final double? buttonHeight;

  const ButtonRow({
    Key? key,
    required this.labels,
    required this.onPressed,
    required this.bgColors,
    required this.tags,
    this.isFirstRow = false,
    this.buttonWidth,
    this.buttonHeight,
    this.onLongPressed, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

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
                    padding: EdgeInsets.only(bottom: 0.005 * screenWidth),
                    child: Text(
                      tags[index],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: fontSize, // Set the font size dynamically
                      ),
                    ),
                  )
                else if (tags[index] is Widget)
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.005 * screenWidth),
                    child: tags[index],
                  ),
              CalculatorButton(
                label: label,
                onPressed: () => onPressed(label),
                onLongPressed: onLongPressed != null
                    ? () => onLongPressed!(label)
                    : null, // Pass the onLongPressed callback
                bgColor: bgColor,
                fontWeight: FontWeight.normal,
                customWidth: buttonWidth,
                customHeight: buttonHeight,
              ),
            ],
          ),
        );
      }),
    );
  }
}

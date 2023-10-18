import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final dynamic label; // Dynamic allows for both String and IconData
  final Function() onPressed;
  final Color bgColor;
  final Color textColor;
  final double textSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final double iconSize;
  final FontStyle fontStyle;
  final double? height; // New
  final double? width; // New

  const CalculatorButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.bgColor,
    this.height,
    this.width,
    this.textColor = Colors.black,
    this.textSize = 9.5,
    this.iconSize = 15,
    this.fontFamily = 'Barlow',
    required this.fontWeight,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 65,
      padding: const EdgeInsets.all(1.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
        ),
        child: label is IconData
            ? Icon(label, color: textColor, size: iconSize)
            : label is String
                ? Text(label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: textSize,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight,
                      fontStyle: fontStyle,
                    ))
                : label is Image
                    ? label
                    : const SizedBox(), // Removed .square() for simplicity
      ),
    );
  }
}

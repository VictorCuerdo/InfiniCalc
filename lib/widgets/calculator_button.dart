import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final dynamic label;
  final Function() onPressed;
  final Color bgColor;
  final Color textColor;
  final String fontFamily;
  final FontWeight fontWeight;
  final double iconSize;
  final FontStyle fontStyle;
  final double? customWidth;
  final double? customHeight;

  const CalculatorButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.bgColor,
    this.textColor = Colors.black,
    this.iconSize = 15,
    this.fontFamily = 'Barlow',
    required this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.customWidth, // adding the new parameter here
    this.customHeight, // and here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: customWidth ?? 0.16 * screenWidth,
      height: customHeight ?? 0.05 * screenHeight,
      padding: EdgeInsets.symmetric(
        vertical: 0.005 * screenHeight, // Reduced vertical padding
        horizontal: 0.001 * screenWidth,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust as necessary
          ),
        ),
        child: label is IconData
            ? Icon(label, color: textColor, size: iconSize)
            : label is String
                ? Text(label,
                    style: TextStyle(
                      color: textColor,
                      fontSize:
                          0.03 * screenWidth, // For example, 3% of screen width
                      fontFamily: fontFamily,
                      fontWeight: fontWeight,
                      fontStyle: fontStyle,
                    ))
                : label is Image
                    ? label
                    : label is Widget // <-- Handle the case for Widget type labels
                        ? label
                        : const SizedBox(),
      ),
    );
  }
}

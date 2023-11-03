import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final dynamic label;
  final Function() onPressed;
  final VoidCallback? onLongPressed; // Add this line
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
    this.onLongPressed, // Add this line
    required this.bgColor,
    this.textColor = Colors.black,
    this.iconSize = 24.0, // Updated to default Flutter icon size
    this.fontFamily = 'Barlow',
    required this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.customWidth,
    this.customHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onLongPress: onLongPressed, // Use the onLongPressed callback here
      child: Container(
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
          child: _buildButtonChild(
              context, screenWidth), // Separated the child building logic
        ),
      ),
    );
  }

  Widget _buildButtonChild(BuildContext context, double screenWidth) {
    if (label is IconData) {
      return Icon(label, color: textColor, size: iconSize);
    } else if (label is String) {
      return Text(label,
          style: TextStyle(
            color: textColor,
            fontSize: 0.03 * screenWidth, // For example, 3% of screen width
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
          ));
    } else if (label is Image) {
      return label;
    } else if (label is Widget) {
      return label;
    } else {
      return const SizedBox();
    }
  }
}

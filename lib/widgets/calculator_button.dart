import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final dynamic label;
  final Function() onPressed;
  final Color bgColor;
  final Color textColor;
  final double textSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final double iconSize;
  final FontStyle fontStyle;
  final double? height;
  final double? width;

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
      height: height ?? 35,
      width: width ?? 65,
      padding: const EdgeInsets.all(1),
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
                    : label is Widget // <-- Handle the case for Widget type labels
                        ? label
                        : const SizedBox(),
      ),
    );
  }
}

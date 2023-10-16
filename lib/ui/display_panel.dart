import 'package:flutter/material.dart';

import '../models/calculator_model.dart';

class DisplayPanel extends StatelessWidget {
  final CalculatorModel model;

  const DisplayPanel(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(model.currentInput),
        Text(model.result),
      ],
    );
  }
}

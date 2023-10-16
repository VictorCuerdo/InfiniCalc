//ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

import '../controllers/calculator_controller.dart';
import '../models/calculator_model.dart';
import '../widgets/calculator_button.dart';
import 'calculator_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CalculatorModel _model = CalculatorModel();
  late final CalculatorController _controller;

  _HomeScreenState() {
    _controller = CalculatorController(_model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464648),
      body: Column(
        children: [
          CalculatorDisplay(text: _model.currentInput), // Display the input
          //ROW 1
          Row(
            children: [
              CalculatorButton(
                  label: "SHIFT",
                  onPressed: () {},
                  bgColor: const Color(0xFF54C295)),
              CalculatorButton(
                  label: "MENU",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.arrow_back_ios,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.arrow_forward_ios,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.backspace,
                  onPressed: () {},
                  bgColor: const Color(0xFFEEA547)),
              CalculatorButton(
                  label: "AC",
                  onPressed: () {},
                  bgColor: const Color(0xFFEEA547)),
            ],
          ),
//ROW 2
          Row(
            children: [
              CalculatorButton(
                  label: "DRG",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "X⟺E",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.arrow_forward_ios,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.backspace,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "AC",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
            ],
          ),
          //ROW 3
          Row(
            children: [
              CalculatorButton(
                  label: "DRG",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "X⟺E",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.arrow_forward_ios,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.backspace,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "AC",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
            ],
          ),
          //ROW 4
          Row(
            children: [
              CalculatorButton(
                  label: "DRG",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "X⟺E",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.arrow_forward_ios,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.backspace,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "AC",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
            ],
          ),
          //ROW 5
          Row(
            children: [
              CalculatorButton(
                  label: "DRG",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "X⟺E",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.arrow_forward_ios,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: Icons.backspace,
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
              CalculatorButton(
                  label: "AC",
                  onPressed: () {},
                  bgColor: const Color(0xFFBAC2CD)),
            ],
          ),
        ],
      ),
    );
  }
}

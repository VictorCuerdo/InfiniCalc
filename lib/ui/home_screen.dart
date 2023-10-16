//ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          //ROW 6
          Row(
            children: [
              CalculatorButton(
                  label: "7",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "8",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "9",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "(",
                  onPressed: () {},
                  bgColor: const Color(0xFF6F6F71)),
              CalculatorButton(
                  label: ")",
                  onPressed: () {},
                  bgColor: const Color(0xFF6F6F71)),
            ],
          ),
          //ROW 7
          Row(
            children: [
              CalculatorButton(
                  label: "4",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "5",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "6",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: FontAwesomeIcons.xmark,
                  onPressed: () {},
                  bgColor: const Color(0xFF6F6F71)),
              CalculatorButton(
                  label: FontAwesomeIcons.divide,
                  onPressed: () {},
                  bgColor: const Color(0xFF6F6F71)),
            ],
          ),
          //ROW 8
          Row(
            children: [
              CalculatorButton(
                  label: "1",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "2",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "3",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: FontAwesomeIcons.plus,
                  onPressed: () {},
                  bgColor: const Color(0xFF6F6F71)),
              CalculatorButton(
                  label: FontAwesomeIcons.minus,
                  onPressed: () {},
                  bgColor: const Color(0xFF6F6F71)),
            ],
          ),
          //ROW 9
          Row(
            children: [
              CalculatorButton(
                  label: "0",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: ".",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "+/-",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: "EXP",
                  onPressed: () {},
                  bgColor: const Color(0xFF1C1C1C)),
              CalculatorButton(
                  label: FontAwesomeIcons.check,
                  onPressed: () {},
                  bgColor: const Color(0xFF6F6F71)),
            ],
          ),
        ],
      ),
    );
  }
}
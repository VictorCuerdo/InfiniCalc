//ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinicalc/widgets/button_row.dart';

import '../controllers/calculator_controller.dart';
import '../models/calculator_model.dart';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CalculatorDisplay(text: _model.currentInput),

          // Adjusting top padding
          // Adjust this value as needed

          // ROW 1 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 30,
            buttonWidth: 65,
            labels: const [
              "SHIFT",
              "MENU",
              Icons.arrow_back_ios,
              Icons.arrow_forward_ios,
              Icons.backspace,
              "AC",
            ],
            bgColors: const [
              Color(0xFF54C295),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFEEA547),
              Color(0xFFEEA547),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: const [
              '',
              '',
              '',
              '',
              '',
              '',
            ],
          ),

          // ROW 2 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 30,
            buttonWidth: 65,
            labels: [
              "DRG",
              "x ⟺ E",
              Image.asset('assets/images/matriz.png'),
              Math.tex(r'\sum',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 10.0)),
              "∫ dx",
              "CONV",
            ],
            bgColors: const [
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: const [
              '▶DRG',
              'FSE',
              'MTRX',
              'Π',
              'd/dx',
              'CNST',
            ],
          ),

// ROW 3 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 30,
            buttonWidth: 65,
            labels: const [
              "π",
              "sin",
              "cos",
              "tan",
              "i",
              //TextStyle(fontStyle: FontStyle.italic),
              "e",
            ],
            bgColors: const [
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: [
              'hyp',
              Math.tex(r'\sin^{-1}',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
              Math.tex(r'\cos^{-1}',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
              Math.tex(r'\tan^{-1}',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
              '∠',
              Math.tex(r'\log_x Y',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
            ],
          ),

          // ROW 4 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 30,
            buttonWidth: 65,
            labels: [
              Math.tex(r'x^{-1}',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 16.0)),
              Math.tex(r'x^{2}',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 16.0)),

              Math.tex(r'\sqrt{x}',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 16.0)),

              Math.tex(r'x^{y}',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 16.0)),
              "log",
              //TextStyle(fontStyle: FontStyle.italic),
              "ln",
            ],
            bgColors: const [
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: [
              'lim',
              Math.tex(r'x^3',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
              Math.tex(r'\sqrt[3]{x}',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
              Math.tex(r'\sqrt[x]{y}',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 9.0)),
              Math.tex(r'10^x',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
              Math.tex(r'e^x',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
            ],
          ),

// ROW 5 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 30,
            buttonWidth: 65,
            labels: [
              "D°M'S",
              Math.tex(r' \; d/c',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 16.0)),
              const Text("X",
                  style: TextStyle(
                      color: Color(0xFF2C91D9),
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
              const Text("XY,M",
                  style: TextStyle(
                      color: Color(0xFF2C91D9),
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
              const Text("MR",
                  style: TextStyle(
                      color: Color(0xFF2C91D9),
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
              const Text("x→M",
                  style: TextStyle(
                      color: Color(0xFF2C91D9),
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ],
            bgColors: const [
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
              Color(0xFFBAC2CD),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: [
              'STAT',
              Math.tex(r' a \; b/c',
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 10.0)),
              'Y',
              'HISTORY',
              'M+',
              'M-',
            ],
          ),

//////////////////////////////////

// ROW 6 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("7", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("8", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("9", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("(", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text(")", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
            bgColors: const [
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF6F6F71),
              Color(0xFF6F6F71),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: const [
              'CPLX',
              '∞',
              '',
              '%',
              'mod',
            ],
          ),

// ROW 7 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("4", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("5", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("6", style: TextStyle(color: Colors.white, fontSize: 16)),
              Icon(FontAwesomeIcons.xmark, color: Colors.white, size: 16),
              Icon(
                FontAwesomeIcons.divide,
                color: Colors.white,
                size: 16,
              ),
            ],
            bgColors: const [
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF6F6F71),
              Color(0xFF6F6F71),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: const [
              'n!',
              'nCr',
              'nPr',
              '▶BIN',
              '▶OCT',
            ],
          ),

// ROW 8 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("1", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("2", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("3", style: TextStyle(color: Colors.white, fontSize: 16)),
              Icon(FontAwesomeIcons.plus, color: Colors.white, size: 16),
              Icon(
                FontAwesomeIcons.minus,
                color: Colors.white,
                size: 16,
              ),
            ],
            bgColors: const [
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF6F6F71),
              Color(0xFF6F6F71),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: const [
              'gcd',
              'lcm',
              'abs',
              '▶DEC',
              '▶HEX',
            ],
          ),

          // ROW 9 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("0", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text(".", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("+/-", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("EXP", style: TextStyle(color: Colors.white, fontSize: 16)),
              Icon(FontAwesomeIcons.check, color: Colors.white, size: 16),
            ],
            bgColors: const [
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF1C1C1C),
              Color(0xFF6F6F71),
            ],
            onPressed: (label) {
              // Handle button press here
            },
            tags: const [
              'OTHER',
              'ran#',
              'Ans',
              'EXP SI',
              '"=,<,>',
            ],
          ),
        ],
      ),
    );
  }
}

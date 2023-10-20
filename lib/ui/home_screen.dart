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
            buttonHeight: 33,
            buttonWidth: 65,
            labels: const [
              Text("SHIFT",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Text("MENU",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Icons.arrow_back_ios,
              Icons.arrow_forward_ios,
              Icons.backspace,
              Text("AC",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
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
              Text(
                '',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                '',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                '',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                '',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                '',
                style: TextStyle(fontSize: 8),
              ),
              Text(
                '',
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),

          // ROW 2 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 33,
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
              Text('▶DRG',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('FSE',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('MTRX',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('Π',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('d/dx',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('CNST',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
            ],
          ),

// ROW 3 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 33,
            buttonWidth: 65,
            labels: const [
              Text("π",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Text("sin",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Text("cos",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Text("tan",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Text("i",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal)),
              Text("e",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
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
              const Text('hyp',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Math.tex(r'\sin^{-1}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
              Math.tex(r'\cos^{-1}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
              Math.tex(r'\tan^{-1}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
              const Text('∠',
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFFBAC2CD),
                    fontWeight: FontWeight.bold,
                  )),
              Math.tex(r'\log_x Y',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
            ],
          ),

          // ROW 4 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 33,
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
              const Text("log",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              const Text("ln",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
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
              const Text('lim',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Math.tex(r'x^3',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
              Math.tex(r'\sqrt[3]{x}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
              Math.tex(r'\sqrt[x]{y}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
              Math.tex(r'10^x',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
              Math.tex(r'e^x',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 12.0)),
            ],
          ),

// ROW 5 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 33,
            buttonWidth: 65,
            labels: [
              const Text("D°M'S",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Math.tex(r' \; d/c',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 15.0)),
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
              const Text('STAT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              Math.tex(r' a \; b/c',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 11.0)),
              const Text('Y',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              const Text('HISTORY',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              const Text('M+',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
              const Text('M-',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFBAC2CD),
                  )),
            ],
          ),

//////////////////////////////////

// ROW 6 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("7",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("8",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("9",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("(",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text(")",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
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
              Text('CPLX',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('∞',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('%',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('mod',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
            ],
          ),

// ROW 7 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("4",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("5",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("6",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Icon(FontAwesomeIcons.xmark, color: Colors.white, size: 18),
              Icon(
                FontAwesomeIcons.divide,
                color: Colors.white,
                size: 18,
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
              Text('n!',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('nCr',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('nPr',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('▶BIN',
                  style: TextStyle(fontSize: 10, color: Color(0xFFBAC2CD))),
              Text('▶OCT',
                  style: TextStyle(fontSize: 10, color: Color(0xFFBAC2CD))),
            ],
          ),

// ROW 8 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("1",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("2",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("3",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Icon(FontAwesomeIcons.plus, color: Colors.white, size: 18),
              Icon(
                FontAwesomeIcons.minus,
                color: Colors.white,
                size: 18,
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
              Text('gcd',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('lcm',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('abs',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('▶DEC',
                  style: TextStyle(fontSize: 10, color: Color(0xFFBAC2CD))),
              Text('▶HEX',
                  style: TextStyle(fontSize: 10, color: Color(0xFFBAC2CD))),
            ],
          ),

          // ROW 9 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            buttonHeight: 45,
            buttonWidth: 80,
            labels: const [
              Text("0",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text(".",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("+/-",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Text("EXP",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Barlow')),
              Icon(FontAwesomeIcons.check, color: Colors.white, size: 18),
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
              Text('OTHER',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('ran#',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('Ans',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('EXP SI',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
              Text('=,<,>',
                  style: TextStyle(fontSize: 12, color: Color(0xFFBAC2CD))),
            ],
          ),
        ],
      ),
    );
  }
}

//ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinicalc/widgets/button_row.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CalculatorDisplay(text: _model.currentInput),

          // Adjusting top padding
          // Adjust this value as needed

          // ROW 1 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
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

          //ROW 2*****************
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('▶DRG',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "DRG",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 13.5,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    const Text('FSE',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "x ⟺ E",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 13,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    const Text('MTRX',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                      label: Image.asset('assets/images/matriz.png',
                          width: 30, height: 30),
                      onPressed: () {},
                      bgColor: const Color(0xFFBAC2CD),
                      textSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    const Text('Π',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: Icons.functions,
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        iconSize: 24,
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    const Text('d/dx',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "∫ dx",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 16,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 6
                Column(
                  children: [
                    const Text('CNST',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "CONV",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 12,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              ],
            ),
          ),

          //ROW 3************
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('hyp',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: 'π',
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 17,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    Math.tex(r'\sin^{-1}',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: "sin",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 16,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    Math.tex(r'\cos^{-1}',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: "cos",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 16,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    Math.tex(r'\tan^{-1}',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: "tan",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 16,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    const Text('∠',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                      label: "i",
                      onPressed: () {},
                      bgColor: const Color(0xFFBAC2CD),
                      textSize: 17,
                      fontFamily: 'Barlow',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),

                //Column 6
                Column(
                  children: [
                    Math.tex(r'\log_x Y',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: "e",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 17,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              ],
            ),
          ),

          //ROW 4***************
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('lim',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: Image.asset('assets/images/xuno.png',
                            width: 22, height: 22),
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 12,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    Math.tex(r'x^3',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: Image.asset('assets/images/xdos.png',
                            width: 22, height: 22),
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 12,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    Math.tex(r'\sqrt[3]{x}',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: FontAwesomeIcons.squareRootVariable,
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        fontWeight: FontWeight.normal,
                        iconSize: 18),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    Math.tex(r'\sqrt[x]{y}',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: Image.asset('assets/images/xy.png',
                            width: 22, height: 22),
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 12,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    Math.tex(r'10^x',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    CalculatorButton(
                        label: "log",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        fontFamily: 'Barlow',
                        textSize: 16,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 6
                Column(
                  children: [
                    Math.tex(r'e^x',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 18.0)),
                    CalculatorButton(
                        label: "ln",
                        fontFamily: 'Barlow',
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 16,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              ],
            ),
          ),

          //ROW 5*****************
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('STAT',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "D°M'S",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 12.5,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    Math.tex(r'ɑ \; b/c',
                        textStyle: const TextStyle(
                            color: Colors.grey, fontSize: 13.0)),
                    CalculatorButton(
                        label: Image.asset('assets/images/dc.png',
                            width: 22, height: 22),
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textSize: 12.5,
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    const Text('Y',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                      label: FontAwesomeIcons.x,
                      onPressed: () {},
                      bgColor: const Color(0xFFBAC2CD),
                      textColor: const Color(0xFF2C91D9),
                      fontWeight: FontWeight.bold,
                      iconSize: 15,
                    ),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    const Text('HISTORY',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                      label: "XY,M",
                      onPressed: () {},
                      bgColor: const Color(0xFFBAC2CD),
                      textColor: const Color(0xFF2C91D9),
                      textSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow',
                    ),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    const Text('M+',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                      label: "MR",
                      onPressed: () {},
                      bgColor: const Color(0xFFBAC2CD),
                      textColor: const Color(0xFF2C91D9),
                      textSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow',
                    ),
                  ],
                ),

                //Column 6
                Column(
                  children: [
                    const Text('M-',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "x→M",
                        onPressed: () {},
                        bgColor: const Color(0xFFBAC2CD),
                        textColor: const Color(0xFF2C91D9),
                        textSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow'),
                  ],
                ),
              ],
            ),
          ),

///////////////////////////////////////////////////////
          //ROW 6

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('CPLX',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "7",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    const Text('∞',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "8",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    const Text('',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "9",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    const Text('%',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "(",
                        onPressed: () {},
                        bgColor: const Color(0xFF6F6F71),
                        textColor: Colors.white,
                        textSize: 23,
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    const Text('mod',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: ")",
                        onPressed: () {},
                        bgColor: const Color(0xFF6F6F71),
                        textColor: Colors.white,
                        textSize: 23,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ],
            ),
          ),

          //ROW 7*****************
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('n!',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "4",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    const Text('nCr',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "5",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    const Text('nPr',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "6",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    const Text('▶BIN',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: FontAwesomeIcons.xmark,
                        onPressed: () {},
                        bgColor: const Color(0xFF6F6F71),
                        textColor: Colors.white,
                        iconSize: 23,
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    const Text('▶OCT',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: FontAwesomeIcons.divide,
                        onPressed: () {},
                        bgColor: const Color(0xFF6F6F71),
                        textColor: Colors.white,
                        iconSize: 23,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ],
            ),
          ),

          //ROW 8************
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('gcd',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "1",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    const Text('lcm',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "2",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    const Text('abs',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: "3",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    const Text('▶DEC',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: FontAwesomeIcons.plus,
                        onPressed: () {},
                        bgColor: const Color(0xFF6F6F71),
                        textColor: Colors.white,
                        iconSize: 23,
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    const Text('▶HEX',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: FontAwesomeIcons.minus,
                        onPressed: () {},
                        bgColor: const Color(0xFF6F6F71),
                        textColor: Colors.white,
                        iconSize: 23,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ],
            ),
          ),

          //ROW 9***************
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Column 1
                Column(
                  children: [
                    const Text('OTHER',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "0",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 2
                Column(
                  children: [
                    const Text('ran#',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: ".",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 3
                Column(
                  children: [
                    const Text('Ans',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "+/-",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 25,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                  ],
                ),

                //Column 4
                Column(
                  children: [
                    const Text('EXP SI',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    CalculatorButton(
                        label: "EXP",
                        onPressed: () {},
                        bgColor: const Color(0xFF1C1C1C),
                        textColor: Colors.white,
                        textSize: 20,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.normal),
                  ],
                ),

                //Column 5
                Column(
                  children: [
                    const Text('=,<,>',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                    CalculatorButton(
                        label: FontAwesomeIcons.check,
                        onPressed: () {},
                        bgColor: const Color(0xFF6F6F71),
                        textColor: Colors.white,
                        iconSize: 23,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

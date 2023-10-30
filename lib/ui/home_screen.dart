// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:infinicalc/controllers/font_size_provider.dart';
import 'package:infinicalc/widgets/button_row.dart';
import 'package:infinicalc/widgets/dropdown_menu.dart' as my_widgets;
import 'package:provider/provider.dart';

import '../controllers/calculator_controller.dart';
import '../models/calculator_model.dart';
import 'calculator_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color backgroundColor =
      const Color(0xFF464648); // Adjust as necessary// Default background color
  final CalculatorModel _model = CalculatorModel();
  late final CalculatorController _controller;

  final GlobalKey buttonRowKey = GlobalKey();

  _HomeScreenState() {
    _controller = CalculatorController(_model);
  }
  void _changeFontSize(double newSize) {
    // Get the FontSizeProvider instance
    FontSizeProvider fontSizeProvider =
        Provider.of<FontSizeProvider>(context, listen: false);

    // Update the font size
    fontSizeProvider.fontSize = newSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CalculatorDisplay(
              text: _model.currentInput), // Make sure _model is defined
          ButtonRow(
            key: buttonRowKey,
            isFirstRow: true,
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
              if (label is Text && label.data == "MENU") {
                _showDropdownMenu(context, label);
              } else {
                // Handle other button presses
              }
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

/*

          // ROW 2 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            labels: [
              const Text("DRG",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              const Text("x ⟺ E",
                  style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Image.asset('assets/images/matriz.png'),
              Math.tex(r'\sum',
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 10.0)),
              const Text("∫ dx",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              const Text("CONV",
                  style: TextStyle(
                      fontSize: 12,
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
            tags: const [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 12, color: Color(0xFFBAC2CD)),
                    SizedBox(
                        width:
                            3), // Optional: adjust the space between the icon and text
                    Text(
                      'DRG',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBAC2CD),
                      ),
                    ),
                  ],
                ),
              ),
              Text('FSE',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('MTRX',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('Π',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('d/dx',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              Text('CNST',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
            ],
          ),

// ROW 3 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
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
                    fontSize: 11,
                    color: Color(0xFFBAC2CD),
                  )),
              Math.tex(r'\sin^{-1}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 15.0)),
              Math.tex(r'\cos^{-1}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 15.0)),
              Math.tex(r'\tan^{-1}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 15.0)),
              const Text('∠',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFFBAC2CD),
                    fontWeight: FontWeight.bold,
                  )),
              Math.tex(r'\log_x Y',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 13.0)),
            ],
          ),

          // ROW 4 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
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
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              Math.tex(r'x^3',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 16.0)),
              Math.tex(r'\sqrt[3]{x}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 14.0)),
              Math.tex(r'\sqrt[x]{y}',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 14.0)),
              Math.tex(r'10^x',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 16.0)),
              Math.tex(r'e^x',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 16.0)),
            ],
          ),

// ROW 5 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
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
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              Math.tex(r' a \; b/c',
                  textStyle: const TextStyle(
                      color: Color(0xFFBAC2CD), fontSize: 14.0)),
              const Text('Y',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              const Text('HISTORY',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              const Text('M+',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
              const Text('M-',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBAC2CD),
                  )),
            ],
          ),

//////////////////////////////////

// ROW 6 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            labels: const [
              Text("7",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("8",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("9",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("(",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text(")",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
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
            buttonWidth: MediaQuery.of(context).size.width *
                0.19, // specify custom width
            buttonHeight: MediaQuery.of(context).size.height *
                0.06, // specify custom height
          ),

// ROW 7 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            labels: const [
              Text("4",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("5",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("6",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Icon(FontAwesomeIcons.xmark, color: Colors.white, size: 23),
              Icon(
                FontAwesomeIcons.divide,
                color: Colors.white,
                size: 23,
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
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 12, color: Color(0xFFBAC2CD)),
                    SizedBox(
                        width:
                            3), // Optional: adjust the space between the icon and text
                    Text(
                      'BIN',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBAC2CD),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 12, color: Color(0xFFBAC2CD)),
                    SizedBox(
                        width:
                            3), // Optional: adjust the space between the icon and text
                    Text(
                      'OCT',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBAC2CD),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            buttonWidth: MediaQuery.of(context).size.width *
                0.19, // specify custom width
            buttonHeight: MediaQuery.of(context).size.height *
                0.06, // specify custom height
          ),

// ROW 8 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            labels: const [
              Text("1",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("2",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("3",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Icon(FontAwesomeIcons.plus, color: Colors.white, size: 23),
              Icon(
                FontAwesomeIcons.minus,
                color: Colors.white,
                size: 23,
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
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 12, color: Color(0xFFBAC2CD)),
                    SizedBox(
                        width:
                            3), // Optional: adjust the space between the icon and text
                    Text(
                      'DEC',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBAC2CD),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 12, color: Color(0xFFBAC2CD)),
                    SizedBox(
                        width:
                            3), // Optional: adjust the space between the icon and text
                    Text(
                      'HEX',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBAC2CD),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            buttonWidth: MediaQuery.of(context).size.width *
                0.19, // specify custom width
            buttonHeight: MediaQuery.of(context).size.height *
                0.06, // specify custom height
          ),

          // ROW 9 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            labels: const [
              Text("0",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text(".",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("+/-",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Text("EXP",
                  style: TextStyle(
                      color: Colors.white, fontSize: 23, fontFamily: 'Barlow')),
              Icon(FontAwesomeIcons.check, color: Colors.white, size: 23),
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
            buttonWidth: MediaQuery.of(context).size.width *
                0.19, // specify custom width
            buttonHeight: MediaQuery.of(context).size.height *
                0.06, // specify custom height
          ),
*/
        ],
      ),
    );
  }

  OverlayEntry? _overlayEntry;

  void _showDropdownMenu(BuildContext context, dynamic label) {
    // If the label is a Text widget, extract the text from it. Otherwise, convert the label to a string.
    final String labelText = label is Text ? label.data! : label.toString();

    if (labelText == "MENU") {
      if (_overlayEntry != null) {
        // Close the dropdown if it is already open
        closeDropdown();
      } else {
        // Show the dropdown
        final RenderBox renderBox =
            buttonRowKey.currentContext!.findRenderObject() as RenderBox;
        final Offset offset = renderBox.localToGlobal(Offset.zero);
        final Size size = renderBox.size;

        double screenWidth = MediaQuery.of(context).size.width;
        double dropdownWidth =
            size.width * 0.65; // 25% less wider than the button row
        double leftPadding = (screenWidth - dropdownWidth) / 2;

        _overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            left: leftPadding + 1.5, // adjusted position
            top: offset.dy + size.height,
            width: dropdownWidth,
            child: Material(
              elevation: 10,
              color: Colors.transparent,
              child: Container(
                color: Colors.black, // Container color to black
                height: 300, // or some other appropriate height
                child: my_widgets.DropdownMenu(
                  onColorSelected: _changeBackgroundColor,
                  onSettingsSelected: () {
                    // Navigate to Settings Screen
                    closeDropdown();
                  },
                  onHistorySelected: () {
                    // Navigate to History Screen
                    closeDropdown();
                  },
                  onHelpSelected: () {
                    // Navigate to Help Screen
                    closeDropdown();
                  },
                  onShareSelected: () {
                    // Navigate to Share Screen
                    closeDropdown();
                  },
                  closeDropdown:
                      closeDropdown, // Pass the closeDropdown method here
                ),
              ),
            ),
          ),
        );

        Overlay.of(context)!.insert(_overlayEntry!);
      }
    } else {
      // Handle other button presses
    }
  }

  void closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }
}

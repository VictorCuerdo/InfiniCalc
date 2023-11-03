// ignore_for_file: library_private_types_in_public_api
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';
import 'package:infinicalc/widgets/button_row.dart';
import 'package:infinicalc/widgets/dropdown_menu.dart' as my_widgets;
import 'package:infinicalc/widgets/dropdown_menuformat.dart';
import 'package:infinicalc/widgets/matrix_menus.dart';

import '../controllers/calculator_controller.dart';
import '../models/calculator_model.dart';
import 'calculator_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color backgroundColor = const Color(0xFF464648);
  final CalculatorModel _model = CalculatorModel();
  late final CalculatorController _controller;
  final GlobalKey xEButtonKey = GlobalKey();
  final GlobalKey buttonRowKey = GlobalKey();

  // Declare a Key for your image, but don't assign it yet
  late final GlobalKey matrixImageKey;

  // Declare the Image widget, but don't assign it yet
  late final Image matrixImage;

  // Constructor
  _HomeScreenState() {
    _controller = CalculatorController(_model);
    // Initialize the matrixImageKey here if it doesn't depend on the context
    matrixImageKey = GlobalKey();
  }

  @override
  void initState() {
    super.initState();
    // Assign the matrixImage here where it's safe to access other instance members
    matrixImage = Image.asset('assets/images/matriz.png', key: matrixImageKey);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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

          // ROW 2 (Using ButtonRow for a cleaner look and uniformity)
          ButtonRow(
            labels: [
              const Text("DRG",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              const Text(
                "x ⟺ E",
                style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              matrixImage,
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
              print("Button pressed with label: $label");
              if (label is Text && label.data == "x ⟺ E") {
                _showDropdownMenu(context, label);
              } else if (label is Image && label.key == matrixImageKey) {
                print("image button pressed once with label: $label");
              } else if (label is Text && label.data == "CONV") {
                context.navigateTo('/unit');
              }
            },
            onLongPressed: (label) {
              // The action to take on long press
              if (label is Image && label.key == matrixImageKey) {
                // The matrix image was long-pressed, handle the action
                _showDropdownMenu(context, label);
              }
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
/*
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

  void closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  void _showDropdownMenu(BuildContext context, dynamic label) {
    // Acquire render box of the button row using the global key
    final RenderBox renderBox =
        buttonRowKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    // Calculate the position and size for the overlay
    double screenWidth = MediaQuery.of(context).size.width;
    double dropdownWidth = size.width * 0.65;
    double leftPadding = (screenWidth - dropdownWidth) / 2;

    // If an overlay is already displayed, we remove it
    if (_overlayEntry != null) {
      closeDropdown();
      return; // Early return if we're closing the current overlay
    }

    // Check for image label
    if (label is Image && label.image is AssetImage) {
      final AssetImage labelAssetImage = label.image as AssetImage;
      if (matrixImage.image is AssetImage) {
        final AssetImage matrixAssetImage = matrixImage.image as AssetImage;
        if (labelAssetImage.assetName == matrixAssetImage.assetName) {
          // Now we know that both images are the same asset
          _overlayEntry = createMatrixImageOverlay(
              context, offset, size, leftPadding, dropdownWidth);
          // Insert the overlay into the widget tree if it was created
          Overlay.of(context)!.insert(_overlayEntry!);
          return; // Early return since we've handled the Image case
        }
      }
    }

    // Since we didn't return, label is not an Image or the Image doesn't match matrixImage
    // Proceed to check for text label
    if (label is Text) {
      final String labelText = label.data ?? label.toString().tr();
      if (labelText == "x ⟺ E") {
        // Create overlay for "x ⟺ E"
        _overlayEntry =
            createXOverlay(context, offset, size, leftPadding, dropdownWidth);
      } else if (labelText == "MENU") {
        // Create overlay for "MENU"
        _overlayEntry = createMenuOverlay(
            context, offset, size, leftPadding, dropdownWidth);
      } else {
        // Handle other text labels if necessary
        // _overlayEntry = createOtherOverlay(...);
      }

      // Insert the overlay into the widget tree if it was created
      if (_overlayEntry != null) {
        Overlay.of(context)!.insert(_overlayEntry!);
      }
    }
  }

  OverlayEntry createMatrixImageOverlay(BuildContext context, Offset offset,
      Size size, double leftPadding, double dropdownWidth) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: closeDropdown,
          behavior: HitTestBehavior.translucent,
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: leftPadding + 50,
                  top: offset.dy,
                  width: dropdownWidth * 1.1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      elevation: 10,
                      child: Container(
                        color: Colors.black,
                        height: 580,
                        child: MatrixMenus(
                          closeDropdown: closeDropdown,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  OverlayEntry createXOverlay(BuildContext context, Offset offset, Size size,
      double leftPadding, double dropdownWidth) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: closeDropdown,
          behavior: HitTestBehavior.translucent,
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: leftPadding + 1.5,
                  top: offset.dy + size.height + 58,
                  width: dropdownWidth * 1.1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      elevation: 10,
                      child: Container(
                        color: Colors.black,
                        height: 270,
                        child: DropdownMenuFormat(
                          closeDropdown: closeDropdown,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  OverlayEntry createMenuOverlay(BuildContext context, Offset offset, Size size,
      double leftPadding, double dropdownWidth) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: closeDropdown,
          behavior: HitTestBehavior.translucent,
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: leftPadding + 1.5,
                  top: offset.dy + size.height,
                  width: dropdownWidth,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      elevation: 10,
                      color: Colors.transparent,
                      child: Container(
                        color: Colors.black,
                        height: 300,
                        child: my_widgets.DropdownMenu(
                          onColorSelected: _changeBackgroundColor,
                          onSettingsSelected: () {
                            closeDropdown();
                            // Navigate to Settings Screen
                          },
                          onHistorySelected: () {
                            closeDropdown();
                            // Navigate to History Screen
                          },
                          onHelpSelected: () {
                            closeDropdown();
                            // Navigate to Help Screen
                          },
                          onShareSelected: () {
                            closeDropdown();
                            // Navigate to Share Screen
                          },
                          closeDropdown: closeDropdown,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

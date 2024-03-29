// ignore_for_file: library_private_types_in_public_api
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class FuelUnitConverter extends StatefulWidget {
  const FuelUnitConverter({super.key});

  @override
  _FuelUnitConverterState createState() => _FuelUnitConverterState();
}

class _FuelUnitConverterState extends State<FuelUnitConverter> {
  String fromUnit = 'Litres per 100 km';
  String toUnit = 'Litres per 100 miles';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool _isExponentialFormat = false;
  // Flag to indicate if the change is due to user input
  bool _isUserInput = true;
  // Using string variables for prefixes
  String fromPrefix = 'L/100 km';
  String toPrefix = 'L/100 mi';
  final ScreenshotController screenshotController = ScreenshotController();
  String _conversionFormula = '';

  @override
  void initState() {
    super.initState();
    fromUnit = ''; // Represent unselected state with an empty string
    toUnit = ''; // Represent unselected state with an empty string

    // Add listener to fromController
    fromController.addListener(() {
      if (_isUserInput) {
        convert(fromController.text); // Pass the raw text to convert
      }
    });

    // Initialize the conversion formula text
    _conversionFormula = _getConversionFormula();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  void _resetToDefault() {
    setState(() {
      fromController.clear();
      toController.clear();
      fromUnit = ''; // Set to an empty string or a valid default value
      toUnit = ''; // Set to an empty string or a valid default value
      _isExponentialFormat = false;
      _conversionFormula = _getConversionFormula();
    });
  }

  void _takeScreenshotAndShare() async {
    // Capture the screenshot using the screenshotController
    final Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/screenshot.png').create();
      await imagePath.writeAsBytes(imageBytes);
      // Using shareXFiles
      await Share.shareXFiles([XFile(imagePath.path)],
          text: 'Check out my fuel consumption result!');
    }
  }

  void convert(String text) {
    String normalizedText = text.replaceAll(',', '.');
    if (normalizedText.isEmpty) return;
    var fromValue = double.tryParse(normalizedText);
    if (fromValue == null) return;
    double toValue = 0; // Your conversion logic here

    switch (fromUnit) {
      case 'Litres per 100 km':
        switch (toUnit) {
          case 'Litres per 100 miles':
            toValue = fromValue / 1.609344;
            break;
          case 'Kilometres per Litre':
            toValue = 100.0 / fromValue;
            break;
          case 'Kilometres per Gallon (US)':
            toValue = 235.214583 / fromValue;
            break;
          case 'Miles per Litre':
            toValue = 62.1371192 / fromValue;
            break;
          case 'Miles per Gallon (Imp)':
            toValue = 282.480936 / fromValue;
            break;
          case 'Miles per Gallon (US)':
            toValue = 235.214583 / fromValue;
            break;
          case 'Nautical Miles per Litre':
            toValue = 86.8988259 / fromValue;
            break;
          case 'Litres per 100 km': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Litres per 100 miles':
        switch (toUnit) {
          case 'Litres per 100 km':
            toValue = fromValue * 1.609344;
            break;
          case 'Kilometres per Litre':
            toValue = 62.1371192 / fromValue;
            break;
          case 'Kilometres per Gallon (US)':
            toValue = 378.541178 / fromValue;
            break;
          case 'Miles per Litre':
            toValue = 100.0 / fromValue;
            break;
          case 'Miles per Gallon (Imp)':
            toValue = 453.59237 / fromValue;
            break;
          case 'Miles per Gallon (US)':
            toValue = 378.541178 / fromValue;
            break;
          case 'Nautical Miles per Litre':
            toValue = 139.273462 / fromValue;
            break;
          case 'Litres per 100 miles': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Kilometres per Litre':
        switch (toUnit) {
          case 'Kilometres per Gallon (US)':
            toValue = fromValue / 0.2641720524;
            break;
          case 'Litres per 100 km':
            toValue = 100.0 / fromValue;
            break;
          case 'Litres per 100 miles':
            toValue = 62.1371192 / fromValue;
            break;
          case 'Miles per Litre':
            toValue = 0.621371192 / fromValue;
            break;
          case 'Miles per Gallon (Imp)':
            toValue = 2.824809364 / fromValue;
            break;
          case 'Miles per Gallon (US)':
            toValue = 3.785411784 / fromValue;
            break;
          case 'Nautical Miles per Litre':
            toValue = 0.539956803 / fromValue;
            break;
          case 'Kilometres per Litre': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Kilometres per Gallon (US)':
        switch (toUnit) {
          case 'Kilometres per Litre':
            toValue = fromValue * 0.2641720524;
            break;
          case 'Litres per 100 km':
            toValue = 235.214583 / fromValue;
            break;
          case 'Litres per 100 miles':
            toValue = 147.0068379 / fromValue;
            break;
          case 'Miles per Litre':
            toValue = 100.0 / fromValue;
            break;
          case 'Miles per Gallon (Imp)':
            toValue = 453.59237 / fromValue;
            break;
          case 'Miles per Gallon (US)':
            toValue = 378.541178 / fromValue;
            break;
          case 'Nautical Miles per Litre':
            toValue = 173.5297946 / fromValue;
            break;
          case 'Kilometres per Gallon (US)': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Miles per Litre':
        switch (toUnit) {
          case 'Miles per Gallon (Imp)':
            toValue = fromValue * 2.824809364;
            break;
          case 'Kilometres per Litre':
            toValue = fromValue / 0.621371192;
            break;
          case 'Kilometres per Gallon (US)':
            toValue = fromValue / 0.621371192 * 3.785411784;
            break;
          case 'Litres per 100 km':
            toValue = 100.0 / (fromValue * 0.621371192);
            break;
          case 'Litres per 100 miles':
            toValue = 62.1371192 / fromValue;
            break;
          case 'Miles per Gallon (US)':
            toValue = 3.785411784 / (fromValue * 0.621371192);
            break;
          case 'Nautical Miles per Litre':
            toValue = 0.539956803 / (fromValue * 0.621371192);
            break;
          case 'Miles per Litre': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Miles per Gallon (Imp)':
        switch (toUnit) {
          case 'Miles per Litre':
            toValue = fromValue / 2.824809364;
            break;
          case 'Kilometres per Litre':
            toValue = fromValue / 0.2199692483;
            break;
          case 'Kilometres per Gallon (US)':
            toValue = fromValue / 0.2199692483 * 3.785411784;
            break;
          case 'Litres per 100 km':
            toValue = 100.0 / (fromValue * 0.2199692483);
            break;
          case 'Litres per 100 miles':
            toValue = 62.1371192 / (fromValue * 2.824809364);
            break;
          case 'Miles per Gallon (US)':
            toValue = 3.785411784 / (fromValue * 0.2199692483);
            break;
          case 'Nautical Miles per Litre':
            toValue = 0.539956803 / (fromValue * 0.2199692483);
            break;
          case 'Miles per Gallon (Imp)': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Miles per Gallon (US)':
        switch (toUnit) {
          case 'Nautical Miles per Litre':
            toValue = fromValue * 0.00153816462;
            break;
          case 'Miles per Litre':
            toValue = fromValue / 0.425143707;
            break;
          case 'Miles per Gallon (Imp)':
            toValue = fromValue * 0.832674185;
            break;
          case 'Kilometres per Litre':
            toValue = fromValue / 0.621371192;
            break;
          case 'Kilometres per Gallon (US)':
            toValue = fromValue / 0.621371192 * 3.785411784;
            break;
          case 'Litres per 100 km':
            toValue = 100.0 / (fromValue * 0.621371192);
            break;
          case 'Litres per 100 miles':
            toValue = 62.1371192 / fromValue;
            break;
          case 'Miles per Gallon (US)': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Nautical Miles per Litre':
        switch (toUnit) {
          case 'Miles per Gallon (US)':
            toValue = fromValue / 0.00153816462;
            break;
          case 'Miles per Litre':
            toValue = fromValue / 0.269978947;
            break;
          case 'Miles per Gallon (Imp)':
            toValue = fromValue * 0.556798828;
            break;
          case 'Kilometres per Litre':
            toValue = fromValue / 0.539956803;
            break;
          case 'Kilometres per Gallon (US)':
            toValue = fromValue / 0.539956803 * 3.785411784;
            break;
          case 'Litres per 100 km':
            toValue = 100.0 / (fromValue * 0.539956803);
            break;
          case 'Litres per 100 miles':
            toValue = 62.1371192 / (fromValue * 0.00153816462);
            break;
          case 'Nautical Miles per Litre': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      default:
        // Optionally handle unknown unit conversions
        toValue = 0;
        break;
    }

    // Update toController text and conversion formula only if necessary.
    if (_isUserInput) {
      setState(() {
        // Update the display with formatted or exponential number as needed.
        toController.text = _formatNumber(toValue, forDisplay: true);
        _conversionFormula = _getConversionFormula();
      });
    }
  }

  String _formatNumber(double value, {bool forDisplay = false}) {
    if (_isExponentialFormat && forDisplay) {
      // Return the number in exponential format.
      return value.toStringAsExponential(2);
    } else if (forDisplay) {
      // Format the number for display with commas and a sensible number of decimal places.
      NumberFormat numberFormat = NumberFormat.decimalPattern();
      return numberFormat.format(value);
    } else {
      // Return a plain string representation of the number for internal use.
      return value.toString();
    }
  }

  String _formatWithCommas(String integerPart) {
    // Use a buffer to build the formatted string for the integer part with commas.
    StringBuffer formattedInt = StringBuffer();
    int commaPosition = 3;
    int offset = integerPart.length % commaPosition;
    for (int i = 0; i < integerPart.length; i++) {
      if (i % commaPosition == 0 && i > 0) {
        formattedInt.write(',');
      }
      formattedInt.write(integerPart[i]);
    }
    return formattedInt.toString();
  }

  void _handleInputFormatting(TextEditingController controller,
      {bool forDisplay = false}) {
    String text = controller.text;
    if (text.isNotEmpty) {
      // Allow for a single decimal point or comma in the input
      if ((text.contains('.') && text.indexOf('.') != text.length - 1) ||
          (text.contains(',') && text.indexOf(',') != text.length - 1)) {
        try {
          String normalizedText = text.replaceAll(',', '.');
          double value = double.parse(normalizedText);
          _isUserInput = false;
          String formattedText = _formatNumber(value, forDisplay: forDisplay);
          controller.value = TextEditingValue(
            text: formattedText,
            selection: TextSelection.collapsed(offset: formattedText.length),
          );
        } catch (e) {
          // Handle parsing error, if any.
        } finally {
          _isUserInput = true;
        }
      }
    }
  }

  void swapUnits() {
    setState(() {
      String tempUnit = fromUnit;
      String tempPrefix = fromPrefix;

      // Swap only the units and prefixes, not the values in the TextFields.
      fromUnit = toUnit;
      fromPrefix = toPrefix;

      toUnit = tempUnit;
      toPrefix = tempPrefix;

      // We do not switch the text values of the controllers anymore.
      // fromController.text and toController.text remain unchanged.

      String unformattedText = fromController.text.replaceAll(',', '');
      convert(unformattedText);
      _conversionFormula =
          _getConversionFormula(); // Update formula text if needed
    });
  }

  String _getConversionFormula() {
    String formula;
    switch (fromUnit) {
      // Litres per 100 km
      case 'Litres per 100 km':
        switch (toUnit) {
          case 'Litres per 100 miles':
            formula = 'Multiply the value by 2.35215';
            break;
          case 'Kilometres per Litre':
            formula = 'Divide 100 by the value';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'Divide 235.215 by the value';
            break;
          case 'Miles per Litre':
            formula = 'Divide 62.1371 by the value';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'Divide 282.481 by the value';
            break;
          case 'Miles per Gallon (US)':
            formula = 'Divide 235.215 by the value';
            break;
          case 'Nautical Miles per Litre':
            formula = 'Divide 54.0551 by the value';
            break;
          case 'Litres per 100 km':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// Litres per 100 miles
      case 'Litres per 100 miles':
        switch (toUnit) {
          case 'Litres per 100 km':
            formula = 'Multiply the value by 0.425144';
            break;
          case 'Kilometres per Litre':
            formula = 'Multiply the value by 2.35215';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'Multiply the value by 59.7052';
            break;
          case 'Miles per Litre':
            formula = 'Multiply the value by 15.68';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'Multiply the value by 3.78541';
            break;
          case 'Miles per Gallon (US)':
            formula = 'Multiply the value by 2.35215';
            break;
          case 'Nautical Miles per Litre':
            formula = 'Multiply the value by 4.80266';
            break;
          case 'Litres per 100 miles':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// Kilometres per Litre
      case 'Kilometres per Litre':
        switch (toUnit) {
          case 'Litres per 100 km':
            formula = 'Divide 100 by the value';
            break;
          case 'Litres per 100 miles':
            formula = 'Multiply the value by 0.425144';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'Multiply the value by 3.78541';
            break;
          case 'Miles per Litre':
            formula = 'Divide 1.60934 by the value';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'Divide 4.54609 by the value';
            break;
          case 'Miles per Gallon (US)':
            formula = 'Divide 3.78541 by the value';
            break;
          case 'Nautical Miles per Litre':
            formula = 'Divide 1.852 by the value';
            break;
          case 'Kilometres per Litre':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// Kilometres per Gallon (US)
      case 'Kilometres per Gallon (US)':
        switch (toUnit) {
          case 'Litres per 100 km':
            formula = 'Divide 235.215 by the value';
            break;
          case 'Litres per 100 miles':
            formula = 'Divide 59.7052 by the value';
            break;
          case 'Kilometres per Litre':
            formula = 'Divide 3.78541 by the value';
            break;
          case 'Miles per Litre':
            formula = 'Multiply the value by 0.621371';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'Multiply the value by 1.20095';
            break;
          case 'Miles per Gallon (US)':
            formula = 'The value remains unchanged';
            break;
          case 'Nautical Miles per Litre':
            formula = 'Divide 1.15078 by the value';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// Miles per Litre
      case 'Miles per Litre':
        switch (toUnit) {
          case 'Litres per 100 km':
            formula = 'Divide 62.1371 by the value';
            break;
          case 'Litres per 100 miles':
            formula = 'Multiply the value by 100';
            break;
          case 'Kilometres per Litre':
            formula = 'Multiply the value by 1.60934';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'Divide 2.35215 by the value';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'Multiply the value by 1.20095';
            break;
          case 'Miles per Gallon (US)':
            formula = 'Multiply the value by 0.832674';
            break;
          case 'Nautical Miles per Litre':
            formula = 'Divide 54.6881 by the value';
            break;
          case 'Miles per Litre':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// Miles per Gallon (Imp)
      case 'Miles per Gallon (Imp)':
        switch (toUnit) {
          case 'Litres per 100 km':
            formula = 'Divide 41.4022 by the value';
            break;
          case 'Litres per 100 miles':
            formula = 'Multiply the value by 62.1371';
            break;
          case 'Kilometres per Litre':
            formula = 'Divide 1.20095 by the value';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'Divide 0.832674 by the value';
            break;
          case 'Miles per Litre':
            formula = 'Divide 1.20095 by the value';
            break;
          case 'Miles per Gallon (US)':
            formula = 'Multiply the value by 1.20095';
            break;
          case 'Nautical Miles per Litre':
            formula = 'Divide 0.998214 by the value';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// Miles per Gallon (US)
      case 'Miles per Gallon (US)':
        switch (toUnit) {
          case 'Litres per 100 km':
            formula = 'Divide 235.215 by the value';
            break;
          case 'Litres per 100 miles':
            formula = 'Divide 100 by the value';
            break;
          case 'Kilometres per Litre':
            formula = 'Divide 0.621371 by the value';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'Divide 0.832674 by the value';
            break;
          case 'Miles per Litre':
            formula = 'Divide 1.20095 by the value';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'Divide 1.20095 by the value';
            break;
          case 'Nautical Miles per Litre':
            formula = 'Divide 1.15078 by the value';
            break;
          case 'Miles per Gallon (US)':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// Nautical Miles per Litre
      case 'Nautical Miles per Litre':
        switch (toUnit) {
          case 'Litres per 100 km':
            formula = 'Divide 206.185 by the value';
            break;
          case 'Litres per 100 miles':
            formula = 'Multiply the value by 100';
            break;
          case 'Kilometres per Litre':
            formula = 'Divide 0.539956 by the value';
            break;
          case 'Kilometres per Gallon (US)':
            formula = 'Multiply the value by 0.868976';
            break;
          case 'Miles per Litre':
            formula = 'Multiply the value by 1.15078';
            break;
          case 'Miles per Gallon (Imp)':
            formula = 'Multiply the value by 0.998214';
            break;
          case 'Nautical Miles per Litre':
            formula = 'The value remains unchanged';
            break;
          case 'Miles per Gallon (US)':
            formula = 'Multiply the value by 0.868976';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

      default:
        formula = 'No conversion formula available for the selected units';
    }
    return formula;
  }

  void copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Conversion result copied to clipboard!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: const Color(0xFF464648),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20), // Adjust space as needed
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      context.navigateTo(
                          '/unit'); // Assuming you have this route defined somewhere
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                      width: 25), // Space between the icon and the text
                  const Text(
                    'Convert Fuel Consumption',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 150),
              // Inserted just before the 'From' input field
              SwitchListTile(
                title: const Text(
                  'See result in exponential format',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                value: _isExponentialFormat,
                onChanged: (bool value) {
                  setState(() {
                    _isExponentialFormat = value;
                    // Force the text to update with the new formatting.
                    double? lastValue = double.tryParse(
                        fromController.text.replaceAll(',', ''));
                    if (lastValue != null) {
                      fromController.text =
                          _formatNumber(lastValue, forDisplay: true);
                    }
                    // Re-trigger conversion to update the toController with formatted text.
                    convert(fromController.text);
                  });
                },
                activeColor: Colors.lightBlue,
                activeTrackColor: Colors.lightBlue.shade200,
              ),

              const SizedBox(height: 10),
              // Adjusted layout for 'From' input and dropdown
              Container(
                padding: const EdgeInsets.only(left: 0.125, right: 0.125),
                width: double.infinity,
                child: _buildUnitColumn(
                    'From', fromController, fromUnit, fromPrefix, true),
              ),
              // Switch icon in vertical orientation
              IconButton(
                icon: const Icon(
                  Icons.swap_vert,
                  color: Color.fromARGB(255, 183, 218, 234),
                  size: 40,
                ),
                onPressed: swapUnits,
              ),
              // Adjusted layout for 'To' input and dropdown
              Container(
                padding: const EdgeInsets.only(left: 0.125, right: 0.125),
                width: double.infinity,
                child: _buildUnitColumn(
                    'To', toController, toUnit, toPrefix, false),
              ),
              const SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Formula:  ',
                      style: TextStyle(
                        color:
                            Colors.orange, // Set the color for 'Hola' to white
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          _conversionFormula, // Keep the original formula style
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // Add this IconButton where you want the reset button to appear
          ),
        ),
        floatingActionButton: Container(
          margin:
              const EdgeInsets.only(bottom: 50), // Adjust the margin as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Reset button - this can be styled as needed
              FloatingActionButton(
                heroTag: 'resetButton', // Unique tag for this FAB
                onPressed: _resetToDefault,
                backgroundColor: Colors.red,
                child: const Icon(Icons.restart_alt,
                    size: 36, color: Colors.white),
              ),
              // Share button
              FloatingActionButton(
                heroTag: 'shareButton', // Unique tag for this FAB
                onPressed: _takeScreenshotAndShare,
                backgroundColor: Colors.white,
                child: const Icon(Icons.share, size: 36, color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  String _getPrefix(String unit) {
    switch (unit) {
      case 'Litres per 100 km':
        return 'L/100 km';
      case 'Litres per 100 miles':
        return 'L/100 mi';
      case 'Kilometres per Litre':
        return 'km/L';
      case 'Kilometres per Gallon (US)':
        return 'km/gal (US)';
      case 'Miles per Litre':
        return 'mi/L';
      case 'Miles per Gallon (Imp)':
        return 'mpg (Imp)';
      case 'Miles per Gallon (US)':
        return 'mpg (US)';
      case 'Nautical Miles per Litre':
        return 'nmi/L';
      default:
        return ''; // In case the unit is not recognized
    }
  }

  // Update the _buildUnitColumn method to include padding and width requirements
  Widget _buildUnitColumn(String label, TextEditingController controller,
      String unit, String prefix, bool isFrom) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 0.125), // 12.5% padding from each side
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            onChanged: (value) {
              // Only invoke formatting when the user has stopped typing.
              // Remove the auto-formatting logic from here.
              _isUserInput =
                  true; // Set this flag to true to indicate user input.
              convert(
                  value); // Call convert directly with the current input value.
            },
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: label, // Keep the label
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 3.0),
              ),
              //floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              isDense: true,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    '$prefix ',
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  // You can add more Widgets here if you need to
                ],
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.content_copy),
                onPressed: () => copyToClipboard(controller.text, context),
              ),
            ),
          ),

          const SizedBox(
              height: 10), // Space between the TextField and dropdown
          _buildDropdownButton(label.toLowerCase(), unit, isFrom),
        ],
      ),
    );
  }

  // Correct the method signature by adding the isFrom parameter
  Widget _buildDropdownButton(String type, String currentValue, bool isFrom) {
    List<DropdownMenuItem<String>> items = <String>[
      'Litres per 100 km',
      'Litres per 100 miles',
      'Kilometres per Litre',
      'Kilometres per Gallon (US)',
      'Miles per Litre',
      'Miles per Gallon (Imp)',
      'Miles per Gallon (US)',
      'Nautical Miles per Litre',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          '${_getPrefix(value)} - $value',
          style: const TextStyle(
            color: Color(0xFF9CC0C5),
            fontSize: 23,
          ),
          overflow: TextOverflow.visible,
        ),
      );
    }).toList();

    items.insert(
      0,
      const DropdownMenuItem<String>(
        value: '',
        enabled: false,
        child: Text(
          'Choose a conversion unit',
          style: TextStyle(color: Colors.grey, fontSize: 23),
        ),
      ),
    );

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: const Color(0xFF303134),
      ),
      value: currentValue.isNotEmpty ? currentValue : null,
      hint: const Text(
        'Choose a conversion unit',
        style: TextStyle(color: Colors.grey, fontSize: 23),
        textAlign: TextAlign.center,
      ),
      onChanged: (String? newValue) {
        if (newValue != null && newValue.isNotEmpty) {
          setState(() {
            if (isFrom) {
              fromUnit = newValue;
              fromPrefix = _getPrefix(newValue);
            } else {
              toUnit = newValue;
              toPrefix = _getPrefix(newValue);
            }
            // Do not clear the text fields here to retain the input value
            // Trigger the conversion logic if needed with the new unit but same value
            convert(fromController.text);
          });
        }
      },
      dropdownColor: const Color(0xFF303134),
      items: items,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      iconSize: 24,
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((DropdownMenuItem<String> item) {
          return Center(
            child: Text(
              item.value == '' ? 'Choose a conversion unit' : item.value!,
              style: const TextStyle(
                color: Color(0xFF9CC0C5),
                fontSize: 23,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}

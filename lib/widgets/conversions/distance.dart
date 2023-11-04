// ignore_for_file: library_private_types_in_public_api
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DistanceUnitConverter extends StatefulWidget {
  const DistanceUnitConverter({super.key});

  @override
  _DistanceUnitConverterState createState() => _DistanceUnitConverterState();
}

class _DistanceUnitConverterState extends State<DistanceUnitConverter> {
  String fromUnit = 'Meters';
  String toUnit = 'Centimeters';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  // Using string variables for prefixes
  String fromPrefix = 'm';
  String toPrefix = 'cm';
  final ScreenshotController screenshotController = ScreenshotController();
  String _conversionFormula = '';
  @override
  void initState() {
    super.initState();
    // Add the convert function as a listener to both text controllers.
    fromController.addListener(convert);
    toController.addListener(convert);
    // Initialize the conversion formula text
    _conversionFormula = _getConversionFormula();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
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
          text: 'Check out my distance result!');
    }
  }

  void convert() {
    if (fromController.text.isEmpty) return;
    var fromValue = double.tryParse(fromController.text);
    if (fromValue == null)
      return; // If it can't be parsed into a number, return.
    double toValue = 0; // Initialize toValue to a default value
    // Conversion constants
    const double meterToCentimeter = 100;
    const double meterToPicometer = 1e12;
    const double meterToNanometer = 1e9;
    const double meterToMicrometer = 1e6;
    const double meterToMillimeter = 1e3;
    const double meterToKilometer = 1e-3;
    const double meterToAngstrom = 1e10;
    const double meterToThou = 39370.0787;
    const double meterToInch = 39.3700787;
    const double meterToFoot = 3.2808399;
    const double meterToYard = 1.0936133;
    const double meterToChain = 0.0497097;
    const double meterToFurlong = 0.00497097;
    const double meterToMile = 0.000621371;
    const double meterToFathom = 0.546806649;
    const double meterToCable = 0.005399568;
    const double meterToNauticalMile = 0.000539957;
    const double meterToAstronomicalUnit = 6.68458712e-12;
    const double meterToParsec = 3.24077929e-17;

    switch (fromUnit) {
      case 'Meters':
        switch (toUnit) {
          case 'Centimeters':
            toValue = fromValue * meterToCentimeter;
            break;

          case 'Picometers':
            toValue = fromValue * meterToPicometer;
            break;
          case 'Nanometers':
            toValue = fromValue * meterToNanometer;
            break;
          case 'Micrometers':
            toValue = fromValue * meterToMicrometer;
            break;
          case 'Millimeters':
            toValue = fromValue * meterToMillimeter;
            break;
          case 'Kilometers':
            toValue = fromValue * meterToKilometer;
            break;
          case 'Angstrom':
            toValue = fromValue * meterToAngstrom;
            break;
          case 'Thou':
            toValue = fromValue * meterToThou;
            break;
          case 'Inches':
            toValue = fromValue * meterToInch;
            break;
          case 'Feet':
            toValue = fromValue * meterToFoot;
            break;
          case 'Yards':
            toValue = fromValue * meterToYard;
            break;
          case 'Chains':
            toValue = fromValue * meterToChain;
            break;
          case 'Furlongs':
            toValue = fromValue * meterToFurlong;
            break;
          case 'Miles':
            toValue = fromValue * meterToMile;
            break;
          case 'Fathoms':
            toValue = fromValue * meterToFathom;
            break;
          case 'Cables':
            toValue = fromValue * meterToCable;
            break;
          case 'Nautical miles':
            toValue = fromValue * meterToNauticalMile;
            break;
          case 'Astronomical units':
            toValue = fromValue * meterToAstronomicalUnit;
            break;
          case 'Parsecs':
            toValue = fromValue * meterToParsec;
            break;
          default:
            return;
        }
        break;
      case 'Picometers':
        toValue = toUnit == 'Meters' ? fromValue / meterToPicometer : 0;
        break;

      case 'Centimeters':
        toValue = toUnit == 'Meters' ? fromValue / meterToCentimeter : 0;
        break;
      case 'Nanometers':
        toValue = toUnit == 'Meters' ? fromValue / meterToNanometer : 0;
        break;
      case 'Micrometers':
        toValue = toUnit == 'Meters' ? fromValue / meterToMicrometer : 0;
        break;

      case 'Millimeters':
        toValue = toUnit == 'Meters' ? fromValue / meterToMillimeter : 0;
        break;
      case 'Kilometers':
        toValue = toUnit == 'Meters' ? fromValue / meterToKilometer : 0;
        break;
      case 'Angstrom':
        toValue = toUnit == 'Meters' ? fromValue / meterToAngstrom : 0;
        break;
      case 'Thou':
        toValue = toUnit == 'Meters' ? fromValue / meterToThou : 0;
        break;
      case 'Inches':
        toValue = toUnit == 'Meters' ? fromValue / meterToInch : 0;
        break;
      case 'Feet':
        toValue = toUnit == 'Meters' ? fromValue / meterToFoot : 0;
        break;
      case 'Yards':
        toValue = toUnit == 'Meters' ? fromValue / meterToYard : 0;
        break;
      case 'Chains':
        toValue = toUnit == 'Meters' ? fromValue / meterToChain : 0;
        break;
      case 'Furlongs':
        toValue = toUnit == 'Meters' ? fromValue / meterToFurlong : 0;
        break;
      case 'Miles':
        toValue = toUnit == 'Meters' ? fromValue / meterToMile : 0;
        break;
      case 'Fathoms':
        toValue = toUnit == 'Meters' ? fromValue / meterToFathom : 0;
        break;
      case 'Cables':
        toValue = toUnit == 'Meters' ? fromValue / meterToCable : 0;
        break;
      case 'Nautical miles':
        toValue = toUnit == 'Meters' ? fromValue / meterToNauticalMile : 0;
        break;
      case 'Astronomical units':
        toValue = toUnit == 'Meters' ? fromValue / meterToAstronomicalUnit : 0;
        break;
      case 'Parsecs':
        toValue = toUnit == 'Meters' ? fromValue / meterToParsec : 0;
        break;
      // ... (other reverse cases)

      // Add all the other cases for the reverse conversions similarly
      // ...
      // Add more cases here
      default:
        // Optional: Handle an unknown unit conversion or set toValue as zero
        toValue = 0;
        break;
    }

    setState(() {
      toController.text = _formatNumber(toValue);
      _conversionFormula =
          _getConversionFormula(); // Make sure this function handles the new units
    });
  }

  String _formatNumber(double value) {
    String str = value.toStringAsFixed(10); // Adjust the precision as needed
    // RegExp pattern to remove trailing zeros and optionally the decimal point
    RegExp regExp = RegExp(r"([.]*0+)(?!.*\d)");
    str = str.replaceAll(regExp, '');
    return str;
  }

  void swapUnits() {
    setState(() {
      String tempUnit = fromUnit;
      String tempPrefix = fromPrefix;
      String tempValue = fromController.text;

      fromUnit = toUnit;
      fromPrefix = toPrefix;
      fromController.text = toController.text;

      toUnit = tempUnit;
      toPrefix = tempPrefix;
      toController.text = tempValue;

      convert();
      _conversionFormula = _getConversionFormula(); // Update formula text
    });
  }

  String _getConversionFormula() {
    String formula;
    switch (fromUnit) {
      case 'Meters':
        switch (toUnit) {
          case 'Picometers':
            formula = 'Multiply the length value by 1,000,000,000,000';
            break;
          case 'Nanometers':
            formula = ''; // Add the appropriate formula text
            break;
          case 'Micrometers':
            formula = ''; // Add the appropriate formula text
            break;
          case 'Millimeters':
            formula = ''; // Add the appropriate formula text
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 100';
            break;
          case 'Kilometers':
            formula = ''; // Add the appropriate formula text
            break;
          // ... Continue for all units
          default:
            formula = 'Unknown conversion';
        }
        break;
      case 'Picometers':
        switch (toUnit) {
          case 'Meters':
            formula = 'Divide the length value by 1,000,000,000,000';
            break;
          // Add other cases for Picometers to other units
          // ...
          default:
            formula = 'Unknown conversion';
        }
        break;
      // ... Repeat the same structure for all initial units
      default:
        formula = 'Select both units to see the formula';
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
                      width: 50), // Space between the icon and the text
                  const Text(
                    'Convert Distance',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 270), // Adjust space as needed
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUnitColumn('From', fromController, fromUnit, fromPrefix,
                      true), // for 'From' column
                  IconButton(
                    icon: const Icon(
                      Icons
                          .swap_horiz, // Changed to swap_vert for a more intuitive design
                      color: Color.fromARGB(255, 183, 218, 234),
                      size: 40,
                    ), // Size increased
                    onPressed: swapUnits,
                  ),
                  _buildUnitColumn('To', toController, toUnit, toPrefix,
                      false), // for 'To' column
                ],
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _takeScreenshotAndShare, // Updated to the new function
          backgroundColor: Colors.white,
          child: const Icon(Icons.share, size: 36, color: Colors.black),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  String _getPrefix(String unit) {
    switch (unit) {
      case 'Picometers':
        return 'pm';
      case 'Nanometers':
        return 'nm'; // Example text
      case 'Micrometers':
        return 'µm'; // Just an example icon
      case 'Millimeters':
        return 'mm';
      case 'Centimeters':
        return 'cm'; // Just an example icon
      case 'Meters':
        return 'm';
      case 'Kilometers':
        return 'km'; // Just an example icon
      case 'Angstrom':
        return 'Å';
      case 'Thou':
        return 'thou';
      case 'Inches':
        return 'in'; // Just an example icon
      case 'Feet':
        return 'ft';
      case 'Yards':
        return 'yd'; // Just an example icon
      case 'Chains':
        return 'ch';
      case 'Furlongs':
        return 'fur';
      case 'Miles':
        return 'mi'; // Just an example icon
      case 'Fathoms':
        return 'fth';
      case 'Cables':
        return 'cable'; // Just an example icon
      case 'Nautical miles':
        return 'NM';
      case 'Astronomical units':
        return 'au';
      case 'Light years':
        return 'ly'; // Just an example icon
      case 'Parsecs':
        return 'pc';

      default:
        return '';
    }
  }

  Widget _buildUnitColumn(String label, TextEditingController controller,
      String unit, String prefix, bool isFrom) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onSubmitted: (value) =>
                convert(), // Use your existing convert function
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
          _buildDropdownButton(label.toLowerCase(), unit, isFrom),
        ],
      ),
    );
  }

  // Correct the method signature by adding the isFrom parameter
  Widget _buildDropdownButton(String type, String currentValue, bool isFrom) {
    List<DropdownMenuItem<String>> items = <String>[
      'Picometers',
      'Nanometers',
      'Micrometers',
      'Millimeters',
      'Centimeters',
      'Meters',
      'Kilometers',
      'Angstrom',
      'Thou',
      'Inches',
      'Feet',
      'Yards',
      'Chains',
      'Furlongs',
      'Miles',
      'Fathoms',
      'Cables',
      'Nautical miles',
      'Astronomical units',
      'Light years',
      'Parsecs',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '${_getPrefix(value)} - $value',
                style: const TextStyle(
                  color: Color(0xFF9CC0C5),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                overflow:
                    TextOverflow.ellipsis, // Use ellipsis for text overflow
              ),
            ),
          ],
        ),
      );
    }).toList();

    // Corrected to return DropdownButtonFormField with the proper items.
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        // This will integrate the DropdownButtonFormField within the InputDecoration
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: const Color(0xFF303134),
        // You can adjust other styling as needed
      ),
      value: currentValue,
      icon: const Icon(Icons.arrow_downward, color: Colors.white, size: 23),
      elevation: 14,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          if (isFrom) {
            fromUnit = newValue!;
            fromController.clear();
            fromPrefix = _getPrefix(
                newValue); // Update the prefix for the 'from' TextField
          } else {
            toUnit = newValue!;
            toController.clear();
            toPrefix = _getPrefix(
                newValue); // Update the prefix for the 'to' TextField
          }
          convert();
        });
      },
      dropdownColor: const Color(0xFF303134),
      items: items,
    );
  }
}

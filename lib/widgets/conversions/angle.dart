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

class AngleUnitConverter extends StatefulWidget {
  const AngleUnitConverter({super.key});

  @override
  _AngleUnitConverterState createState() => _AngleUnitConverterState();
}

class _AngleUnitConverterState extends State<AngleUnitConverter> {
  String fromUnit = 'Radians';
  String toUnit = 'Gradians';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool _isExponentialFormat = false;
  // Flag to indicate if the change is due to user input
  bool _isUserInput = true;
  // Using string variables for prefixes
  String fromPrefix = 'rad';
  String toPrefix = 'grad';
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
          text: 'Check out my angle conversion result!');
    }
  }

  void convert(String text) {
    String normalizedText = text.replaceAll(',', '.');
    if (normalizedText.isEmpty) return;
    var fromValue = double.tryParse(normalizedText);
    if (fromValue == null) return;
    double toValue = 0; // Your conversion logic here

    switch (fromUnit) {
      case 'Radians':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue;
            break;
          case 'Gradians':
            toValue = fromValue * 63.66197723677;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 1145.9155902616;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 68974.9346157;
            break;
          case 'Turns':
            toValue = fromValue * 0.15915494309;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.15915494309;
            break;
          case 'Circles':
            toValue = fromValue * 0.15915494309;
            break;
          case 'Quadrants':
            toValue = fromValue * 4.0;
            break;
          case 'Sextants':
            toValue = fromValue * 6.0;
            break;
          case 'Octants':
            toValue = fromValue * 8.0;
            break;
          case 'Signs':
            toValue = fromValue * 12.0;
            break;
          case 'Binary degrees':
            toValue = fromValue * 101.25;
            break;
          case 'Milliradians':
            toValue = fromValue * 1000.0;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 101.25;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Gradians':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.01570796327;
            break;
          case 'Gradians':
            toValue = fromValue;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 17.777777777778;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 1066.6666666667;
            break;
          case 'Turns':
            toValue = fromValue * 0.0025;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.0025;
            break;
          case 'Circles':
            toValue = fromValue * 0.0025;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.25;
            break;
          case 'Sextants':
            toValue = fromValue * 0.375;
            break;
          case 'Octants':
            toValue = fromValue * 0.5;
            break;
          case 'Signs':
            toValue = fromValue * 0.75;
            break;
          case 'Binary degrees':
            toValue = fromValue * 6.75;
            break;
          case 'Milliradians':
            toValue = fromValue * 16.0;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 6.75;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Minutes of arc':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.00029088820867;
            break;
          case 'Gradians':
            toValue = fromValue * 0.0011111111111;
            break;
          case 'Minutes of arc':
            toValue = fromValue;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 60.0;
            break;
          case 'Turns':
            toValue = fromValue * 0.0000048481368;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.0000048481368;
            break;
          case 'Circles':
            toValue = fromValue * 0.0000048481368;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.00027777777778;
            break;
          case 'Sextants':
            toValue = fromValue * 0.00041666666667;
            break;
          case 'Octants':
            toValue = fromValue * 0.00055555555556;
            break;
          case 'Signs':
            toValue = fromValue * 0.00083333333333;
            break;
          case 'Binary degrees':
            toValue = fromValue * 0.0075;
            break;
          case 'Milliradians':
            toValue = fromValue * 5.1444444444;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 0.3;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Seconds of arc':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.0000048481368;
            break;
          case 'Gradians':
            toValue = fromValue * 0.0000185185185;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 0.016666666667;
            break;
          case 'Seconds of arc':
            toValue = fromValue;
            break;
          case 'Turns':
            toValue = fromValue * 0.0000000808022;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.0000000808022;
            break;
          case 'Circles':
            toValue = fromValue * 0.0000000808022;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.0000046296296;
            break;
          case 'Sextants':
            toValue = fromValue * 0.0000069444444;
            break;
          case 'Octants':
            toValue = fromValue * 0.0000092592593;
            break;
          case 'Signs':
            toValue = fromValue * 0.0000138888889;
            break;
          case 'Binary degrees':
            toValue = fromValue * 0.000125;
            break;
          case 'Milliradians':
            toValue = fromValue * 0.086666666667;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 0.005;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Turns':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 6.2831853072;
            break;
          case 'Gradians':
            toValue = fromValue * 40.0;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 360.0;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 21600.0;
            break;
          case 'Turns':
            toValue = fromValue;
            break;
          case 'Revolutions':
            toValue = fromValue * 1.0;
            break;
          case 'Circles':
            toValue = fromValue * 1.0;
            break;
          case 'Quadrants':
            toValue = fromValue * 4.0;
            break;
          case 'Sextants':
            toValue = fromValue * 6.0;
            break;
          case 'Octants':
            toValue = fromValue * 8.0;
            break;
          case 'Signs':
            toValue = fromValue * 12.0;
            break;
          case 'Binary degrees':
            toValue = fromValue * 90.0;
            break;
          case 'Milliradians':
            toValue = fromValue * 6283.1853072;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 360.0;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Revolutions':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 6.2831853072;
            break;
          case 'Gradians':
            toValue = fromValue * 400.0;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 360.0;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 21600.0;
            break;
          case 'Turns':
            toValue = fromValue * 1.0;
            break;
          case 'Revolutions':
            toValue = fromValue;
            break;
          case 'Circles':
            toValue = fromValue * 1.0;
            break;
          case 'Quadrants':
            toValue = fromValue * 4.0;
            break;
          case 'Sextants':
            toValue = fromValue * 6.0;
            break;
          case 'Octants':
            toValue = fromValue * 8.0;
            break;
          case 'Signs':
            toValue = fromValue * 12.0;
            break;
          case 'Binary degrees':
            toValue = fromValue * 90.0;
            break;
          case 'Milliradians':
            toValue = fromValue * 6283.1853072;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 360.0;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Circles':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 6.2831853072;
            break;
          case 'Gradians':
            toValue = fromValue * 40.0;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 360.0;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 21600.0;
            break;
          case 'Turns':
            toValue = fromValue * 1.0;
            break;
          case 'Revolutions':
            toValue = fromValue * 1.0;
            break;
          case 'Circles':
            toValue = fromValue;
            break;
          case 'Quadrants':
            toValue = fromValue * 4.0;
            break;
          case 'Sextants':
            toValue = fromValue * 6.0;
            break;
          case 'Octants':
            toValue = fromValue * 8.0;
            break;
          case 'Signs':
            toValue = fromValue * 12.0;
            break;
          case 'Binary degrees':
            toValue = fromValue * 90.0;
            break;
          case 'Milliradians':
            toValue = fromValue * 6283.1853072;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 360.0;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Quadrants':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 1.5707963268;
            break;
          case 'Gradians':
            toValue = fromValue * 100.0;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 90.0;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 5400.0;
            break;
          case 'Turns':
            toValue = fromValue * 0.25;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.25;
            break;
          case 'Circles':
            toValue = fromValue * 0.25;
            break;
          case 'Quadrants':
            toValue = fromValue;
            break;
          case 'Sextants':
            toValue = fromValue * 1.5;
            break;
          case 'Octants':
            toValue = fromValue * 2.0;
            break;
          case 'Signs':
            toValue = fromValue * 3.0;
            break;
          case 'Binary degrees':
            toValue = fromValue * 22.5;
            break;
          case 'Milliradians':
            toValue = fromValue * 1570.7963268;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 90.0;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Sextants':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 1.0471975512;
            break;
          case 'Gradians':
            toValue = fromValue * 66.6666666667;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 60.0;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 3600.0;
            break;
          case 'Turns':
            toValue = fromValue * 0.1666666667;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.1666666667;
            break;
          case 'Circles':
            toValue = fromValue * 0.1666666667;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.5;
            break;
          case 'Sextants':
            toValue = fromValue;
            break;
          case 'Octants':
            toValue = fromValue * 1.3333333333;
            break;
          case 'Signs':
            toValue = fromValue * 2.0;
            break;
          case 'Binary degrees':
            toValue = fromValue * 15.0;
            break;
          case 'Milliradians':
            toValue = fromValue * 1047.1975512;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 60.0;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Octants':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.7853981634;
            break;
          case 'Gradians':
            toValue = fromValue * 50.0;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 45.0;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 2700.0;
            break;
          case 'Turns':
            toValue = fromValue * 0.125;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.125;
            break;
          case 'Circles':
            toValue = fromValue * 0.125;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.375;
            break;
          case 'Sextants':
            toValue = fromValue * 0.75;
            break;
          case 'Octants':
            toValue = fromValue;
            break;
          case 'Signs':
            toValue = fromValue * 1.5;
            break;
          case 'Binary degrees':
            toValue = fromValue * 11.25;
            break;
          case 'Milliradians':
            toValue = fromValue * 785.3981634;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 45.0;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Signs':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.3926990817;
            break;
          case 'Gradians':
            toValue = fromValue * 25.0;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 22.5;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 1350.0;
            break;
          case 'Turns':
            toValue = fromValue * 0.0625;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.0625;
            break;
          case 'Circles':
            toValue = fromValue * 0.0625;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.1875;
            break;
          case 'Sextants':
            toValue = fromValue * 0.375;
            break;
          case 'Octants':
            toValue = fromValue * 0.75;
            break;
          case 'Signs':
            toValue = fromValue;
            break;
          case 'Binary degrees':
            toValue = fromValue * 7.5;
            break;
          case 'Milliradians':
            toValue = fromValue * 392.6990817;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 22.5;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Binary degrees':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.0523598776;
            break;
          case 'Gradians':
            toValue = fromValue * 3.3333333333;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 3.0;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 180.0;
            break;
          case 'Turns':
            toValue = fromValue * 0.0083333333;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.0083333333;
            break;
          case 'Circles':
            toValue = fromValue * 0.0083333333;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.025;
            break;
          case 'Sextants':
            toValue = fromValue * 0.05;
            break;
          case 'Octants':
            toValue = fromValue * 0.1;
            break;
          case 'Signs':
            toValue = fromValue * 0.1333333333;
            break;
          case 'Binary degrees':
            toValue = fromValue;
            break;
          case 'Milliradians':
            toValue = fromValue * 52.3598776;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 3.0;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Milliradians':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.001;
            break;
          case 'Gradians':
            toValue = fromValue * 0.0636619772;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 0.0572957795;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 3.4377467708;
            break;
          case 'Turns':
            toValue = fromValue * 0.0001591549;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.0001591549;
            break;
          case 'Circles':
            toValue = fromValue * 0.0001591549;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.0004774647;
            break;
          case 'Sextants':
            toValue = fromValue * 0.0009549295;
            break;
          case 'Octants':
            toValue = fromValue * 0.0019098591;
            break;
          case 'Signs':
            toValue = fromValue * 0.0025464788;
            break;
          case 'Binary degrees':
            toValue = fromValue * 20.0;
            break;
          case 'Milliradians':
            toValue = fromValue;
            break;
          case 'Mils (NATO)':
            toValue = fromValue * 17.7777777778;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Mils (NATO)':
        switch (toUnit) {
          case 'Radians':
            toValue = fromValue * 0.0000888889;
            break;
          case 'Gradians':
            toValue = fromValue * 0.005;
            break;
          case 'Minutes of arc':
            toValue = fromValue * 0.0047746487;
            break;
          case 'Seconds of arc':
            toValue = fromValue * 0.2864789244;
            break;
          case 'Turns':
            toValue = fromValue * 0.0000134908;
            break;
          case 'Revolutions':
            toValue = fromValue * 0.0000134908;
            break;
          case 'Circles':
            toValue = fromValue * 0.0000134908;
            break;
          case 'Quadrants':
            toValue = fromValue * 0.0000404723;
            break;
          case 'Sextants':
            toValue = fromValue * 0.0000809446;
            break;
          case 'Octants':
            toValue = fromValue * 0.0001618892;
            break;
          case 'Signs':
            toValue = fromValue * 0.0002158523;
            break;
          case 'Binary degrees':
            toValue = fromValue * 1.125;
            break;
          case 'Milliradians':
            toValue = fromValue * 0.05625;
            break;
          case 'Mils (NATO)':
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
// DEGREES
      case 'Degrees':
        switch (toUnit) {
          case 'Radians':
            formula = 'Multiply the angle value by (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by (10/9)';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 60';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 3600';
            break;
          case 'Turns':
            formula = 'Divide the angle value by 360';
            break;
          case 'Revolutions':
            formula = 'Divide the angle value by 360';
            break;
          case 'Circles':
            formula = 'Divide the angle value by 360';
            break;
          case 'Quadrants':
            formula = 'Divide the angle value by 90';
            break;
          case 'Sextants':
            formula = 'Divide the angle value by 60';
            break;
          case 'Octants':
            formula = 'Divide the angle value by 45';
            break;
          case 'Signs':
            formula = 'Divide the angle value by 30';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 5120';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by (π/180) * 1000';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 17.7778';
            break;
          case 'Degrees':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// RADIANS
      case 'Radians':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by (180/π)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by (180/π) * (10/9)';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by (180/π) * 60';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by (180/π) * 3600';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by (1/2π)';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by (1/2π)';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by (1/2π)';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by (1/π) * 2';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by (1/π) * 3';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by (1/π) * 4';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by (1/π) * 6';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by (180/π) * 5120';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 1000';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by (180/π) * 17.7778';
            break;
          case 'Radians':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// GRADIANS
      case 'Gradians':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by (9/10)';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by (π/200)';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 100';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 6000';
            break;
          case 'Turns':
            formula = 'Divide the angle value by 400';
            break;
          case 'Revolutions':
            formula = 'Divide the angle value by 400';
            break;
          case 'Circles':
            formula = 'Divide the angle value by 400';
            break;
          case 'Quadrants':
            formula = 'Divide the angle value by 100';
            break;
          case 'Sextants':
            formula = 'Divide the angle value by 66.6667';
            break;
          case 'Octants':
            formula = 'Divide the angle value by 50';
            break;
          case 'Signs':
            formula = 'Divide the angle value by 33.3333';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 512';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by (π/200) * 1000';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 16';
            break;
          case 'Gradians':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// MINUTES OF ARC
      case 'Minutes of arc':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Divide the angle value by 60';
            break;
          case 'Radians':
            formula = 'Divide the angle value by 60 * (180/π)';
            break;
          case 'Gradians':
            formula = 'Divide the angle value by 100';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 60';
            break;
          case 'Turns':
            formula = 'Divide the angle value by 216000';
            break;
          case 'Revolutions':
            formula = 'Divide the angle value by 216000';
            break;
          case 'Circles':
            formula = 'Divide the angle value by 216000';
            break;
          case 'Quadrants':
            formula = 'Divide the angle value by 1440';
            break;
          case 'Sextants':
            formula = 'Divide the angle value by 240';
            break;
          case 'Octants':
            formula = 'Divide the angle value by 180';
            break;
          case 'Signs':
            formula = 'Divide the angle value by 120';
            break;
          case 'Binary degrees':
            formula = 'Divide the angle value by 3600';
            break;
          case 'Milliradians':
            formula = 'Divide the angle value by 60 * (π/180) * 1000';
            break;
          case 'Mils (NATO)':
            formula = 'Divide the angle value by 0.9';
            break;
          case 'Minutes of arc':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// SECONDS OF ARC
      case 'Seconds of arc':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Divide the angle value by 3600';
            break;
          case 'Radians':
            formula = 'Divide the angle value by 3600 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Divide the angle value by 10000';
            break;
          case 'Minutes of arc':
            formula = 'Divide the angle value by 60';
            break;
          case 'Turns':
            formula = 'Divide the angle value by 1296000';
            break;
          case 'Revolutions':
            formula = 'Divide the angle value by 1296000';
            break;
          case 'Circles':
            formula = 'Divide the angle value by 1296000';
            break;
          case 'Quadrants':
            formula = 'Divide the angle value by 3600';
            break;
          case 'Sextants':
            formula = 'Divide the angle value by 600';
            break;
          case 'Octants':
            formula = 'Divide the angle value by 450';
            break;
          case 'Signs':
            formula = 'Divide the angle value by 300';
            break;
          case 'Binary degrees':
            formula = 'Divide the angle value by 36000';
            break;
          case 'Milliradians':
            formula = 'Divide the angle value by 60 * (π/180) * 1000';
            break;
          case 'Mils (NATO)':
            formula = 'Divide the angle value by 0.09';
            break;
          case 'Seconds of arc':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// TURNS
      case 'Turns':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 360';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 360 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 400';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 21600';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 1296000';
            break;
          case 'Revolutions':
            formula = 'Divide the angle value by 1';
            break;
          case 'Circles':
            formula = 'Divide the angle value by 1';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 4';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 6';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 8';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 12';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 36000';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 1000 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 6400';
            break;
          case 'Turns':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// REVOLUTIONS
      case 'Revolutions':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 360';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 360 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 400';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 21600';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 1296000';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 1';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 1';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 4';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 6';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 8';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 12';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 36000';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 1000 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 6400';
            break;
          case 'Revolutions':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// CIRCLES
      case 'Circles':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 360';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 360 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 400';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 21600';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 1296000';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 1';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 1';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 4';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 6';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 8';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 12';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 36000';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 1000 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 6400';
            break;
          case 'Circles':
            formula = 'The value remains unchanged';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// QUADRANTS
      case 'Quadrants':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 90';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 90 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 100';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 5400';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 324000';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 1/4';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 1/4';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 1/4';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 1.5';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 2';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 3';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 22500';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 250 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 1600';
            break;
          case 'Quadrants':
            formula = 'The value remains unchanged';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 2';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// SEXTANTS
      case 'Sextants':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 60';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 60 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 66.6667';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 3600';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 216000';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 1/6';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 1/6';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 1/6';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 0.5';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 1.3333';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 2';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 15000';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 166.667 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 1000';
            break;
          case 'Sextants':
            formula = 'The value remains unchanged';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 2';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// OCTANTS
      case 'Octants':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 45';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 45 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 50';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 2700';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 162000';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 1/8';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 1/8';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 1/8';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 0.25';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 0.75';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 2';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 11250';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 125 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 800';
            break;
          case 'Octants':
            formula = 'The value remains unchanged';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 4';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// SIGNS
      case 'Signs':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 22.5';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 22.5 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 25';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 1350';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 81000';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 1/16';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 1/16';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 1/16';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 0.0625';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 0.125';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 0.25';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 5625';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 62.5 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 400';
            break;
          case 'Signs':
            formula = 'The value remains unchanged';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 0.5';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// BINARY DEGREES
      case 'Binary degrees':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 0.025';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 0.025 * (π/180)';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 0.0277778';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 1.5';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 90';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 1/360';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 1/360';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 1/360';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 0.00625';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 0.0125';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 0.025';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 0.0444444';
            break;
          case 'Binary degrees':
            formula = 'The value remains unchanged';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 17.7778 * (π/180)';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 11.25';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;

// MILLIRADIANS
      case 'Milliradians':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 180/π * 1000';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 1000';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 180/π * 1000 / 9';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 180/π * 60 * 1000';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 180/π * 3600 * 1000';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 180/π * 2π * 1000';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 180/π * 1000 / 360';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 180/π * 1000 / 360';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 180/π * 1000 / 90';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 180/π * 1000 / 60';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 180/π * 1000 / 45';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 180/π * 1000 / 22.5';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 180/π * 1000 / 0.025';
            break;
          case 'Milliradians':
            formula = 'The value remains unchanged';
            break;
          case 'Mils (NATO)':
            formula = 'Multiply the angle value by 180/π * 1000 / 0.0111111';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
        break;
// MILS (NATO)
      case 'Mils (NATO)':
        switch (toUnit) {
          case 'Degrees':
            formula = 'Multiply the angle value by 0.05625';
            break;
          case 'Radians':
            formula = 'Multiply the angle value by 0.0015708';
            break;
          case 'Gradians':
            formula = 'Multiply the angle value by 0.0625';
            break;
          case 'Minutes of arc':
            formula = 'Multiply the angle value by 3.375';
            break;
          case 'Seconds of arc':
            formula = 'Multiply the angle value by 202.5';
            break;
          case 'Turns':
            formula = 'Multiply the angle value by 0.00015625';
            break;
          case 'Revolutions':
            formula = 'Multiply the angle value by 0.00015625';
            break;
          case 'Circles':
            formula = 'Multiply the angle value by 0.00015625';
            break;
          case 'Quadrants':
            formula = 'Multiply the angle value by 0.003125';
            break;
          case 'Sextants':
            formula = 'Multiply the angle value by 0.00625';
            break;
          case 'Octants':
            formula = 'Multiply the angle value by 0.0125';
            break;
          case 'Signs':
            formula = 'Multiply the angle value by 0.0222222';
            break;
          case 'Binary degrees':
            formula = 'Multiply the angle value by 0.09';
            break;
          case 'Milliradians':
            formula = 'Multiply the angle value by 0.0111111';
            break;
          case 'Mils (NATO)':
            formula = 'The value remains unchanged';
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
                      width: 50), // Space between the icon and the text
                  const Text(
                    'Convert Angle',
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
      case 'Radians':
        return 'rad';
      case 'Gradians':
        return 'grad';
      case 'Minutes of arc':
        return '′'; // Unicode character for minute of arc
      case 'Seconds of arc':
        return '″'; // Unicode character for second of arc
      case 'Turns':
        return 'turn';
      case 'Revolutions':
        return 'rev';
      case 'Circles':
        return 'circle';
      case 'Quadrants':
        return 'quadrant';
      case 'Sextants':
        return 'sextant';
      case 'Octants':
        return 'octant';
      case 'Signs':
        return 'sign';
      case 'Binary degrees':
        return 'bin deg';
      case 'Milliradians':
        return 'mrad';
      case 'Mils (NATO)':
        return 'mil'; // This may be 'mil' or 'mil (NATO)' depending on the context
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
      'Radians',
      'Gradians',
      'Minutes of arc',
      'Seconds of arc',
      'Turns',
      'Revolutions',
      'Circles',
      'Quadrants',
      'Sextants',
      'Octants',
      'Signs',
      'Binary degrees',
      'Milliradians',
      'Mils (NATO)',
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

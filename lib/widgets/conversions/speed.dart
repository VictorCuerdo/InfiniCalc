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

class SpeedUnitConverter extends StatefulWidget {
  const SpeedUnitConverter({super.key});

  @override
  _SpeedUnitConverterState createState() => _SpeedUnitConverterState();
}

class _SpeedUnitConverterState extends State<SpeedUnitConverter> {
  String fromUnit = 'Metres per Second';
  String toUnit = 'Metres per Hour';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool _isExponentialFormat = false;
  // Flag to indicate if the change is due to user input
  bool _isUserInput = true;
  // Using string variables for prefixes
  String fromPrefix = 'm/s';
  String toPrefix = 'm/h';
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
          text: 'Check out my speed result!');
    }
  }

  void convert(String text) {
    String normalizedText = text.replaceAll(',', '.');
    if (normalizedText.isEmpty) return;
    var fromValue = double.tryParse(normalizedText);
    if (fromValue == null) return;
    double toValue = 0; // Your conversion logic here

    // Conversion constants for different speed units
    // Base unit is Metres per Second (m/s)
    const double metresPerSecondToMetresPerHour = 3600;
    const double metresPerSecondToKilometresPerSecond = 0.001;
    const double metresPerSecondToKilometresPerHour = 3.6;
    const double metresPerSecondToFeetPerSecond = 3.28084;
    const double metresPerSecondToMilesPerSecond = 0.000621371;
    const double metresPerSecondToMilesPerHour = 2.23694;
    const double metresPerSecondToKnots = 1.94384;

    // Inverse conversions
    const double metresPerHourToMetresPerSecond = 1 / 3600;
    const double kilometresPerSecondToMetresPerSecond = 1000;
    const double kilometresPerHourToMetresPerSecond = 1 / 3.6;
    const double feetPerSecondToMetresPerSecond = 1 / 3.28084;
    const double milesPerSecondToMetresPerSecond = 1 / 0.000621371;
    const double milesPerHourToMetresPerSecond = 1 / 2.23694;
    const double knotsToMetresPerSecond = 1 / 1.94384;

    switch (fromUnit) {
      case 'Metres per Second':
        switch (toUnit) {
          case 'Metres per Hour':
            toValue = fromValue * metresPerSecondToMetresPerHour;
            break;
          case 'Kilometres per Second':
            toValue = fromValue * metresPerSecondToKilometresPerSecond;
            break;
          case 'Kilometres per Hour':
            toValue = fromValue * metresPerSecondToKilometresPerHour;
            break;
          case 'Feet per Second':
            toValue = fromValue * metresPerSecondToFeetPerSecond;
            break;
          case 'Miles per Second':
            toValue = fromValue * metresPerSecondToMilesPerSecond;
            break;
          case 'Miles per Hour':
            toValue = fromValue * metresPerSecondToMilesPerHour;
            break;
          case 'Knots':
            toValue = fromValue * metresPerSecondToKnots;
            break;
          case 'Metres per Second': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Metres per Hour':
        switch (toUnit) {
          case 'Metres per Second':
            toValue = fromValue * metresPerHourToMetresPerSecond;
            break;
          case 'Kilometres per Second':
            toValue = fromValue *
                metresPerHourToMetresPerSecond *
                metresPerSecondToKilometresPerSecond;
            break;
          case 'Kilometres per Hour':
            toValue = fromValue *
                metresPerHourToMetresPerSecond *
                metresPerSecondToKilometresPerHour;
            break;
          case 'Feet per Second':
            toValue = fromValue *
                metresPerHourToMetresPerSecond *
                metresPerSecondToFeetPerSecond;
            break;
          case 'Miles per Second':
            toValue = fromValue *
                metresPerHourToMetresPerSecond *
                metresPerSecondToMilesPerSecond;
            break;
          case 'Miles per Hour':
            toValue = fromValue *
                metresPerHourToMetresPerSecond *
                metresPerSecondToMilesPerHour;
            break;
          case 'Knots':
            toValue = fromValue *
                metresPerHourToMetresPerSecond *
                metresPerSecondToKnots;
            break;
          case 'Metres per Hour': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Kilometres per Second':
        switch (toUnit) {
          case 'Metres per Second':
            toValue = fromValue * kilometresPerSecondToMetresPerSecond;
            break;
          case 'Metres per Hour':
            toValue = fromValue *
                kilometresPerSecondToMetresPerSecond *
                metresPerSecondToMetresPerHour;
            break;
          case 'Kilometres per Hour':
            toValue = fromValue *
                kilometresPerSecondToMetresPerSecond *
                metresPerSecondToKilometresPerHour;
            break;
          case 'Feet per Second':
            toValue = fromValue *
                kilometresPerSecondToMetresPerSecond *
                metresPerSecondToFeetPerSecond;
            break;
          case 'Miles per Second':
            toValue = fromValue *
                kilometresPerSecondToMetresPerSecond *
                metresPerSecondToMilesPerSecond;
            break;
          case 'Miles per Hour':
            toValue = fromValue *
                kilometresPerSecondToMetresPerSecond *
                metresPerSecondToMilesPerHour;
            break;
          case 'Knots':
            toValue = fromValue *
                kilometresPerSecondToMetresPerSecond *
                metresPerSecondToKnots;
            break;
          case 'Kilometres per Second': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Kilometres per Hour':
        switch (toUnit) {
          case 'Metres per Second':
            toValue = fromValue * kilometresPerHourToMetresPerSecond;
            break;
          case 'Metres per Hour':
            toValue = fromValue *
                (kilometresPerHourToMetresPerSecond *
                    metresPerSecondToMetresPerHour);
            break;
          case 'Kilometres per Second':
            toValue = fromValue *
                (kilometresPerHourToMetresPerSecond *
                    metresPerSecondToKilometresPerSecond);
            break;
          case 'Feet per Second':
            toValue = fromValue *
                (kilometresPerHourToMetresPerSecond *
                    metresPerSecondToFeetPerSecond);
            break;
          case 'Miles per Second':
            toValue = fromValue *
                (kilometresPerHourToMetresPerSecond *
                    metresPerSecondToMilesPerSecond);
            break;
          case 'Miles per Hour':
            toValue = fromValue *
                (kilometresPerHourToMetresPerSecond *
                    metresPerSecondToMilesPerHour);
            break;
          case 'Knots':
            toValue = fromValue *
                (kilometresPerHourToMetresPerSecond * metresPerSecondToKnots);
            break;
          case 'Kilometres per Hour': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Feet per Second':
        switch (toUnit) {
          case 'Metres per Second':
            toValue = fromValue * feetPerSecondToMetresPerSecond;
            break;
          case 'Metres per Hour':
            toValue = fromValue *
                feetPerSecondToMetresPerSecond *
                metresPerSecondToMetresPerHour;
            break;
          case 'Kilometres per Second':
            toValue = fromValue *
                feetPerSecondToMetresPerSecond *
                metresPerSecondToKilometresPerSecond;
            break;
          case 'Kilometres per Hour':
            toValue = fromValue *
                feetPerSecondToMetresPerSecond *
                metresPerSecondToKilometresPerHour;
            break;
          case 'Miles per Second':
            toValue = fromValue *
                feetPerSecondToMetresPerSecond *
                metresPerSecondToMilesPerSecond;
            break;
          case 'Miles per Hour':
            toValue = fromValue *
                feetPerSecondToMetresPerSecond *
                metresPerSecondToMilesPerHour;
            break;
          case 'Knots':
            toValue = fromValue *
                feetPerSecondToMetresPerSecond *
                metresPerSecondToKnots;
            break;
          case 'Feet per Second': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Miles per Second':
        switch (toUnit) {
          case 'Metres per Second':
            toValue = fromValue * milesPerSecondToMetresPerSecond;
            break;
          case 'Metres per Hour':
            toValue = fromValue *
                milesPerSecondToMetresPerSecond *
                metresPerSecondToMetresPerHour;
            break;
          case 'Kilometres per Second':
            toValue = fromValue *
                milesPerSecondToMetresPerSecond *
                metresPerSecondToKilometresPerSecond;
            break;
          case 'Kilometres per Hour':
            toValue = fromValue *
                milesPerSecondToMetresPerSecond *
                metresPerSecondToKilometresPerHour;
            break;
          case 'Feet per Second':
            toValue = fromValue *
                milesPerSecondToMetresPerSecond *
                metresPerSecondToFeetPerSecond;
            break;
          case 'Miles per Hour':
            toValue = fromValue *
                milesPerSecondToMetresPerSecond *
                metresPerSecondToMilesPerHour;
            break;
          case 'Knots':
            toValue = fromValue *
                milesPerSecondToMetresPerSecond *
                metresPerSecondToKnots;
            break;
          case 'Miles per Second': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Miles per Hour':
        switch (toUnit) {
          case 'Metres per Second':
            toValue = fromValue * milesPerHourToMetresPerSecond;
            break;
          case 'Metres per Hour':
            toValue = fromValue *
                (milesPerHourToMetresPerSecond *
                    metresPerSecondToMetresPerHour);
            break;
          case 'Kilometres per Second':
            toValue = fromValue *
                (milesPerHourToMetresPerSecond *
                    metresPerSecondToKilometresPerSecond);
            break;
          case 'Kilometres per Hour':
            toValue = fromValue *
                (milesPerHourToMetresPerSecond *
                    metresPerSecondToKilometresPerHour);
            break;
          case 'Feet per Second':
            toValue = fromValue *
                (milesPerHourToMetresPerSecond *
                    metresPerSecondToFeetPerSecond);
            break;
          case 'Miles per Second':
            toValue = fromValue *
                (milesPerHourToMetresPerSecond *
                    metresPerSecondToMilesPerSecond);
            break;
          case 'Knots':
            toValue = fromValue *
                (milesPerHourToMetresPerSecond * metresPerSecondToKnots);
            break;
          case 'Miles per Hour': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Knots':
        switch (toUnit) {
          case 'Metres per Second':
            toValue = fromValue * knotsToMetresPerSecond;
            break;
          case 'Metres per Hour':
            toValue = fromValue *
                knotsToMetresPerSecond *
                metresPerSecondToMetresPerHour;
            break;
          case 'Kilometres per Second':
            toValue = fromValue *
                knotsToMetresPerSecond *
                metresPerSecondToKilometresPerSecond;
            break;
          case 'Kilometres per Hour':
            toValue = fromValue *
                knotsToMetresPerSecond *
                metresPerSecondToKilometresPerHour;
            break;
          case 'Feet per Second':
            toValue = fromValue *
                knotsToMetresPerSecond *
                metresPerSecondToFeetPerSecond;
            break;
          case 'Miles per Second':
            toValue = fromValue *
                knotsToMetresPerSecond *
                metresPerSecondToMilesPerSecond;
            break;
          case 'Miles per Hour':
            toValue = fromValue *
                knotsToMetresPerSecond *
                metresPerSecondToMilesPerHour;
            break;
          case 'Knots': // No conversion needed if from and to units are the same
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
      case 'Metres per Second':
        switch (toUnit) {
          case 'Metres per Hour':
            formula = 'Multiply the speed value by 3,600';
            break;
          case 'Kilometres per Second':
            formula = 'Divide the speed value by 1,000';
            break;
          case 'Kilometres per Hour':
            formula = 'Multiply the speed value by 3.6';
            break;
          case 'Feet per Second':
            formula = 'Multiply the speed value by approximately 3.281';
            break;
          case 'Miles per Second':
            formula = 'Multiply the speed value by approximately 0.000621371';
            break;
          case 'Miles per Hour':
            formula = 'Multiply the speed value by approximately 2.237';
            break;
          case 'Knots':
            formula = 'Multiply the speed value by approximately 1.944';
            break;
          case 'Metres per Second': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Metres per Hour':
        switch (toUnit) {
          case 'Metres per Second':
            formula = 'Divide the speed value by 3,600';
            break;
          case 'Kilometres per Second':
            formula = 'Divide the speed value by 3,600,000';
            break;
          case 'Kilometres per Hour':
            formula = 'Divide the speed value by 1,000';
            break;
          case 'Feet per Second':
            formula =
                'Multiply the speed value by 3.281 and then divide by 3,600';
            break;
          case 'Miles per Second':
            formula =
                'Multiply the speed value by 0.000621371 and then divide by 3,600';
            break;
          case 'Miles per Hour':
            formula = 'Multiply the speed value by 0.000621371';
            break;
          case 'Knots':
            formula = 'Multiply the speed value by 0.000539957';
            break;
          case 'Metres per Hour': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Kilometres per Second':
        switch (toUnit) {
          case 'Metres per Second':
            formula = 'Multiply the speed value by 1,000';
            break;
          case 'Metres per Hour':
            formula = 'Multiply the speed value by 1,000, then by 3,600';
            break;
          case 'Kilometres per Hour':
            formula = 'Multiply the speed value by 3,600';
            break;
          case 'Feet per Second':
            formula = 'Multiply the speed value by 1,000, then by 3.281';
            break;
          case 'Miles per Second':
            formula = 'Multiply the speed value by 1,000, then by 0.621371';
            break;
          case 'Miles per Hour':
            formula = 'Multiply the speed value by 1,000, then by 2.237';
            break;
          case 'Knots':
            formula = 'Multiply the speed value by 1,000, then by 1.944';
            break;
          case 'Kilometres per Second': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Kilometres per Hour':
        switch (toUnit) {
          case 'Metres per Second':
            formula = 'Divide the speed value by 3.6';
            break;
          case 'Metres per Hour':
            formula = 'Multiply the speed value by 1,000';
            break;
          case 'Kilometres per Second':
            formula = 'Divide the speed value by 3,600';
            break;
          case 'Feet per Second':
            formula = 'Multiply the speed value by 0.911344';
            break;
          case 'Miles per Second':
            formula =
                'Divide the speed value by 3,600, then multiply by 0.621371';
            break;
          case 'Miles per Hour':
            formula = 'Multiply the speed value by 0.621371';
            break;
          case 'Knots':
            formula = 'Multiply the speed value by 0.539957';
            break;
          case 'Kilometres per Hour': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Feet per Second':
        switch (toUnit) {
          case 'Metres per Second':
            formula = 'Multiply the speed value by 0.3048';
            break;
          case 'Metres per Hour':
            formula = 'Multiply the speed value by 0.3048, then by 3,600';
            break;
          case 'Kilometres per Second':
            formula =
                'Multiply the speed value by 0.3048, then divide by 1,000';
            break;
          case 'Kilometres per Hour':
            formula = 'Multiply the speed value by 0.3048, then by 3.6';
            break;
          case 'Miles per Second':
            formula =
                'Multiply the speed value by 0.3048, then divide by 1,609.344';
            break;
          case 'Miles per Hour':
            formula =
                'Multiply the speed value by 0.3048, then multiply by 2.236936';
            break;
          case 'Knots':
            formula =
                'Multiply the speed value by 0.3048, then multiply by 1.943844';
            break;
          case 'Feet per Second': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Miles per Second':
        switch (toUnit) {
          case 'Metres per Second':
            formula = 'Multiply the speed value by 1,609.344';
            break;
          case 'Metres per Hour':
            formula = 'Multiply the speed value by 1,609.344, then by 3,600';
            break;
          case 'Kilometres per Second':
            formula = 'Multiply the speed value by 1.609344';
            break;
          case 'Kilometres per Hour':
            formula = 'Multiply the speed value by 1,609.344, then by 3.6';
            break;
          case 'Feet per Second':
            formula = 'Multiply the speed value by 5,280';
            break;
          case 'Miles per Hour':
            formula = 'Multiply the speed value by 3,600';
            break;
          case 'Knots':
            formula =
                'Multiply the speed value by 1,609.344, then divide by 1.852';
            break;
          case 'Miles per Second': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Miles per Hour':
        switch (toUnit) {
          case 'Metres per Second':
            formula = 'Multiply the speed value by 0.44704';
            break;
          case 'Metres per Hour':
            formula = 'Multiply the speed value by 1,609.34';
            break;
          case 'Kilometres per Second':
            formula =
                'Multiply the speed value by 0.44704, then divide by 1,000';
            break;
          case 'Kilometres per Hour':
            formula = 'Multiply the speed value by 1.60934';
            break;
          case 'Feet per Second':
            formula = 'Multiply the speed value by 1.46667';
            break;
          case 'Miles per Second':
            formula = 'Divide the speed value by 3,600';
            break;
          case 'Knots':
            formula = 'Multiply the speed value by 0.868976';
            break;
          case 'Miles per Hour': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Knots':
        switch (toUnit) {
          case 'Metres per Second':
            formula = 'Multiply the speed value by approximately 0.514444';
            break;
          case 'Metres per Hour':
            formula =
                'Multiply the speed value by approximately 0.514444, then by 3,600';
            break;
          case 'Kilometres per Second':
            formula =
                'Multiply the speed value by approximately 0.514444, then divide by 1,000';
            break;
          case 'Kilometres per Hour':
            formula = 'Multiply the speed value by approximately 1.852';
            break;
          case 'Feet per Second':
            formula = 'Multiply the speed value by approximately 1.68781';
            break;
          case 'Miles per Second':
            formula =
                'Multiply the speed value by approximately 0.514444, then divide by 1,609.344';
            break;
          case 'Miles per Hour':
            formula = 'Multiply the speed value by approximately 1.15078';
            break;
          case 'Knots': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      default:
        formula = 'Unknown unit';
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
                    'Convert Speed',
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
      case 'Metres per Second':
        return 'm/s'; // Speed in metres per one second
      case 'Metres per Hour':
        return 'm/h'; // Speed in metres per one hour
      case 'Kilometres per Second':
        return 'km/s'; // Speed in kilometres per one second
      case 'Kilometres per Hour':
        return 'km/h'; // Speed in kilometres per one hour
      case 'Feet per Second':
        return 'ft/s'; // Speed in feet per one second
      case 'Miles per Second':
        return 'mi/s'; // Speed in miles per one second
      case 'Miles per Hour':
        return 'mph'; // Speed in miles per one hour
      case 'Knots':
        return 'kts'; // Speed in nautical miles per one hour
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
      'Metres per Second',
      'Metres per Hour',
      'Kilometres per Second',
      'Kilometres per Hour',
      'Feet per Second',
      'Miles per Second',
      'Miles per Hour',
      'Knots',
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

// ignore_for_file: library_private_types_in_public_api
import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class FrequencyUnitConverter extends StatefulWidget {
  const FrequencyUnitConverter({super.key});

  @override
  _FrequencyUnitConverterState createState() => _FrequencyUnitConverterState();
}

class _FrequencyUnitConverterState extends State<FrequencyUnitConverter> {
  String fromUnit = 'Nanohertz';
  String toUnit = 'Microhertz';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool _isExponentialFormat = false;
  // Flag to indicate if the change is due to user input
  bool _isUserInput = true;
  // Using string variables for prefixes
  String fromPrefix = 'nHz';
  String toPrefix = 'µHz';
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
          text: 'Check out my frequency result!');
    }
  }

  void convert(String text) {
    String normalizedText = text.replaceAll(',', '.');
    if (normalizedText.isEmpty) return;
    var fromValue = double.tryParse(normalizedText);
    if (fromValue == null) return;
    double toValue = 0; // Your conversion logic here

    // Conversion constants for frequency units based on Hertz (Hz)
    const double nanohertzToHertz = 1e-9;
    const double microhertzToHertz = 1e-6;
    const double millihertzToHertz = 1e-3;
    const double hertzToHertz = 1; // No conversion needed
    const double kilohertzToHertz = 1e3;
    const double megahertzToHertz = 1e6;
    const double gigahertzToHertz = 1e9;

// Since Cycles per Second is another name for Hertz, its conversion is the same as Hertz
    const double cyclesPerSecondToHertz = 1; // No conversion needed

// Revolutions per Minute to Hertz (1 revolution per minute is 1/60 Hz)
    const double revolutionsPerMinuteToHertz = 1.0 / 60.0;

// Degrees per Second is also a measure of angular velocity, not frequency
// 1 Hz is equivalent to 360 degrees per second
    const double degreesPerSecondToHertz = 1.0 / 360.0;

// Inverse conversions
    const double hertzToNanohertz = 1e9;
    const double hertzToMicrohertz = 1e6;
    const double hertzToMillihertz = 1e3;
    const double hertzToKilohertz = 1e-3;
    const double hertzToMegahertz = 1e-6;
    const double hertzToGigahertz = 1e-9;
    const double hertzToRevolutionsPerMinute = 60.0;
    const double hertzToRadiansPerSecond = 2 * pi;
    const double hertzToDegreesPerSecond = 360.0;

    const double radiansPerSecondToHertz = 1 / (2 * pi);

    switch (fromUnit) {
      case 'Nanohertz':
        switch (toUnit) {
          case 'Microhertz':
            toValue = fromValue * nanohertzToHertz * hertzToMicrohertz;
            break;
          case 'Millihertz':
            toValue = fromValue * nanohertzToHertz * hertzToMillihertz;
            break;
          case 'Hertz':
            toValue = fromValue * nanohertzToHertz;
            break;
          case 'Kilohertz':
            toValue = fromValue * nanohertzToHertz * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue = fromValue * nanohertzToHertz * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue = fromValue * nanohertzToHertz * hertzToGigahertz;
            break;
          case 'Cycles per Second':
            toValue = fromValue *
                nanohertzToHertz; // Since Hertz and Cycles per Second are equivalent
            break;
          case 'Revolutions per Minute':
            toValue =
                fromValue * nanohertzToHertz * hertzToRevolutionsPerMinute;
            break;
          case 'Radians per Second':
            toValue = fromValue * nanohertzToHertz * hertzToRadiansPerSecond;
            break;
          case 'Degrees per Second':
            toValue = fromValue * nanohertzToHertz * hertzToDegreesPerSecond;
            break;
          case 'Nanohertz': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Microhertz':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * (1e3); // 1 Microhertz = 1000 Nanohertz
            break;
          case 'Millihertz':
            toValue = fromValue * (1e-3); // 1 Microhertz = 0.001 Millihertz
            break;
          case 'Hertz':
            toValue = fromValue * microhertzToHertz;
            break;
          case 'Kilohertz':
            toValue = fromValue * microhertzToHertz * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue = fromValue * microhertzToHertz * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue = fromValue * microhertzToHertz * hertzToGigahertz;
            break;
          case 'Cycles per Second':
            toValue = fromValue *
                microhertzToHertz; // Since Hertz and Cycles per Second are equivalent
            break;
          case 'Revolutions per Minute':
            toValue =
                fromValue * microhertzToHertz * hertzToRevolutionsPerMinute;
            break;
          case 'Radians per Second':
            toValue = fromValue * microhertzToHertz * hertzToRadiansPerSecond;
            break;
          case 'Degrees per Second':
            toValue = fromValue * microhertzToHertz * hertzToDegreesPerSecond;
            break;
          case 'Microhertz': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Millihertz':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * (1e6); // 1 Millihertz = 1,000,000 Nanohertz
            break;
          case 'Microhertz':
            toValue = fromValue * (1e3); // 1 Millihertz = 1,000 Microhertz
            break;
          case 'Hertz':
            toValue = fromValue * millihertzToHertz;
            break;
          case 'Kilohertz':
            toValue = fromValue * millihertzToHertz * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue = fromValue * millihertzToHertz * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue = fromValue * millihertzToHertz * hertzToGigahertz;
            break;
          case 'Cycles per Second':
            toValue = fromValue *
                millihertzToHertz; // Since Hertz and Cycles per Second are equivalent
            break;
          case 'Revolutions per Minute':
            toValue =
                fromValue * millihertzToHertz * hertzToRevolutionsPerMinute;
            break;
          case 'Radians per Second':
            toValue = fromValue * millihertzToHertz * hertzToRadiansPerSecond;
            break;
          case 'Degrees per Second':
            toValue = fromValue * millihertzToHertz * hertzToDegreesPerSecond;
            break;
          case 'Millihertz': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Hertz':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * hertzToNanohertz;
            break;
          case 'Microhertz':
            toValue = fromValue * hertzToMicrohertz;
            break;
          case 'Millihertz':
            toValue = fromValue * hertzToMillihertz;
            break;
          case 'Kilohertz':
            toValue = fromValue * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue = fromValue * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue = fromValue * hertzToGigahertz;
            break;
          case 'Cycles per Second': // Cycles per second is the same as Hertz
            toValue = fromValue;
            break;
          case 'Revolutions per Minute':
            toValue = fromValue * hertzToRevolutionsPerMinute;
            break;
          case 'Radians per Second':
            toValue = fromValue * hertzToRadiansPerSecond;
            break;
          case 'Degrees per Second':
            toValue = fromValue * hertzToDegreesPerSecond;
            break;
          case 'Hertz': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Kilohertz':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * (1e12); // 1 Kilohertz = 1e12 Nanohertz
            break;
          case 'Microhertz':
            toValue = fromValue * (1e9); // 1 Kilohertz = 1e9 Microhertz
            break;
          case 'Millihertz':
            toValue = fromValue * (1e6); // 1 Kilohertz = 1e6 Millihertz
            break;
          case 'Hertz':
            toValue = fromValue * (1e3); // 1 Kilohertz = 1e3 Hertz
            break;
          case 'Megahertz':
            toValue = fromValue * (1e-3); // 1 Kilohertz = 0.001 Megahertz
            break;
          case 'Gigahertz':
            toValue = fromValue * (1e-6); // 1 Kilohertz = 1e-6 Gigahertz
            break;
          case 'Cycles per Second':
            toValue = fromValue *
                (1e3); // Since Hertz and Cycles per Second are equivalent
            break;
          case 'Revolutions per Minute':
            toValue = fromValue *
                (1e3) *
                60; // Convert Kilohertz to Hertz, then to RPM
            break;
          case 'Radians per Second':
            toValue = fromValue *
                (1e3) *
                (2 *
                    pi); // Convert Kilohertz to Hertz, then to Radians per Second
            break;
          case 'Degrees per Second':
            toValue = fromValue *
                (1e3) *
                360; // Convert Kilohertz to Hertz, then to Degrees per Second
            break;
          case 'Kilohertz': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Megahertz':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * (1e15); // 1 Megahertz = 1e15 Nanohertz
            break;
          case 'Microhertz':
            toValue = fromValue * (1e12); // 1 Megahertz = 1e12 Microhertz
            break;
          case 'Millihertz':
            toValue = fromValue * (1e9); // 1 Megahertz = 1e9 Millihertz
            break;
          case 'Hertz':
            toValue = fromValue * (1e6); // 1 Megahertz = 1e6 Hertz
            break;
          case 'Kilohertz':
            toValue = fromValue * (1e3); // 1 Megahertz = 1e3 Kilohertz
            break;
          case 'Gigahertz':
            toValue = fromValue * (1e-3); // 1 Megahertz = 0.001 Gigahertz
            break;
          case 'Cycles per Second':
            toValue = fromValue *
                (1e6); // Since Hertz and Cycles per Second are equivalent
            break;
          case 'Revolutions per Minute':
            toValue = fromValue *
                (1e6) *
                60; // Convert Megahertz to Hertz, then to RPM
            break;
          case 'Radians per Second':
            toValue = fromValue *
                (1e6) *
                (2 *
                    pi); // Convert Megahertz to Hertz, then to Radians per Second
            break;
          case 'Degrees per Second':
            toValue = fromValue *
                (1e6) *
                360; // Convert Megahertz to Hertz, then to Degrees per Second
            break;
          case 'Megahertz': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Gigahertz':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * (1e18); // 1 Gigahertz = 1e18 Nanohertz
            break;
          case 'Microhertz':
            toValue = fromValue * (1e15); // 1 Gigahertz = 1e15 Microhertz
            break;
          case 'Millihertz':
            toValue = fromValue * (1e12); // 1 Gigahertz = 1e12 Millihertz
            break;
          case 'Hertz':
            toValue = fromValue * (1e9); // 1 Gigahertz = 1e9 Hertz
            break;
          case 'Kilohertz':
            toValue = fromValue * (1e6); // 1 Gigahertz = 1e6 Kilohertz
            break;
          case 'Megahertz':
            toValue = fromValue * (1e3); // 1 Gigahertz = 1e3 Megahertz
            break;
          case 'Cycles per Second':
            toValue = fromValue *
                (1e9); // Since Hertz and Cycles per Second are equivalent
            break;
          case 'Revolutions per Minute':
            toValue = fromValue *
                (1e9) *
                60; // Convert Gigahertz to Hertz, then to RPM
            break;
          case 'Radians per Second':
            toValue = fromValue *
                (1e9) *
                (2 *
                    pi); // Convert Gigahertz to Hertz, then to Radians per Second
            break;
          case 'Degrees per Second':
            toValue = fromValue *
                (1e9) *
                360; // Convert Gigahertz to Hertz, then to Degrees per Second
            break;
          case 'Gigahertz': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Cycles per Second': // Cycles per Second is equivalent to Hertz
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * hertzToNanohertz;
            break;
          case 'Microhertz':
            toValue = fromValue * hertzToMicrohertz;
            break;
          case 'Millihertz':
            toValue = fromValue * hertzToMillihertz;
            break;
          case 'Hertz':
            toValue =
                fromValue; // No conversion needed if from and to units are the same
            break;
          case 'Kilohertz':
            toValue = fromValue * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue = fromValue * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue = fromValue * hertzToGigahertz;
            break;
          case 'Cycles per Second': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          case 'Revolutions per Minute':
            toValue = fromValue * hertzToRevolutionsPerMinute;
            break;
          case 'Radians per Second':
            toValue = fromValue * hertzToRadiansPerSecond;
            break;
          case 'Degrees per Second':
            toValue = fromValue * hertzToDegreesPerSecond;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Revolutions per Minute':
        switch (toUnit) {
          case 'Nanohertz':
            toValue =
                fromValue * revolutionsPerMinuteToHertz * hertzToNanohertz;
            break;
          case 'Microhertz':
            toValue =
                fromValue * revolutionsPerMinuteToHertz * hertzToMicrohertz;
            break;
          case 'Millihertz':
            toValue =
                fromValue * revolutionsPerMinuteToHertz * hertzToMillihertz;
            break;
          case 'Hertz':
            toValue = fromValue * revolutionsPerMinuteToHertz;
            break;
          case 'Kilohertz':
            toValue =
                fromValue * revolutionsPerMinuteToHertz * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue =
                fromValue * revolutionsPerMinuteToHertz * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue =
                fromValue * revolutionsPerMinuteToHertz * hertzToGigahertz;
            break;
          case 'Cycles per Second': // Cycles per Second is the same as Hertz
            toValue = fromValue * revolutionsPerMinuteToHertz;
            break;
          case 'Radians per Second':
            toValue = fromValue *
                revolutionsPerMinuteToHertz *
                hertzToRadiansPerSecond;
            break;
          case 'Degrees per Second':
            toValue = fromValue *
                revolutionsPerMinuteToHertz *
                hertzToDegreesPerSecond;
            break;
          case 'Revolutions per Minute': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Radians per Second':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * radiansPerSecondToHertz * hertzToNanohertz;
            break;
          case 'Microhertz':
            toValue = fromValue * radiansPerSecondToHertz * hertzToMicrohertz;
            break;
          case 'Millihertz':
            toValue = fromValue * radiansPerSecondToHertz * hertzToMillihertz;
            break;
          case 'Hertz':
            toValue = fromValue * radiansPerSecondToHertz;
            break;
          case 'Kilohertz':
            toValue = fromValue * radiansPerSecondToHertz * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue = fromValue * radiansPerSecondToHertz * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue = fromValue * radiansPerSecondToHertz * hertzToGigahertz;
            break;
          case 'Cycles per Second': // Cycles per Second is the same as Hertz
            toValue = fromValue * radiansPerSecondToHertz;
            break;
          case 'Revolutions per Minute':
            toValue = fromValue *
                radiansPerSecondToHertz *
                hertzToRevolutionsPerMinute;
            break;
          case 'Radians per Second': // No conversion needed if from and to units are the same
            toValue = fromValue;
            break;
          case 'Degrees per Second':
            toValue = fromValue *
                (180 / pi); // Convert Radians per Second to Degrees per Second
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Degrees per Second':
        switch (toUnit) {
          case 'Nanohertz':
            toValue = fromValue * degreesPerSecondToHertz * hertzToNanohertz;
            break;
          case 'Microhertz':
            toValue = fromValue * degreesPerSecondToHertz * hertzToMicrohertz;
            break;
          case 'Millihertz':
            toValue = fromValue * degreesPerSecondToHertz * hertzToMillihertz;
            break;
          case 'Hertz':
            toValue = fromValue * degreesPerSecondToHertz;
            break;
          case 'Kilohertz':
            toValue = fromValue * degreesPerSecondToHertz * hertzToKilohertz;
            break;
          case 'Megahertz':
            toValue = fromValue * degreesPerSecondToHertz * hertzToMegahertz;
            break;
          case 'Gigahertz':
            toValue = fromValue * degreesPerSecondToHertz * hertzToGigahertz;
            break;
          case 'Cycles per Second': // Cycles per Second is the same as Hertz
            toValue = fromValue * degreesPerSecondToHertz;
            break;
          case 'Revolutions per Minute':
            toValue = fromValue *
                degreesPerSecondToHertz *
                hertzToRevolutionsPerMinute;
            break;
          case 'Radians per Second':
            toValue = fromValue *
                (pi / 180); // Convert Degrees per Second to Radians per Second
            break;
          case 'Degrees per Second': // No conversion needed if from and to units are the same
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
      case 'Nanohertz':
        switch (toUnit) {
          case 'Microhertz':
            formula = 'Multiply the frequency value by 1,000';
            break;
          case 'Millihertz':
            formula = 'Divide the frequency value by 1,000,000';
            break;
          case 'Hertz':
            formula = 'Divide the frequency value by 1,000,000,000';
            break;
          case 'Kilohertz':
            formula = 'Divide the frequency value by 1,000,000,000,000';
            break;
          case 'Megahertz':
            formula = 'Divide the frequency value by 1,000,000,000,000,000';
            break;
          case 'Gigahertz':
            formula = 'Divide the frequency value by 1,000,000,000,000,000,000';
            break;
          case 'Cycles per Second':
            formula =
                'Divide the frequency value by 1,000,000,000'; // Equivalent to Hertz
            break;
          case 'Revolutions per Minute':
            formula =
                'Divide the frequency value by 1,000,000,000 and multiply by 60';
            break;
          case 'Radians per Second':
            formula =
                'Divide the frequency value by 1,000,000,000 and multiply by \(2\pi\)';
            break;
          case 'Degrees per Second':
            formula =
                'Divide the frequency value by 1,000,000,000 and multiply by 360';
            break;
          case 'Nanohertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Microhertz':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 1,000,000'; // 1 Microhertz = 1,000,000 Nanohertz
            break;
          case 'Millihertz':
            formula =
                'Divide the frequency value by 1,000'; // 1 Microhertz = 0.001 Millihertz
            break;
          case 'Hertz':
            formula =
                'Divide the frequency value by 1,000,000'; // 1 Microhertz = 1e-6 Hertz
            break;
          case 'Kilohertz':
            formula =
                'Divide the frequency value by 1,000,000,000'; // 1 Microhertz = 1e-9 Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Divide the frequency value by 1,000,000,000,000'; // 1 Microhertz = 1e-12 Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the frequency value by 1,000,000,000,000,000'; // 1 Microhertz = 1e-15 Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'Divide the frequency value by 1,000,000'; // Equivalent to Hertz
            break;
          case 'Revolutions per Minute':
            formula =
                'Divide the frequency value by 1,000,000 and multiply by 60'; // Conversion to RPM
            break;
          case 'Radians per Second':
            formula =
                'Divide the frequency value by 1,000,000 and multiply by \(2\pi\)'; // Conversion to Radians per Second
            break;
          case 'Degrees per Second':
            formula =
                'Divide the frequency value by 1,000,000 and multiply by 360'; // Conversion to Degrees per Second
            break;
          case 'Microhertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Millihertz':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 1,000,000,000'; // 1 Millihertz = 1,000,000,000 Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Multiply the frequency value by 1,000,000'; // 1 Millihertz = 1,000,000 Microhertz
            break;
          case 'Hertz':
            formula =
                'Divide the frequency value by 1,000'; // 1 Millihertz = 0.001 Hertz
            break;
          case 'Kilohertz':
            formula =
                'Divide the frequency value by 1,000,000'; // 1 Millihertz = 1e-6 Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Divide the frequency value by 1,000,000,000'; // 1 Millihertz = 1e-9 Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the frequency value by 1,000,000,000,000'; // 1 Millihertz = 1e-12 Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'Divide the frequency value by 1,000'; // Equivalent to Hertz
            break;
          case 'Revolutions per Minute':
            formula =
                'Divide the frequency value by 1,000 and multiply by 60'; // Conversion to RPM
            break;
          case 'Radians per Second':
            formula =
                'Divide the frequency value by 1,000 and multiply by \(2\pi\)'; // Conversion to Radians per Second
            break;
          case 'Degrees per Second':
            formula =
                'Divide the frequency value by 1,000 and multiply by 360'; // Conversion to Degrees per Second
            break;
          case 'Millihertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Hertz':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 1,000,000,000'; // 1 Hertz = 1e9 Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Multiply the frequency value by 1,000,000'; // 1 Hertz = 1e6 Microhertz
            break;
          case 'Millihertz':
            formula =
                'Multiply the frequency value by 1,000'; // 1 Hertz = 1e3 Millihertz
            break;
          case 'Kilohertz':
            formula =
                'Divide the frequency value by 1,000'; // 1 Hertz = 1e-3 Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Divide the frequency value by 1,000,000'; // 1 Hertz = 1e-6 Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the frequency value by 1,000,000,000'; // 1 Hertz = 1e-9 Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'The value remains unchanged'; // Hertz is the same as cycles per second
            break;
          case 'Revolutions per Minute':
            formula = 'Multiply the frequency value by 60'; // 1 Hertz = 60 RPM
            break;
          case 'Radians per Second':
            formula =
                'Multiply the frequency value by 2π'; // 1 Hertz = 2π Radians per second
            break;
          case 'Degrees per Second':
            formula =
                'Multiply the frequency value by 360'; // 1 Hertz = 360 Degrees per second
            break;
          case 'Hertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Kilohertz':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 1,000,000,000,000'; // 1 Kilohertz = 1e12 Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Multiply the frequency value by 1,000,000,000'; // 1 Kilohertz = 1e9 Microhertz
            break;
          case 'Millihertz':
            formula =
                'Multiply the frequency value by 1,000,000'; // 1 Kilohertz = 1e6 Millihertz
            break;
          case 'Hertz':
            formula =
                'Multiply the frequency value by 1,000'; // 1 Kilohertz = 1e3 Hertz
            break;
          case 'Megahertz':
            formula =
                'Divide the frequency value by 1,000'; // 1 Kilohertz = 1e-3 Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the frequency value by 1,000,000'; // 1 Kilohertz = 1e-6 Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'Multiply the frequency value by 1,000'; // Kilohertz is the same as 1,000 cycles per second
            break;
          case 'Revolutions per Minute':
            formula =
                'Multiply the frequency value by 1,000 and then by 60'; // Conversion to RPM
            break;
          case 'Radians per Second':
            formula =
                'Multiply the frequency value by 1,000 and then by 2π'; // Conversion to Radians per second
            break;
          case 'Degrees per Second':
            formula =
                'Multiply the frequency value by 1,000 and then by 360'; // Conversion to Degrees per second
            break;
          case 'Kilohertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Megahertz':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 1,000,000,000,000,000'; // 1 Megahertz = 1e15 Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Multiply the frequency value by 1,000,000,000,000'; // 1 Megahertz = 1e12 Microhertz
            break;
          case 'Millihertz':
            formula =
                'Multiply the frequency value by 1,000,000,000'; // 1 Megahertz = 1e9 Millihertz
            break;
          case 'Hertz':
            formula =
                'Multiply the frequency value by 1,000,000'; // 1 Megahertz = 1e6 Hertz
            break;
          case 'Kilohertz':
            formula =
                'Multiply the frequency value by 1,000'; // 1 Megahertz = 1e3 Kilohertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the frequency value by 1,000'; // 1 Megahertz = 1e-3 Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'Multiply the frequency value by 1,000,000'; // Megahertz is the same as 1,000,000 cycles per second
            break;
          case 'Revolutions per Minute':
            formula =
                'Multiply the frequency value by 1,000,000 and then by 60'; // Conversion to RPM
            break;
          case 'Radians per Second':
            formula =
                'Multiply the frequency value by 1,000,000 and then by 2π'; // Conversion to Radians per second
            break;
          case 'Degrees per Second':
            formula =
                'Multiply the frequency value by 1,000,000 and then by 360'; // Conversion to Degrees per second
            break;
          case 'Megahertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Gigahertz':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 1,000,000,000,000,000,000'; // 1 Gigahertz = 1e18 Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Multiply the frequency value by 1,000,000,000,000,000'; // 1 Gigahertz = 1e15 Microhertz
            break;
          case 'Millihertz':
            formula =
                'Multiply the frequency value by 1,000,000,000,000'; // 1 Gigahertz = 1e12 Millihertz
            break;
          case 'Hertz':
            formula =
                'Multiply the frequency value by 1,000,000,000'; // 1 Gigahertz = 1e9 Hertz
            break;
          case 'Kilohertz':
            formula =
                'Multiply the frequency value by 1,000,000'; // 1 Gigahertz = 1e6 Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Multiply the frequency value by 1,000'; // 1 Gigahertz = 1e3 Megahertz
            break;
          case 'Cycles per Second':
            formula =
                'Multiply the frequency value by 1,000,000,000'; // Gigahertz is the same as 1,000,000,000 cycles per second
            break;
          case 'Revolutions per Minute':
            formula =
                'Multiply the frequency value by 1,000,000,000 and then by 60'; // Conversion to RPM
            break;
          case 'Radians per Second':
            formula =
                'Multiply the frequency value by 1,000,000,000 and then by 2π'; // Conversion to Radians per second
            break;
          case 'Degrees per Second':
            formula =
                'Multiply the frequency value by 1,000,000,000 and then by 360'; // Conversion to Degrees per second
            break;
          case 'Gigahertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Cycles per Second':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 1,000,000,000'; // 1 Hertz = 1e9 Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Multiply the frequency value by 1,000,000'; // 1 Hertz = 1e6 Microhertz
            break;
          case 'Millihertz':
            formula =
                'Multiply the frequency value by 1,000'; // 1 Hertz = 1e3 Millihertz
            break;
          case 'Kilohertz':
            formula =
                'Divide the frequency value by 1,000'; // 1 Hertz = 1e-3 Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Divide the frequency value by 1,000,000'; // 1 Hertz = 1e-6 Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the frequency value by 1,000,000,000'; // 1 Hertz = 1e-9 Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'The value remains unchanged'; // Hertz is the same as cycles per second
            break;
          case 'Revolutions per Minute':
            formula = 'Multiply the frequency value by 60'; // 1 Hertz = 60 RPM
            break;
          case 'Radians per Second':
            formula =
                'Multiply the frequency value by 2π'; // 1 Hertz = 2π Radians per second
            break;
          case 'Degrees per Second':
            formula =
                'Multiply the frequency value by 360'; // 1 Hertz = 360 Degrees per second
            break;
          case 'Hertz': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Revolutions per Minute':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Multiply the frequency value by 60, then by 1,000,000,000'; // RPM to Hz to Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Multiply the frequency value by 60, then by 1,000,000'; // RPM to Hz to Microhertz
            break;
          case 'Millihertz':
            formula =
                'Multiply the frequency value by 60, then by 1,000'; // RPM to Hz to Millihertz
            break;
          case 'Hertz':
            formula = 'Divide the frequency value by 60'; // RPM to Hz
            break;
          case 'Kilohertz':
            formula =
                'Multiply the frequency value by 60, then divide by 1,000'; // RPM to Hz to Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Multiply the frequency value by 60, then divide by 1,000,000'; // RPM to Hz to Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Multiply the frequency value by 60, then divide by 1,000,000,000'; // RPM to Hz to Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'Divide the frequency value by 60'; // RPM to Hz, which is the same as Cycles per Second
            break;
          case 'Revolutions per Minute':
            formula = 'The value remains unchanged'; // No conversion needed
            break;
          case 'Radians per Second':
            formula =
                'Multiply the frequency value by 60 and then by 2π'; // RPM to Hz to Radians per Second
            break;
          case 'Degrees per Second':
            formula =
                'Multiply the frequency value by 60 and then by 360'; // RPM to Hz to Degrees per Second
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Radians per Second':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Divide the angular velocity value by 2π, then multiply by 1,000,000,000,000,000,000'; // Radians per Second to Hz to Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Divide the angular velocity value by 2π, then multiply by 1,000,000,000,000,000'; // Radians per Second to Hz to Microhertz
            break;
          case 'Millihertz':
            formula =
                'Divide the angular velocity value by 2π, then multiply by 1,000,000,000,000'; // Radians per Second to Hz to Millihertz
            break;
          case 'Hertz':
            formula =
                'Divide the angular velocity value by 2π'; // Radians per Second to Hz
            break;
          case 'Kilohertz':
            formula =
                'Divide the angular velocity value by 2π, then multiply by 1,000'; // Radians per Second to Hz to Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Divide the angular velocity value by 2π, then multiply by 1,000,000'; // Radians per Second to Hz to Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the angular velocity value by 2π, then multiply by 1,000,000,000'; // Radians per Second to Hz to Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'Divide the angular velocity value by 2π'; // Radians per Second is the angular frequency, equivalent to Hz
            break;
          case 'Revolutions per Minute':
            formula =
                'Divide the angular velocity value by 2π, then multiply by 60'; // Radians per Second to Hz to RPM
            break;
          case 'Radians per Second':
            formula = 'The value remains unchanged'; // No conversion needed
            break;
          case 'Degrees per Second':
            formula =
                'Multiply the angular velocity value by 180/π'; // Radians per Second to Degrees per Second
            break;
          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

      case 'Degrees per Second':
        switch (toUnit) {
          case 'Nanohertz':
            formula =
                'Divide the angular velocity value by 360, then multiply by 1,000,000,000,000,000,000'; // Degrees per Second to Hz to Nanohertz
            break;
          case 'Microhertz':
            formula =
                'Divide the angular velocity value by 360, then multiply by 1,000,000,000,000,000'; // Degrees per Second to Hz to Microhertz
            break;
          case 'Millihertz':
            formula =
                'Divide the angular velocity value by 360, then multiply by 1,000,000,000,000'; // Degrees per Second to Hz to Millihertz
            break;
          case 'Hertz':
            formula =
                'Divide the angular velocity value by 360'; // Degrees per Second to Hz
            break;
          case 'Kilohertz':
            formula =
                'Divide the angular velocity value by 360, then multiply by 1,000'; // Degrees per Second to Hz to Kilohertz
            break;
          case 'Megahertz':
            formula =
                'Divide the angular velocity value by 360, then multiply by 1,000,000'; // Degrees per Second to Hz to Megahertz
            break;
          case 'Gigahertz':
            formula =
                'Divide the angular velocity value by 360, then multiply by 1,000,000,000'; // Degrees per Second to Hz to Gigahertz
            break;
          case 'Cycles per Second':
            formula =
                'Divide the angular velocity value by 360'; // Degrees per Second to Hz, equivalent to Cycles per Second
            break;
          case 'Revolutions per Minute':
            formula =
                'Divide the angular velocity value by 360, then multiply by 60'; // Degrees per Second to Hz to RPM
            break;
          case 'Radians per Second':
            formula =
                'Multiply the angular velocity value by π/180'; // Degrees per Second to Radians per Second
            break;
          case 'Degrees per Second':
            formula = 'The value remains unchanged'; // No conversion needed
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
                    'Convert Frequency',
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
      case 'Nanohertz':
        return 'nHz'; // Frequency in nanohertz
      case 'Microhertz':
        return 'µHz'; // Frequency in microhertz
      case 'Millihertz':
        return 'mHz'; // Frequency in millihertz
      case 'Hertz':
        return 'Hz'; // Frequency in hertz, base unit of frequency
      case 'Kilohertz':
        return 'kHz'; // Frequency in kilohertz
      case 'Megahertz':
        return 'MHz'; // Frequency in megahertz
      case 'Gigahertz':
        return 'GHz'; // Frequency in gigahertz
      case 'Cycles per Second':
        return 'Hz'; // Cycles per second is equivalent to hertz
      case 'Revolutions per Minute':
        return 'RPM'; // Frequency in revolutions per minute
      case 'Radians per Second':
        return 'rad/s'; // Angular velocity in radians per second
      case 'Degrees per Second':
        return 'deg/s'; // Angular velocity in degrees per second
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
      'Nanohertz',
      'Microhertz',
      'Millihertz',
      'Hertz',
      'Kilohertz',
      'Megahertz',
      'Gigahertz',
      'Cycles per Second',
      'Revolutions per Minute',
      'Radians per Second',
      'Degrees per Second',
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

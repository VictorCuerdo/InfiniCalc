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

class MassUnitConverter extends StatefulWidget {
  const MassUnitConverter({super.key});

  @override
  _MassUnitConverterState createState() => _MassUnitConverterState();
}

class _MassUnitConverterState extends State<MassUnitConverter> {
  String fromUnit = 'Micrograms';
  String toUnit = 'Milligrams';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool _isExponentialFormat = false;
  // Flag to indicate if the change is due to user input
  bool _isUserInput = true;
  // Using string variables for prefixes
  String fromPrefix = 'µg';
  String toPrefix = 'mg';
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
          text: 'Check out my mass result!');
    }
  }

  void convert(String text) {
    String normalizedText = text.replaceAll(',', '.');
    if (normalizedText.isEmpty) return;
    var fromValue = double.tryParse(normalizedText);
    if (fromValue == null) return;
    double toValue = 0; // Your conversion logic here
// Conversion constants for mass units
// Define conversion constants
    const double microgramToMilligram = 1e-3;
    const double microgramToGram = 1e-6;
    const double microgramToKilogram = 1e-9;
    const double microgramToTonne = 1e-12;
    const double microgramToGrain = 1.543236e-5;
    const double microgramToOunce = 3.5274e-8;
    const double microgramToPound = 2.2046e-9;
    const double microgramToStone = 1.5747e-10;
    const double microgramToQuarter = 1.10231e-10;
    const double microgramToHundredweightLMP = 1.96841e-11;
    const double microgramToHundredweightUS = 2.20462e-11;
    const double microgramToLongTonLMP = 9.8421e-13;
    const double microgramToShortTonUS = 1.1023e-12;
    const double microgramToCarat = 5e-3;
    const double microgramToTroyOunce = 3.21507e-8;

// Using these constants, you can convert from any of these units to grams and then to any other unit.
    switch (fromUnit) {
      case 'Micrograms':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue * microgramToMilligram;
            break;
          case 'Grams':
            toValue = fromValue * microgramToGram;
            break;
          case 'Kilograms':
            toValue = fromValue * microgramToKilogram;
            break;
          case 'Tonnes':
            toValue = fromValue * microgramToTonne;
            break;
          case 'Grains':
            toValue = fromValue * microgramToGrain;
            break;
          case 'Ounces':
            toValue = fromValue * microgramToOunce;
            break;
          case 'Pounds':
            toValue = fromValue * microgramToPound;
            break;
          case 'Stones':
            toValue = fromValue * microgramToStone;
            break;
          case 'Quarters':
            toValue = fromValue * microgramToQuarter;
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue * microgramToHundredweightLMP;
            break;
          case 'Hundredweight (US)':
            toValue = fromValue * microgramToHundredweightUS;
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue * microgramToLongTonLMP;
            break;
          case 'Short Tons (US)':
            toValue = fromValue * microgramToShortTonUS;
            break;
          case 'Carats':
            toValue = fromValue * microgramToCarat;
            break;
          case 'Troy Ounces':
            toValue = fromValue * microgramToTroyOunce;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }

        break;

      case 'Milligrams':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue;
            break;
          case 'Micrograms':
            toValue = fromValue * 1000;
            break;
          case 'Grams':
            toValue = fromValue * 0.001;
            break;

          case 'Kilograms':
            toValue = fromValue * 1e-6;
            break;
          case 'Tonnes':
            toValue = fromValue * 1e-9;
            break;
          case 'Grains':
            toValue = fromValue * 0.01543236;
            break;
          case 'Ounces':
            toValue = fromValue * 3.527396e-5;
            break;
          case 'Pounds':
            toValue = fromValue * 2.204623e-6;
            break;
          case 'Stones':
            toValue = fromValue * 1.57473e-7;
            break;
          case 'Quarters':
            toValue = fromValue * 1.10231e-7;
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue * 5.080234e-8;
            break;
          case 'Hundredweight (US)':
            toValue = fromValue * 2.20462e-8;
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue * 9.842065e-10;
            break;
          case 'Short Tons (US)':
            toValue = fromValue * 1.10231e-9;
            break;
          case 'Carats':
            toValue = fromValue * 5;
            break;
          case 'Troy Ounces':
            toValue = fromValue * 3.215075e-5;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Grams':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue * 1000;
            break;
          case 'Micrograms':
            toValue = fromValue * 1e6;
            break;
          case 'Grams':
            toValue = fromValue;
            break;

          case 'Kilograms':
            toValue = fromValue * 0.001;
            break;
          case 'Tonnes':
            toValue = fromValue * 1e-6;
            break;
          case 'Grains':
            toValue = fromValue * 15.43236;
            break;
          case 'Ounces':
            toValue = fromValue * 0.03527396;
            break;
          case 'Pounds':
            toValue = fromValue * 0.00220462;
            break;
          case 'Stones':
            toValue = fromValue * 0.000157473;
            break;
          case 'Quarters':
            toValue = fromValue * 0.00007873652;
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue * 0.00001968413;
            break;
          case 'Hundredweight (US)':
            toValue = fromValue * 0.00002204623;
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue * 9.842065e-7;
            break;
          case 'Short Tons (US)':
            toValue = fromValue * 1.102311e-6;
            break;
          case 'Carats':
            toValue = fromValue * 5000;
            break;
          case 'Troy Ounces':
            toValue = fromValue * 0.03215075;
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Kilograms':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue * 1e6; // 1 kilogram is 1,000,000 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue * 1e9; // 1 kilogram is 1,000,000,000 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 1000; // 1 kilogram is 1000 grams
            break;
          case 'Kilograms':
            toValue =
                fromValue; // The value remains the same for kilograms to kilograms
            break;
          case 'Tonnes':
            toValue = fromValue * 0.001; // 1 kilogram is 0.001 tonnes
            break;
          case 'Grains':
            toValue =
                fromValue * 15432.3584; // 1 kilogram is about 15432.3584 grains
            break;
          case 'Ounces':
            toValue =
                fromValue * 35.274; // 1 kilogram is approximately 35.274 ounces
            break;
          case 'Pounds':
            toValue = fromValue *
                2.20462; // 1 kilogram is approximately 2.20462 pounds
            break;
          case 'Stones':
            toValue = fromValue *
                0.157473; // 1 kilogram is approximately 0.157473 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                0.01968413; // 1 kilogram is 0.01968413 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                0.01968413; // 1 kilogram is 0.01968413 hundredweight (UK)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue *
                0.02204623; // 1 kilogram is 0.02204623 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                0.000984207; // 1 kilogram is 0.000984207 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue = fromValue *
                0.00110231; // 1 kilogram is 0.00110231 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue * 5000; // 1 kilogram is 5000 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                32.1507; // 1 kilogram is approximately 32.1507 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Tonnes':
        switch (toUnit) {
          case 'Milligrams':
            toValue =
                fromValue * 1e12; // 1 tonne is 1,000,000,000,000 milligrams
            break;
          case 'Micrograms':
            toValue =
                fromValue * 1e15; // 1 tonne is 1,000,000,000,000,000 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 1e6; // 1 tonne is 1,000,000 grams
            break;
          case 'Kilograms':
            toValue = fromValue * 1000; // 1 tonne is 1000 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue; // The value remains the same for tonnes to tonnes
            break;
          case 'Grains':
            toValue = fromValue *
                1.54323584e7; // 1 tonne is about 15,432,358.4 grains
            break;
          case 'Ounces':
            toValue = fromValue *
                35273.962; // 1 tonne is approximately 35,273.962 ounces
            break;
          case 'Pounds':
            toValue = fromValue *
                2204.62262; // 1 tonne is approximately 2,204.62262 pounds
            break;
          case 'Stones':
            toValue = fromValue *
                157.473044; // 1 tonne is approximately 157.473044 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                39.36823105; // 1 tonne is approximately 39.36823105 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                19.68413055; // 1 tonne is 19.68413055 hundredweight (UK)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue *
                22.04622622; // 1 tonne is 22.04622622 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                0.9842065276; // 1 tonne is 0.9842065276 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue =
                fromValue * 1.10231131; // 1 tonne is 1.10231131 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue * 5e6; // 1 tonne is 5,000,000 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                32150.7466; // 1 tonne is approximately 32,150.7466 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Grains':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue * 64.79891; // 1 grain is 64.79891 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue * 64798.91; // 1 grain is 64,798.91 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 0.06479891; // 1 grain is 0.06479891 grams
            break;
          case 'Kilograms':
            toValue =
                fromValue * 6.479891e-5; // 1 grain is 0.00006479891 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 6.479891e-8; // 1 grain is 0.00000006479891 tonnes
            break;
          case 'Grains':
            toValue =
                fromValue; // The value remains the same for grains to grains
            break;
          case 'Ounces':
            toValue = fromValue *
                0.00228571429; // 1 grain is approximately 0.00228571429 ounces
            break;
          case 'Pounds':
            toValue = fromValue *
                0.000142857143; // 1 grain is approximately 0.000142857143 pounds
            break;
          case 'Stones':
            toValue = fromValue *
                1.02040816e-5; // 1 grain is approximately 0.0000102040816 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                2.55102041e-6; // 1 grain is approximately 0.00000255102041 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                1.2755102e-6; // 1 grain is approximately 0.0000012755102 hundredweight (UK)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue *
                1.42857143e-6; // 1 grain is approximately 0.00000142857143 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                6.37755102e-8; // 1 grain is approximately 0.0000000637755102 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue = fromValue *
                7.14285714e-8; // 1 grain is approximately 0.0000000714285714 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue * 0.32399455; // 1 grain is 0.32399455 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                0.00208333333; // 1 grain is approximately 0.00208333333 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Ounces':
        switch (toUnit) {
          case 'Milligrams':
            toValue =
                fromValue * 28349.5231; // 1 ounce is 28,349.5231 milligrams
            break;
          case 'Micrograms':
            toValue =
                fromValue * 28349523.1; // 1 ounce is 28,349,523.1 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 28.3495231; // 1 ounce is 28.3495231 grams
            break;
          case 'Kilograms':
            toValue =
                fromValue * 0.0283495231; // 1 ounce is 0.0283495231 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 2.83495231e-5; // 1 ounce is 0.0000283495231 tonnes
            break;
          case 'Grains':
            toValue = fromValue * 437.5; // 1 ounce is 437.5 grains
            break;
          case 'Ounces':
            toValue =
                fromValue; // The value remains the same for ounces to ounces
            break;
          case 'Pounds':
            toValue = fromValue * 0.0625; // 1 ounce is 0.0625 pounds
            break;
          case 'Stones':
            toValue =
                fromValue * 0.00446428571; // 1 ounce is 0.00446428571 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                0.00111607143; // 1 ounce is 0.00111607143 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                0.000559006211; // 1 ounce is 0.000559006211 hundredweight (UK)
            break;
          case 'Hundredweight (US)':
            toValue =
                fromValue * 0.000625; // 1 ounce is 0.000625 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                2.79017857e-5; // 1 ounce is 0.0000279017857 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue =
                fromValue * 3.125e-5; // 1 ounce is 0.00003125 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue * 141.747616; // 1 ounce is 141.747616 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                0.911458333; // 1 ounce is approximately 0.911458333 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Pounds':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue * 453592.37; // 1 pound is 453,592.37 milligrams
            break;
          case 'Micrograms':
            toValue =
                fromValue * 4.5359237e+8; // 1 pound is 453,592,370 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 453.59237; // 1 pound is 453.59237 grams
            break;
          case 'Kilograms':
            toValue = fromValue * 0.45359237; // 1 pound is 0.45359237 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 0.00045359237; // 1 pound is 0.00045359237 tonnes
            break;
          case 'Grains':
            toValue = fromValue * 7000; // 1 pound is 7000 grains
            break;
          case 'Ounces':
            toValue = fromValue * 16; // 1 pound is 16 ounces
            break;
          case 'Pounds':
            toValue =
                fromValue; // The value remains the same for pounds to pounds
            break;
          case 'Stones':
            toValue =
                fromValue * 0.0714285714; // 1 pound is 0.0714285714 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                0.0178571429; // 1 pound is 0.0178571429 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                0.00892857143; // 1 pound is 0.00892857143 hundredweight (UK)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue * 0.01; // 1 pound is 0.01 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                0.000446428571; // 1 pound is 0.000446428571 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue = fromValue * 0.0005; // 1 pound is 0.0005 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue * 2267.96185; // 1 pound is 2,267.96185 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                14.5833333; // 1 pound is approximately 14.5833333 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Stones':
        switch (toUnit) {
          case 'Milligrams':
            toValue =
                fromValue * 6.35029318e6; // 1 stone is 6,350,293.18 milligrams
            break;
          case 'Micrograms':
            toValue =
                fromValue * 6.35029318e9; // 1 stone is 6,350,293,180 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 6350.29318; // 1 stone is 6,350.29318 grams
            break;
          case 'Kilograms':
            toValue = fromValue * 6.35029318; // 1 stone is 6.35029318 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 0.00635029318; // 1 stone is 0.00635029318 tonnes
            break;
          case 'Grains':
            toValue = fromValue * 98000; // 1 stone is 98,000 grains
            break;
          case 'Ounces':
            toValue = fromValue * 224; // 1 stone is 224 ounces
            break;
          case 'Pounds':
            toValue = fromValue * 14; // 1 stone is 14 pounds
            break;
          case 'Stones':
            toValue =
                fromValue; // The value remains the same for stones to stones
            break;
          case 'Quarters':
            toValue = fromValue * 0.25; // 1 stone is 0.25 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue * 0.125; // 1 stone is 0.125 hundredweight (UK)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue * 0.14; // 1 stone is 0.14 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue * 0.00625; // 1 stone is 0.00625 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue = fromValue * 0.007; // 1 stone is 0.007 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue * 31751.4659; // 1 stone is 31,751.4659 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                204.166667; // 1 stone is approximately 204.166667 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Quarters':
        switch (toUnit) {
          case 'Milligrams':
            toValue =
                fromValue * 12700586.4; // 1 quarter is 12,700,586.4 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue *
                1.27005864e+10; // 1 quarter is 12,700,586,400 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 12700.5864; // 1 quarter is 12,700.5864 grams
            break;
          case 'Kilograms':
            toValue =
                fromValue * 12.7005864; // 1 quarter is 12.7005864 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 0.0127005864; // 1 quarter is 0.0127005864 tonnes
            break;
          case 'Grains':
            toValue = fromValue * 196000; // 1 quarter is 196,000 grains
            break;
          case 'Ounces':
            toValue = fromValue * 448; // 1 quarter is 448 ounces
            break;
          case 'Pounds':
            toValue = fromValue * 28; // 1 quarter is 28 pounds
            break;
          case 'Stones':
            toValue = fromValue * 2; // 1 quarter is 2 stones
            break;
          case 'Quarters':
            toValue =
                fromValue; // The value remains the same for quarters to quarters
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue * 0.5; // 1 quarter is 0.5 hundredweight (UK)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue * 0.56; // 1 quarter is 0.56 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue * 0.0125; // 1 quarter is 0.0125 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue = fromValue * 0.014; // 1 quarter is 0.014 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue * 63502.932; // 1 quarter is 63,502.932 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                408.333333; // 1 quarter is approximately 408.333333 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Hundredweight (lmp)':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue *
                5.08023454e7; // 1 cwt (Imp) is 50,802,345.4 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue *
                5.08023454e10; // 1 cwt (Imp) is 50,802,345,400 micrograms
            break;
          case 'Grams':
            toValue =
                fromValue * 50802.3454; // 1 cwt (Imp) is 50,802.3454 grams
            break;
          case 'Kilograms':
            toValue =
                fromValue * 50.8023454; // 1 cwt (Imp) is 50.8023454 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 0.0508023454; // 1 cwt (Imp) is 0.0508023454 tonnes
            break;
          case 'Grains':
            toValue = fromValue * 784000; // 1 cwt (Imp) is 784,000 grains
            break;
          case 'Ounces':
            toValue = fromValue * 1792; // 1 cwt (Imp) is 1792 ounces
            break;
          case 'Pounds':
            toValue = fromValue * 112; // 1 cwt (Imp) is 112 pounds
            break;
          case 'Stones':
            toValue = fromValue * 8; // 1 cwt (Imp) is 8 stones
            break;
          case 'Quarters':
            toValue = fromValue * 2; // 1 cwt (Imp) is 2 quarters
            break;
          case 'Hundredweight (lmp)':
            toValue =
                fromValue; // The value remains the same for cwt (Imp) to cwt (Imp)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue * 1.12; // 1 cwt (Imp) is 1.12 cwt (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue * 0.05; // 1 cwt (Imp) is 0.05 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue = fromValue * 0.056; // 1 cwt (Imp) is 0.056 short tons (US)
            break;
          case 'Carats':
            toValue =
                fromValue * 254011.772; // 1 cwt (Imp) is 254,011.772 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                1632.66667; // 1 cwt (Imp) is approximately 1632.66667 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Hundredweight (US)':
        switch (toUnit) {
          case 'Milligrams':
            toValue =
                fromValue * 4.5359237e7; // 1 cwt (US) is 45,359,237 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue *
                4.5359237e10; // 1 cwt (US) is 45,359,237,000 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 45359.237; // 1 cwt (US) is 45,359.237 grams
            break;
          case 'Kilograms':
            toValue =
                fromValue * 45.359237; // 1 cwt (US) is 45.359237 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 0.045359237; // 1 cwt (US) is 0.045359237 tonnes
            break;
          case 'Grains':
            toValue = fromValue * 700000; // 1 cwt (US) is 700,000 grains
            break;
          case 'Ounces':
            toValue = fromValue * 1600; // 1 cwt (US) is 1600 ounces
            break;
          case 'Pounds':
            toValue = fromValue * 100; // 1 cwt (US) is 100 pounds
            break;
          case 'Stones':
            toValue = fromValue * 7.14285714; // 1 cwt (US) is 7.14285714 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                1.78571429; // 1 cwt (US) is 1.78571429 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue =
                fromValue * 0.892857143; // 1 cwt (US) is 0.892857143 cwt (Imp)
            break;
          case 'Hundredweight (US)':
            toValue =
                fromValue; // The value remains the same for cwt (US) to cwt (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                0.0446428571; // 1 cwt (US) is 0.0446428571 long tons (UK)
            break;
          case 'Short Tons (US)':
            toValue = fromValue * 0.05; // 1 cwt (US) is 0.05 short tons (US)
            break;
          case 'Carats':
            toValue =
                fromValue * 226796.185; // 1 cwt (US) is 226,796.185 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                1458.33333; // 1 cwt (US) is approximately 1458.33333 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Long Tons (lmp)':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue *
                1.0160469088e9; // 1 long ton (Imp) is 1,016,046,908.8 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue *
                1.0160469088e12; // 1 long ton (Imp) is 1,016,046,908,800 micrograms
            break;
          case 'Grams':
            toValue = fromValue *
                1.0160469088e6; // 1 long ton (Imp) is 1,016,046.9088 grams
            break;
          case 'Kilograms':
            toValue = fromValue *
                1016.0469088; // 1 long ton (Imp) is 1016.0469088 kilograms
            break;
          case 'Tonnes':
            toValue = fromValue *
                1.0160469088; // 1 long ton (Imp) is 1.0160469088 tonnes
            break;
          case 'Grains':
            toValue = fromValue *
                1.56800000e7; // 1 long ton (Imp) is 15,680,000 grains
            break;
          case 'Ounces':
            toValue = fromValue * 35840; // 1 long ton (Imp) is 35,840 ounces
            break;
          case 'Pounds':
            toValue = fromValue * 2240; // 1 long ton (Imp) is 2240 pounds
            break;
          case 'Stones':
            toValue = fromValue * 160; // 1 long ton (Imp) is 160 stones
            break;
          case 'Quarters':
            toValue = fromValue * 40; // 1 long ton (Imp) is 40 quarters
            break;
          case 'Hundredweight (lmp)':
            toValue =
                fromValue * 20; // 1 long ton (Imp) is 20 Hundredweight (lmp)
            break;
          case 'Hundredweight (US)':
            toValue =
                fromValue * 22.4; // 1 long ton (Imp) is 22.4 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue =
                fromValue; // The value remains the same for Long Tons (lmp) to Long Tons (lmp)
            break;
          case 'Short Tons (US)':
            toValue =
                fromValue * 1.12; // 1 long ton (Imp) is 1.12 short tons (US)
            break;
          case 'Carats':
            toValue = fromValue *
                5.080234544e6; // 1 long ton (Imp) is 5,080,234.544 carats
            break;
          case 'Troy Ounces':
            toValue =
                fromValue * 32640; // 1 long ton (Imp) is 32,640 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Short Tons (US)':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue *
                9.0718474e8; // 1 short ton (US) is 907,184,740 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue *
                9.0718474e11; // 1 short ton (US) is 907,184,740,000 micrograms
            break;
          case 'Grams':
            toValue =
                fromValue * 907184.74; // 1 short ton (US) is 907,184.74 grams
            break;
          case 'Kilograms':
            toValue = fromValue *
                907.18474; // 1 short ton (US) is 907.18474 kilograms
            break;
          case 'Tonnes':
            toValue =
                fromValue * 0.90718474; // 1 short ton (US) is 0.90718474 tonnes
            break;
          case 'Grains':
            toValue =
                fromValue * 1.4e7; // 1 short ton (US) is 14,000,000 grains
            break;
          case 'Ounces':
            toValue = fromValue * 32000; // 1 short ton (US) is 32,000 ounces
            break;
          case 'Pounds':
            toValue = fromValue * 2000; // 1 short ton (US) is 2000 pounds
            break;
          case 'Stones':
            toValue = fromValue *
                142.857143; // 1 short ton (US) is approximately 142.857143 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                35.7142857; // 1 short ton (US) is approximately 35.7142857 quarters
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                17.8571429; // 1 short ton (US) is approximately 17.8571429 Hundredweight (lmp)
            break;
          case 'Hundredweight (US)':
            toValue =
                fromValue * 20; // 1 short ton (US) is 20 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                0.892857143; // 1 short ton (US) is approximately 0.892857143 Long Tons (lmp)
            break;
          case 'Short Tons (US)':
            toValue =
                fromValue; // The value remains the same for short tons (US) to short tons (US)
            break;
          case 'Carats':
            toValue = fromValue *
                4.5359237e6; // 1 short ton (US) is 4,535,923.7 carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                29166.6667; // 1 short ton (US) is approximately 29,166.6667 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Carats':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue * 200; // 1 carat is 200 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue * 200000; // 1 carat is 200,000 micrograms
            break;
          case 'Grams':
            toValue = fromValue * 0.2; // 1 carat is 0.2 grams
            break;
          case 'Kilograms':
            toValue = fromValue * 0.0002; // 1 carat is 0.0002 kilograms
            break;
          case 'Tonnes':
            toValue = fromValue * 2e-7; // 1 carat is 0.0000002 tonnes
            break;
          case 'Grains':
            toValue = fromValue *
                3.08647167; // 1 carat is approximately 3.08647167 grains
            break;
          case 'Ounces':
            toValue = fromValue *
                0.00705479239; // 1 carat is approximately 0.00705479239 ounces
            break;
          case 'Pounds':
            toValue = fromValue *
                0.000440924524; // 1 carat is approximately 0.000440924524 pounds
            break;
          case 'Stones':
            toValue = fromValue *
                3.14946089e-5; // 1 carat is approximately 0.0000314946089 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                7.87365223e-6; // 1 carat is approximately 0.00000787365223 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                3.93682611e-6; // 1 carat is approximately 0.00000393682611 Hundredweight (lmp)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue *
                4.40924524e-6; // 1 carat is approximately 0.00000440924524 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                1.96841306e-7; // 1 carat is approximately 0.000000196841306 Long Tons (lmp)
            break;
          case 'Short Tons (US)':
            toValue = fromValue *
                2.20462262e-7; // 1 carat is approximately 0.000000220462262 short tons (US)
            break;
          case 'Carats':
            toValue =
                fromValue; // The value remains the same for carats to carats
            break;
          case 'Troy Ounces':
            toValue = fromValue *
                0.00643014931; // 1 carat is approximately 0.00643014931 troy ounces
            break;
          default:
            // Handle the default case or throw an error
            break;
        }
        break;

      case 'Troy Ounces':
        switch (toUnit) {
          case 'Milligrams':
            toValue = fromValue *
                31103.4768; // 1 troy ounce is 31,103.4768 milligrams
            break;
          case 'Micrograms':
            toValue = fromValue *
                31103476.8; // 1 troy ounce is 31,103,476.8 micrograms
            break;
          case 'Grams':
            toValue =
                fromValue * 31.1034768; // 1 troy ounce is 31.1034768 grams
            break;
          case 'Kilograms':
            toValue = fromValue *
                0.0311034768; // 1 troy ounce is 0.0311034768 kilograms
            break;
          case 'Tonnes':
            toValue = fromValue *
                3.11034768e-5; // 1 troy ounce is 0.0000311034768 tonnes
            break;
          case 'Grains':
            toValue = fromValue * 480; // 1 troy ounce is 480 grains
            break;
          case 'Ounces':
            toValue = fromValue *
                1.09714286; // 1 troy ounce is approximately 1.09714286 ounces
            break;
          case 'Pounds':
            toValue = fromValue *
                0.0685714286; // 1 troy ounce is approximately 0.0685714286 pounds
            break;
          case 'Stones':
            toValue = fromValue *
                0.00489795918; // 1 troy ounce is approximately 0.00489795918 stones
            break;
          case 'Quarters':
            toValue = fromValue *
                0.0012244898; // 1 troy ounce is approximately 0.0012244898 quarters (UK)
            break;
          case 'Hundredweight (lmp)':
            toValue = fromValue *
                0.000612244898; // 1 troy ounce is approximately 0.000612244898 Hundredweight (lmp)
            break;
          case 'Hundredweight (US)':
            toValue = fromValue *
                0.000682857143; // 1 troy ounce is approximately 0.000682857143 hundredweight (US)
            break;
          case 'Long Tons (lmp)':
            toValue = fromValue *
                3.06122449e-5; // 1 troy ounce is approximately 0.0000306122449 Long Tons (lmp)
            break;
          case 'Short Tons (US)':
            toValue = fromValue *
                3.42857143e-5; // 1 troy ounce is approximately 0.0000342857143 short tons (US)
            break;
          case 'Carats':
            toValue =
                fromValue * 155.517384; // 1 troy ounce is 155.517384 carats
            break;
          case 'Troy Ounces':
            toValue =
                fromValue; // The value remains the same for troy ounces to troy ounces
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
      case 'Micrograms':
        switch (toUnit) {
          case 'Milligrams':
            formula = 'Divide the mass value by 1,000';
            break;
          case 'Grams':
            formula = 'Divide the mass value by 1,000,000';
            break;
          case 'Kilograms':
            formula = 'Divide the mass value by 1,000,000,000';
            break;
          case 'Tonnes':
            formula = 'Divide the mass value by 1,000,000,000,000';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 0.000015432358352941';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 0.00000003527396194958';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 0.000000002204622621849';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.00000000015747304441777';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.000000000078736522208885';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.000000000019684130552221';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.000000000022046226218488';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.00000000000098420652761106';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.0000000000011023113109244';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 0.000005';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 0.000000032150746568628';
            break;
          case 'Micrograms': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Milligrams':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 1,000';
            break;
          case 'Grams':
            formula = 'Divide the mass value by 1,000';
            break;
          case 'Kilograms':
            formula = 'Divide the mass value by 1,000,000';
            break;
          case 'Tonnes':
            formula = 'Divide the mass value by 1,000,000,000';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 0.015432358352941';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 0.00003527396194958';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 0.000002204622621849';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.00000015747304441777';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.000000078736522208885';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.000000019684130552221';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.000000022046226218488';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.00000000098420652761106';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.0000000011023113109244';
            break;
          case 'Carats':
            formula = 'Divide the mass value by 200';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 0.000032150746568628';
            break;
          case 'Milligrams': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Grams':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 1,000,000';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 1,000';
            break;
          case 'Kilograms':
            formula = 'Divide the mass value by 1,000';
            break;
          case 'Tonnes':
            formula = 'Divide the mass value by 1,000,000';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 15.432358352941';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 0.03527396194958';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 0.002204622621849';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.00015747304441777';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.000078736522208885';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.000019684130552221';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.000022046226218488';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.00000098420652761106';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.0000011023113109244';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 5';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 0.032150746568628';
            break;
          case 'Grams': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Kilograms':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 1,000,000,000';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 1,000,000';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 1,000';
            break;
          case 'Tonnes':
            formula = 'Divide the mass value by 1,000';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 15,432.358352941';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 35.27396194958';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 2.204622621849';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.15747304441777';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.078736522208885';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.019684130552221';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.022046226218488';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.00098420652761106';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.0011023113109244';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 5,000';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 32.150746568628';
            break;
          case 'Kilograms': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Tonnes':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 1,000,000,000,000';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 1,000,000,000';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 1,000,000';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 1,000';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 15,432,358.352941';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 35,273.96194958';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 2,204.622621849';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 157.47304441777';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 78.736522208885';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 19.684130552221';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 22.046226218488';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.98420652761106';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 1.1023113109244';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 5,000,000';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 32,150.746568628';
            break;
          case 'Tonnes': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Grains':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 64,798.91';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 64.79891';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 0.06479891';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 0.00006479891';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.00000006479891';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 0.00228571429';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 0.000142857143';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.00001020408163';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.00000255102041';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.0000012755102';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.00000142857143';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.00000006377551';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.00000007142857';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 0.32399455';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 0.00208333333';
            break;
          case 'Grains': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Ounces':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 28,349,523.1';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 28,349.5231';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 28.3495231';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 0.0283495231';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.0000283495231';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 437.5';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 0.0625';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.00446428571';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.00111607143';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.000559006211';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.000625';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.0000279017857';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.00003125';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 141.747616';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 0.911458333';
            break;
          case 'Ounces': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Pounds':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 453,592,370';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 453,592.37';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 453.59237';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 0.45359237';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.00045359237';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 7,000';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 16';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.0714285714';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.0178571429';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.00892857143';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.01';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.000446428571';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.0005';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 2,267.96185';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 14.5833333';
            break;
          case 'Pounds': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Stones':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 6,350,293,180';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 6,350,293.18';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 6,350.29318';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 6.35029318';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.00635029318';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 98,000';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 224';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 14';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.25';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.125';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.14';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.00625';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.007';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 31,751.4659';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 204.166667';
            break;
          case 'Stones': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Quarters':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 12,700,586,400';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 12,700,586.4';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 12,700.5864';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 12.7005864';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.0127005864';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 196,000';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 448';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 28';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 2';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.5';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.56';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.0125';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.014';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 63,502.932';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 408.333333';
            break;
          case 'Quarters': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Hundredweight (lmp)':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 50,802,345,440';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 50,802,345.44';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 50,802.34544';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 50.80234544';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.05080234544';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 784,000';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 1,792';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 112';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 8';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 2';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 1.12';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.05';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.056';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 254,011.772';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 1,632.66667';
            break;
          case 'Hundredweight (lmp)': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Hundredweight (US)':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 45,359,237,000';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 45,359,237';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 45,359.237';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 45.359237';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.045359237';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 700,000';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 1,600';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 100';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 7.14285714';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 1.78571429';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.892857143';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.0446428571';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.05';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 226,796.185';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 1,458.33333';
            break;
          case 'Hundredweight (US)': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Long Tons (lmp)':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 1,016,046,908,800';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 1,016,046,908.8';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 1,016,046.9088';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 1,016.0469088';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 1.0160469088';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 15,680,000';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 35,840';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 2,240';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 160';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 40';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 20';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 22.4';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 1.12';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 5,080,234.544';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 32,666.6667';
            break;
          case 'Long Tons (lmp)': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Short Tons (US)':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 907,184,740,000';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 907,184,740';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 907,184.74';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 907.18474';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.90718474';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 14,000,000';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 32,000';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 2,000';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 142.857143';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 35.7142857';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 17.8571429';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 20';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.892857143';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 4,535,923.7';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 29,166.6667';
            break;
          case 'Short Tons (US)': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Carats':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 200,000';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 200';
            break;
          case 'Grams':
            formula = 'Divide the mass value by 5';
            break;
          case 'Kilograms':
            formula = 'Divide the mass value by 5,000';
            break;
          case 'Tonnes':
            formula = 'Divide the mass value by 5,000,000';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 3.08647167';
            break;
          case 'Ounces':
            formula = 'Multiply the mass value by 0.00705479239';
            break;
          case 'Pounds':
            formula = 'Multiply the mass value by 0.000440924524';
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.0000314946089';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.00000787365223';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.00000393682611';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.00000440924524';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.000000196841306';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.000000220462262';
            break;
          case 'Troy Ounces':
            formula = 'Multiply the mass value by 0.00643014931';
            break;
          case 'Carats': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;

      case 'Troy Ounces':
        switch (toUnit) {
          case 'Micrograms':
            formula = 'Multiply the mass value by 31,103,476.8';
            break;
          case 'Milligrams':
            formula = 'Multiply the mass value by 31,103.4768';
            break;
          case 'Grams':
            formula = 'Multiply the mass value by 31.1034768';
            break;
          case 'Kilograms':
            formula = 'Multiply the mass value by 0.0311034768';
            break;
          case 'Tonnes':
            formula = 'Multiply the mass value by 0.0000311034768';
            break;
          case 'Grains':
            formula = 'Multiply the mass value by 480';
            break;
          case 'Ounces':
            formula =
                'Multiply the mass value by 1.09714286'; // Avoirdupois ounces
            break;
          case 'Pounds':
            formula =
                'Multiply the mass value by 0.0685714286'; // Avoirdupois pounds
            break;
          case 'Stones':
            formula = 'Multiply the mass value by 0.00489795918';
            break;
          case 'Quarters':
            formula = 'Multiply the mass value by 0.0012244898';
            break;
          case 'Hundredweight (lmp)':
            formula = 'Multiply the mass value by 0.000612244898';
            break;
          case 'Hundredweight (US)':
            formula = 'Multiply the mass value by 0.000682857143';
            break;
          case 'Long Tons (lmp)':
            formula = 'Multiply the mass value by 0.0000306122449';
            break;
          case 'Short Tons (US)':
            formula = 'Multiply the mass value by 0.0000342857143';
            break;
          case 'Carats':
            formula = 'Multiply the mass value by 155.517384';
            break;
          case 'Troy Ounces': // No conversion needed if from and to units are the same
            formula = 'The value remains unchanged';
            break;
          default:
            formula = 'Unknown conversion';
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
                    'Convert Mass',
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
      case 'Micrograms':
        return 'µg'; // Microgram symbol
      case 'Milligrams':
        return 'mg'; // Milligram symbol
      case 'Grams':
        return 'g'; // Gram symbol
      case 'Kilograms':
        return 'kg'; // Kilogram symbol
      case 'Tonnes':
        return 't'; // Tonne symbol
      case 'Grains':
        return 'gr'; // Grain symbol
      case 'Ounces':
        return 'oz'; // Ounce symbol
      case 'Pounds':
        return 'lb'; // Pound symbol
      case 'Stones':
        return 'st'; // Stone symbol
      case 'Quarters':
        return 'qr'; // Quarter symbol
      case 'Hundredweight (lmp)':
        return 'cwt (Imp)'; // Imperial hundredweight symbol
      case 'Hundredweight (US)':
        return 'cwt (US)'; // US hundredweight symbol
      case 'Long Tons (lmp)':
        return 'long tn'; // Long ton (Imperial) symbol
      case 'Short Tons (US)':
        return 'sh tn'; // Short ton (US) symbol
      case 'Carats':
        return 'ct'; // Carat symbol
      case 'Troy Ounces':
        return 'oz t'; // Troy ounce symbol
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
      'Micrograms',
      'Milligrams',
      'Grams',
      'Kilograms',
      'Tonnes',
      'Grains',
      'Ounces',
      'Pounds',
      'Stones',
      'Quarters',
      'Hundredweight (lmp)',
      'Hundredweight (US)',
      'Long Tons (lmp)',
      'Short Tons (US)',
      'Carats',
      'Troy Ounces',
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

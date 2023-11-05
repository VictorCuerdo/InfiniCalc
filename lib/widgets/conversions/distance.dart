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

    // Conversion constants for Meters to other units
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
    const double meterToLightYear = 1 / (299792458 * 31557600);

    // Conversion constants for Picometers to other units
    const double picometerToCentimeter = 1e10;
    const double picometerToNanometer = 1e3;
    const double picometerToMicrometer = 1e6;
    const double picometerToMillimeter = 1e9;
    const double picometerToKilometer = 1e15;
    const double picometerToAngstrom = 1e2;
    const double picometerToThou = 1e12 / meterToThou;
    const double picometerToInch = 1e12 / meterToInch;
    const double picometerToFoot = 1e12 / meterToFoot;
    const double picometerToYard = 1e12 / meterToYard;
    const double picometerToChain = 1e12 / meterToChain;
    const double picometerToFurlong = 1e12 / meterToFurlong;
    const double picometerToMile = 1e12 / meterToMile;
    const double picometerToFathom = 1e12 / meterToFathom;
    const double picometerToCable = 1e12 / meterToCable;
    const double picometerToNauticalMile = 1e12 / meterToNauticalMile;
    const double picometerToAstronomicalUnit = 1e12 / meterToAstronomicalUnit;
    const double picometerToLightYear = 1e-12 / (9.461e15);
    const double picometerToParsec = 1e-12 / (3.086e16);

    // Conversion constants from Nanometers to other units
    const double nanometerToPicometer = 1e3;
    const double nanometerToMicrometer = 1e-3;
    const double nanometerToMillimeter = 1e-6;
    const double nanometerToCentimeter = 1e-7;
    const double nanometerToMeter = 1e-9;
    const double nanometerToKilometer = 1e-12;
    const double nanometerToAngstrom = 10;
    const double nanometerToThou = nanometerToMeter * meterToThou;
    const double nanometerToInch = nanometerToMeter * meterToInch;
    const double nanometerToFoot = nanometerToMeter * meterToFoot;
    const double nanometerToYard = nanometerToMeter * meterToYard;
    const double nanometerToChain = nanometerToMeter * meterToChain;
    const double nanometerToFurlong = nanometerToMeter * meterToFurlong;
    const double nanometerToMile = nanometerToMeter * meterToMile;
    const double nanometerToFathom = nanometerToMeter * meterToFathom;
    const double nanometerToCable = nanometerToMeter * meterToCable;
    const double nanometerToNauticalMile =
        nanometerToMeter * meterToNauticalMile;
    const double nanometerToAstronomicalUnit =
        nanometerToMeter * meterToAstronomicalUnit;
    const double nanometerToLightYear = nanometerToMeter * meterToLightYear;
    const double nanometerToParsec = nanometerToMeter * meterToParsec;
// Conversion constants from Centimeters to other units
    const double centimeterToMeter = 1e-2;
    const double centimeterToPicometer = 1e10;
    const double centimeterToNanometer = 1e7;
    const double centimeterToMicrometer = 1e4;
    const double centimeterToMillimeter = 10;
    const double centimeterToKilometer = 1e-5;
    const double centimeterToAngstrom = 1e8;
    const double centimeterToThou = centimeterToMeter * meterToThou;
    const double centimeterToInch = centimeterToMeter * meterToInch;
    const double centimeterToFoot = centimeterToMeter * meterToFoot;
    const double centimeterToYard = centimeterToMeter * meterToYard;
    const double centimeterToChain = centimeterToMeter * meterToChain;
    const double centimeterToFurlong = centimeterToMeter * meterToFurlong;
    const double centimeterToMile = centimeterToMeter * meterToMile;
    const double centimeterToFathom = centimeterToMeter * meterToFathom;
    const double centimeterToCable = centimeterToMeter * meterToCable;
    const double centimeterToNauticalMile =
        centimeterToMeter * meterToNauticalMile;
    const double centimeterToAstronomicalUnit =
        centimeterToMeter * meterToAstronomicalUnit;
    const double centimeterToLightYear = centimeterToMeter * meterToLightYear;
    const double centimeterToParsec = centimeterToMeter * meterToParsec;

    // Conversion constants from Millimeters to other units
    const double millimeterToMeter = 1e-3;
    const double millimeterToPicometer = 1e9;
    const double millimeterToNanometer = 1e6;
    const double millimeterToMicrometer = 1e3;
    const double millimeterToCentimeter = 1e-1;
    const double millimeterToKilometer = 1e-6;
    const double millimeterToAngstrom = 1e7;
    const double millimeterToThou = millimeterToMeter * meterToThou;
    const double millimeterToInch = millimeterToMeter * meterToInch;
    const double millimeterToFoot = millimeterToMeter * meterToFoot;
    const double millimeterToYard = millimeterToMeter * meterToYard;
    const double millimeterToChain = millimeterToMeter * meterToChain;
    const double millimeterToFurlong = millimeterToMeter * meterToFurlong;
    const double millimeterToMile = millimeterToMeter * meterToMile;
    const double millimeterToFathom = millimeterToMeter * meterToFathom;
    const double millimeterToCable = millimeterToMeter * meterToCable;
    const double millimeterToNauticalMile =
        millimeterToMeter * meterToNauticalMile;
    const double millimeterToAstronomicalUnit =
        millimeterToMeter * meterToAstronomicalUnit;
    const double millimeterToLightYear = millimeterToMeter * meterToLightYear;
    const double millimeterToParsec = millimeterToMeter * meterToParsec;

    // Conversion constants from Micrometers to other units
    const double micrometerToCentimeter = 1e-4;
    const double micrometerToMeter = 1e-6;
    const double micrometerToPicometer = 1e6;
    const double micrometerToNanometer = 1e3;
    const double micrometerToMillimeter = 1e-3;
    const double micrometerToKilometer = 1e-9;
    const double micrometerToAngstrom = 1e4;
    const double micrometerToThou = micrometerToMeter * meterToThou;
    const double micrometerToInch = micrometerToMeter * meterToInch;
    const double micrometerToFoot = micrometerToMeter * meterToFoot;
    const double micrometerToYard = micrometerToMeter * meterToYard;
    const double micrometerToChain = micrometerToMeter * meterToChain;
    const double micrometerToFurlong = micrometerToMeter * meterToFurlong;
    const double micrometerToMile = micrometerToMeter * meterToMile;
    const double micrometerToFathom = micrometerToMeter * meterToFathom;
    const double micrometerToCable = micrometerToMeter * meterToCable;
    const double micrometerToNauticalMile =
        micrometerToMeter * meterToNauticalMile;
    const double micrometerToAstronomicalUnit =
        micrometerToMeter * meterToAstronomicalUnit;
    const double micrometerToLightYear = micrometerToMeter * meterToLightYear;
    const double micrometerToParsec = micrometerToMeter * meterToParsec;
// Conversion constants from Kilometers to other units
    const double kilometerToMicrometer = 1e9;
    const double kilometerToCentimeter = 1e5;
    const double kilometerToMeter = 1e3;
    const double kilometerToPicometer = 1e12;
    const double kilometerToNanometer = 1e12;
    const double kilometerToMillimeter = 1e6;
    const double kilometerToAngstrom = 1e13;
    const double kilometerToThou = kilometerToMeter * meterToThou;
    const double kilometerToInch = kilometerToMeter * meterToInch;
    const double kilometerToFoot = kilometerToMeter * meterToFoot;
    const double kilometerToYard = kilometerToMeter * meterToYard;
    const double kilometerToChain = kilometerToMeter * meterToChain;
    const double kilometerToFurlong = kilometerToMeter * meterToFurlong;
    const double kilometerToMile = kilometerToMeter * meterToMile;
    const double kilometerToFathom = kilometerToMeter * meterToFathom;
    const double kilometerToCable = kilometerToMeter * meterToCable;
    const double kilometerToNauticalMile =
        kilometerToMeter * meterToNauticalMile;
    const double kilometerToAstronomicalUnit =
        kilometerToMeter * meterToAstronomicalUnit;
    const double kilometerToLightYear = kilometerToMeter * meterToLightYear;
    const double kilometerToParsec = kilometerToMeter * meterToParsec;
    switch (fromUnit) {
      // METERS UNIT CONVERSION
      case 'Meters':
        switch (toUnit) {
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
          case 'Centimeters':
            toValue = fromValue * meterToCentimeter;
            break;
          case 'Meters':
            toValue = fromValue;
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
          case 'Light years':
            toValue = fromValue * meterToLightYear;
            break;
          case 'Parsecs':
            toValue = fromValue * meterToParsec;
            break;
        }
        break;
// PICOMETERS UNIT CONVERSION
      case 'Picometers':
        switch (toUnit) {
          case 'Picometers':
            toValue = fromValue;
            break;
          case 'Nanometers':
            toValue = fromValue / picometerToNanometer;
            break;
          case 'Micrometers':
            toValue = fromValue / picometerToMicrometer;
            break;
          case 'Millimeters':
            toValue = fromValue / picometerToMillimeter;
            break;
          case 'Centimeters':
            toValue = fromValue / picometerToCentimeter;
            break;
          case 'Meters':
            toValue = fromValue / meterToPicometer;
            break;
          case 'Kilometers':
            toValue = fromValue / picometerToKilometer;
            break;
          case 'Angstrom':
            toValue = fromValue / picometerToAngstrom;
            break;
          case 'Thou':
            toValue = fromValue / picometerToThou;
            break;
          case 'Inches':
            toValue = fromValue / picometerToInch;
            break;
          case 'Feet':
            toValue = fromValue / picometerToFoot;
            break;
          case 'Yards':
            toValue = fromValue / picometerToYard;
            break;
          case 'Chains':
            toValue = fromValue / picometerToChain;
            break;
          case 'Furlongs':
            toValue = fromValue / picometerToFurlong;
            break;
          case 'Miles':
            toValue = fromValue / picometerToMile;
            break;
          case 'Fathoms':
            toValue = fromValue / picometerToFathom;
            break;
          case 'Cables':
            toValue = fromValue / picometerToCable;
            break;
          case 'Nautical miles':
            toValue = fromValue / picometerToNauticalMile;
            break;
          case 'Astronomical units':
            toValue = fromValue / picometerToAstronomicalUnit;
            break;
          case 'Light years':
            toValue = fromValue * picometerToLightYear;
            break;
          case 'Parsecs':
            toValue = fromValue * picometerToParsec;
            break;
          // Add cases for any additional units here
        }
        break;
// NANOMETERS UNIT CONVERSION
      case 'Nanometers':
        switch (toUnit) {
          case 'Nanometers':
            toValue = fromValue;
            break;
          case 'Picometers':
            toValue = fromValue * nanometerToPicometer;
            break;
          case 'Micrometers':
            toValue = fromValue * nanometerToMicrometer;
            break;
          case 'Millimeters':
            toValue = fromValue * nanometerToMillimeter;
            break;
          case 'Centimeters':
            toValue = fromValue * nanometerToCentimeter;
            break;
          case 'Meters':
            toValue = fromValue * nanometerToMeter;
            break;
          case 'Kilometers':
            toValue = fromValue * nanometerToKilometer;
            break;
          case 'Angstrom':
            toValue = fromValue * nanometerToAngstrom;
            break;
          case 'Thou':
            toValue = fromValue * nanometerToThou;
            break;
          case 'Inches':
            toValue = fromValue * nanometerToInch;
            break;
          case 'Feet':
            toValue = fromValue * nanometerToFoot;
            break;
          case 'Yards':
            toValue = fromValue * nanometerToYard;
            break;
          case 'Chains':
            toValue = fromValue * nanometerToChain;
            break;
          case 'Furlongs':
            toValue = fromValue * nanometerToFurlong;
            break;
          case 'Miles':
            toValue = fromValue * nanometerToMile;
            break;
          case 'Fathoms':
            toValue = fromValue * nanometerToFathom;
            break;
          case 'Cables':
            toValue = fromValue * nanometerToCable;
            break;
          case 'Nautical miles':
            toValue = fromValue * nanometerToNauticalMile;
            break;
          case 'Astronomical units':
            toValue = fromValue * nanometerToAstronomicalUnit;
            break;
          case 'Light years':
            toValue = fromValue * nanometerToLightYear;
            break;
          case 'Parsecs':
            toValue = fromValue * nanometerToParsec;
            break;
          // ... repeat for each unit ...
        }
        break;

      // ... repeat similar structure for Micrometers, Millimeters, etc. ...
// CENTIMETERS UNIT CONVERSION
      case 'Centimeters':
        switch (toUnit) {
          case 'Centimeters':
            toValue = fromValue;
            break;
          case 'Meters':
            toValue = fromValue * centimeterToMeter;
            break;
          case 'Picometers':
            toValue = fromValue * centimeterToPicometer;
            break;
          case 'Nanometers':
            toValue = fromValue * centimeterToNanometer;
            break;
          case 'Micrometers':
            toValue = fromValue * centimeterToMicrometer;
            break;
          case 'Millimeters':
            toValue = fromValue * centimeterToMillimeter;
            break;
          case 'Kilometers':
            toValue = fromValue * centimeterToKilometer;
            break;
          case 'Angstrom':
            toValue = fromValue * centimeterToAngstrom;
            break;
          case 'Thou':
            toValue = fromValue * centimeterToThou;
            break;
          case 'Inches':
            toValue = fromValue * centimeterToInch;
            break;
          case 'Feet':
            toValue = fromValue * centimeterToFoot;
            break;
          case 'Yards':
            toValue = fromValue * centimeterToYard;
            break;
          case 'Chains':
            toValue = fromValue * centimeterToChain;
            break;
          case 'Furlongs':
            toValue = fromValue * centimeterToFurlong;
            break;
          case 'Miles':
            toValue = fromValue * centimeterToMile;
            break;
          case 'Fathoms':
            toValue = fromValue * centimeterToFathom;
            break;
          case 'Cables':
            toValue = fromValue * centimeterToCable;
            break;
          case 'Nautical miles':
            toValue = fromValue * centimeterToNauticalMile;
            break;
          case 'Astronomical units':
            toValue = fromValue * centimeterToAstronomicalUnit;
            break;
          case 'Light years':
            toValue = fromValue * centimeterToLightYear;
            break;
          case 'Parsecs':
            toValue = fromValue * centimeterToParsec;
            break;
          // ... repeat for each unit ...
        }
        break;

// MILLIMETERS UNIT CONVERSION
      case 'Millimeters':
        switch (toUnit) {
          case 'Millimeters':
            toValue = fromValue;
            break;
          case 'Centimeters':
            toValue = fromValue * millimeterToCentimeter;
            break;
          case 'Meters':
            toValue = fromValue * millimeterToMeter;
            break;
          case 'Picometers':
            toValue = fromValue * millimeterToPicometer;
            break;
          case 'Nanometers':
            toValue = fromValue * millimeterToNanometer;
            break;
          case 'Micrometers':
            toValue = fromValue * millimeterToMicrometer;
            break;
          case 'Kilometers':
            toValue = fromValue * millimeterToKilometer;
            break;
          case 'Angstrom':
            toValue = fromValue * millimeterToAngstrom;
            break;
          case 'Thou':
            toValue = fromValue * millimeterToThou;
            break;
          case 'Inches':
            toValue = fromValue * millimeterToInch;
            break;
          case 'Feet':
            toValue = fromValue * millimeterToFoot;
            break;
          case 'Yards':
            toValue = fromValue * millimeterToYard;
            break;
          case 'Chains':
            toValue = fromValue * millimeterToChain;
            break;
          case 'Furlongs':
            toValue = fromValue * millimeterToFurlong;
            break;
          case 'Miles':
            toValue = fromValue * millimeterToMile;
            break;
          case 'Fathoms':
            toValue = fromValue * millimeterToFathom;
            break;
          case 'Cables':
            toValue = fromValue * millimeterToCable;
            break;
          case 'Nautical miles':
            toValue = fromValue * millimeterToNauticalMile;
            break;
          case 'Astronomical units':
            toValue = fromValue * millimeterToAstronomicalUnit;
            break;
          case 'Light years':
            toValue = fromValue * millimeterToLightYear;
            break;
          case 'Parsecs':
            toValue = fromValue * millimeterToParsec;
            break;
        }

        break;

// MICROMETERS UNIT CONVERSION
      case 'Micrometers':
        switch (toUnit) {
          case 'Micrometers':
            toValue = fromValue;
            break;
          case 'Centimeters':
            toValue = fromValue * micrometerToCentimeter;
            break;
          case 'Meters':
            toValue = fromValue * micrometerToMeter;
            break;
          case 'Picometers':
            toValue = fromValue * micrometerToPicometer;
            break;
          case 'Nanometers':
            toValue = fromValue * micrometerToNanometer;
            break;
          case 'Millimeters':
            toValue = fromValue * micrometerToMillimeter;
            break;
          case 'Kilometers':
            toValue = fromValue * micrometerToKilometer;
            break;
          case 'Angstrom':
            toValue = fromValue * micrometerToAngstrom;
            break;
          case 'Thou':
            toValue = fromValue * micrometerToThou;
            break;
          case 'Inches':
            toValue = fromValue * micrometerToInch;
            break;
          case 'Feet':
            toValue = fromValue * micrometerToFoot;
            break;
          case 'Yards':
            toValue = fromValue * micrometerToYard;
            break;
          case 'Chains':
            toValue = fromValue * micrometerToChain;
            break;
          case 'Furlongs':
            toValue = fromValue * micrometerToFurlong;
            break;
          case 'Miles':
            toValue = fromValue * micrometerToMile;
            break;
          case 'Fathoms':
            toValue = fromValue * micrometerToFathom;
            break;
          case 'Cables':
            toValue = fromValue * micrometerToCable;
            break;
          case 'Nautical miles':
            toValue = fromValue * micrometerToNauticalMile;
            break;
          case 'Astronomical units':
            toValue = fromValue * micrometerToAstronomicalUnit;
            break;
          case 'Light years':
            toValue = fromValue * micrometerToLightYear;
            break;
          case 'Parsecs':
            toValue = fromValue * micrometerToParsec;
            break;
        }

        break;

      // KILOMETERS UNIT CONVERSION
      case 'Kilometers':
        switch (toUnit) {
          case 'Kilometers':
            toValue = fromValue;
            break;
          case 'Micrometers':
            toValue = fromValue * kilometerToMicrometer;
            break;
          case 'Centimeters':
            toValue = fromValue * kilometerToCentimeter;
            break;
          case 'Meters':
            toValue = fromValue * kilometerToMeter;
            break;
          case 'Picometers':
            toValue = fromValue * kilometerToPicometer;
            break;
          case 'Nanometers':
            toValue = fromValue * kilometerToNanometer;
            break;
          case 'Millimeters':
            toValue = fromValue * kilometerToMillimeter;
            break;
          case 'Angstrom':
            toValue = fromValue * kilometerToAngstrom;
            break;
          case 'Thou':
            toValue = fromValue * kilometerToThou;
            break;
          case 'Inches':
            toValue = fromValue * kilometerToInch;
            break;
          case 'Feet':
            toValue = fromValue * kilometerToFoot;
            break;
          case 'Yards':
            toValue = fromValue * kilometerToYard;
            break;
          case 'Chains':
            toValue = fromValue * kilometerToChain;
            break;
          case 'Furlongs':
            toValue = fromValue * kilometerToFurlong;
            break;
          case 'Miles':
            toValue = fromValue * kilometerToMile;
            break;
          case 'Fathoms':
            toValue = fromValue * kilometerToFathom;
            break;
          case 'Cables':
            toValue = fromValue * kilometerToCable;
            break;
          case 'Nautical miles':
            toValue = fromValue * kilometerToNauticalMile;
            break;
          case 'Astronomical units':
            toValue = fromValue * kilometerToAstronomicalUnit;
            break;
          case 'Light years':
            toValue = fromValue * kilometerToLightYear;
            break;
          case 'Parsecs':
            toValue = fromValue * kilometerToParsec;
            break;
        }

        break;
      // ... and so on for each unit ...

      default:
        // Optionally handle unknown unit conversions
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

      // Swap only the units and prefixes, not the values in the TextFields.
      fromUnit = toUnit;
      fromPrefix = toPrefix;

      toUnit = tempUnit;
      toPrefix = tempPrefix;

      // We do not switch the text values of the controllers anymore.
      // fromController.text and toController.text remain unchanged.

      convert();
      _conversionFormula =
          _getConversionFormula(); // Update formula text if needed
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

              const SizedBox(height: 165),
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
                  // fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),

                overflow: TextOverflow.visible,
                // Use ellipsis for text overflow
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
      selectedItemBuilder: (BuildContext context) {
        return items.map((DropdownMenuItem<String> item) {
          return Center(
            // Center only the selected item
            child: Text(
              item.value!,
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

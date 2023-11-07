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

class TorqueUnitConverter extends StatefulWidget {
  const TorqueUnitConverter({super.key});

  @override
  _TorqueUnitConverterState createState() => _TorqueUnitConverterState();
}

class _TorqueUnitConverterState extends State<TorqueUnitConverter> {
  String fromUnit = 'Micronewton Meter';
  String toUnit = 'Millinewton Meter';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool _isExponentialFormat = false;
  // Flag to indicate if the change is due to user input
  bool _isUserInput = true;
  // Using string variables for prefixes
  String fromPrefix = 'µNm';
  String toPrefix = 'mNm';
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
          text: 'Check out my torque result!');
    }
  }

  void convert(String text) {
    String normalizedText = text.replaceAll(',', '.');
    if (normalizedText.isEmpty) return;
    var fromValue = double.tryParse(normalizedText);
    if (fromValue == null) return;
    double toValue = 0; // Your conversion logic here
// region myVariables
    const double micronewtonMeterToMicronewtonMeter = 1;
    const double micronewtonMeterToMillinewtonMeter = 1e-3;
    const double micronewtonMeterToNewtonMeter = 1e-6;
    const double micronewtonMeterToKilonewtonMeter = 1e-9;
    const double micronewtonMeterToMeganewtonMeter = 1e-12;
    const double micronewtonMeterToNewtonCentimeter = 1e-4;
    const double micronewtonMeterToNewtonMillimeter = 1e-3;
    const double micronewtonMeterToGramForceMeter =
        1.019716212977928e-4; // 1 Nm = 101.9716212977928 gf·m
    const double micronewtonMeterToGramForceCentimeter =
        1.019716212977928e-2; // 1 Nm = 10197.16212977928 gf·cm
    const double micronewtonMeterToGramForceMillimeter =
        1.019716212977928e-1; // 1 Nm = 101971.6212977928 gf·mm
    const double micronewtonMeterToKilogramForceMeter =
        1.019716212977928e-7; // 1 Nm = 0.1019716212977928 kgf·m
    const double micronewtonMeterToKilogramForceCentimeter =
        1.019716212977928e-5; // 1 Nm = 10.19716212977928 kgf·cm
    const double micronewtonMeterToKilogramForceMillimeter =
        1.019716212977928e-4; // 1 Nm = 101.9716212977928 kgf·mm
    const double micronewtonMeterToDyneMeter =
        10; // 1 Nm = 10^7 dyne·cm, 1 dyne·cm = 10^-7 Nm and 1 dyne·m = 10^-5 Nm
    const double micronewtonMeterToDyneCentimeter = 1e3; // 1 Nm = 10^7 dyne·cm
    const double micronewtonMeterToDyneMillimeter = 1e4; // 1 dyne·mm = 10^-6 Nm
    const double micronewtonMeterToPoundForceFoot =
        7.375621492772e-8; // 1 Nm = 0.7375621492772 lb·ft
    const double micronewtonMeterToPoundForceInch =
        8.850745791327184e-7; // 1 Nm = 8.850745791327184 lb·in
    const double micronewtonMeterToOunceForceFoot =
        1.180094786104e-6; // 1 lb·ft = 16 oz·ft, hence 1 Nm = 0.7375621492772 * 16 oz·ft
    const double micronewtonMeterToOunceForceInch =
        1.416113747325e-5; // 1 lb·in = 16 oz·in, hence 1 Nm = 8.850745791327184 * 16 oz·in

    const double millinewtonMeterToMicronewtonMeter = 1000;
    const double millinewtonMeterToMillinewtonMeter = 1;
    const double millinewtonMeterToNewtonMeter = 0.001;
    const double millinewtonMeterToKilonewtonMeter = 1e-6;
    const double millinewtonMeterToMeganewtonMeter = 1e-9;
    const double millinewtonMeterToNewtonCentimeter = 0.1;
    const double millinewtonMeterToNewtonMillimeter = 1;
    const double millinewtonMeterToGramForceMeter = 0.101971621;
    const double millinewtonMeterToGramForceCentimeter = 10.1971621;
    const double millinewtonMeterToGramForceMillimeter = 101.971621;
    const double millinewtonMeterToKilogramForceMeter = 0.000101971621;
    const double millinewtonMeterToKilogramForceCentimeter = 0.0101971621;
    const double millinewtonMeterToKilogramForceMillimeter = 0.101971621;
    const double millinewtonMeterToDyneMeter = 10000;
    const double millinewtonMeterToDyneCentimeter = 1e6;
    const double millinewtonMeterToDyneMillimeter = 1e7;
    const double millinewtonMeterToPoundForceFoot = 0.000737562;
    const double millinewtonMeterToPoundForceInch = 0.008850746;
    const double millinewtonMeterToOunceForceFoot = 0.011800948;
    const double millinewtonMeterToOunceForceInch = 0.141611375;

    const double newtonMeterToMicronewtonMeter = 1e6;
    const double newtonMeterToMillinewtonMeter = 1000;
    const double newtonMeterToNewtonMeter = 1;
    const double newtonMeterToKilonewtonMeter = 0.001;
    const double newtonMeterToMeganewtonMeter = 1e-6;
    const double newtonMeterToNewtonCentimeter = 100;
    const double newtonMeterToNewtonMillimeter = 1000;
    const double newtonMeterToGramForceMeter =
        101.9716212978; // 1 Nm = 101.9716212978 gf·m
    const double newtonMeterToGramForceCentimeter =
        10197.16212978; // 1 Nm = 10197.16212978 gf·cm
    const double newtonMeterToGramForceMillimeter =
        101971.6212978; // 1 Nm = 101971.6212978 gf·mm
    const double newtonMeterToKilogramForceMeter =
        0.1019716212978; // 1 Nm = 0.1019716212978 kgf·m
    const double newtonMeterToKilogramForceCentimeter =
        10.19716212978; // 1 Nm = 10.19716212978 kgf·cm
    const double newtonMeterToKilogramForceMillimeter =
        101.9716212978; // 1 Nm = 101.9716212978 kgf·mm
    const double newtonMeterToDyneMeter = 1e7;
    const double newtonMeterToDyneCentimeter = 1e5;
    const double newtonMeterToDyneMillimeter = 1e6;
    const double newtonMeterToPoundForceFoot =
        0.7375621492773; // 1 Nm = 0.7375621492773 lbf·ft
    const double newtonMeterToPoundForceInch =
        8.8507457673787; // 1 Nm = 8.8507457673787 lbf·in
    const double newtonMeterToOunceForceFoot =
        11.800943607046; // 1 lbf·ft = 16 ozf·ft, hence 1 Nm = 0.7375621492773 * 16 ozf·ft
    const double newtonMeterToOunceForceInch =
        141.61172488474; // 1 lbf·in = 16 ozf·in, hence 1 Nm = 8.8507457673787 * 16 ozf·in

    const double kilonewtonMeterToMicronewtonMeter = 1e9;
    const double kilonewtonMeterToMillinewtonMeter = 1e6;
    const double kilonewtonMeterToNewtonMeter = 1000;
    const double kilonewtonMeterToKilonewtonMeter = 1;
    const double kilonewtonMeterToMeganewtonMeter = 0.001;
    const double kilonewtonMeterToNewtonCentimeter = 100000;
    const double kilonewtonMeterToNewtonMillimeter = 1000000;
    const double kilonewtonMeterToGramForceMeter =
        101971.621298; // 1 kNm = 101971.621298 gf·m
    const double kilonewtonMeterToGramForceCentimeter =
        10197162.1298; // 1 kNm = 10197162.1298 gf·cm
    const double kilonewtonMeterToGramForceMillimeter =
        101971621.298; // 1 kNm = 101971621.298 gf·mm
    const double kilonewtonMeterToKilogramForceMeter =
        101.971621298; // 1 kNm = 101.971621298 kgf·m
    const double kilonewtonMeterToKilogramForceCentimeter =
        10197.1621298; // 1 kNm = 10197.1621298 kgf·cm
    const double kilonewtonMeterToKilogramForceMillimeter =
        101971.621298; // 1 kNm = 101971.621298 kgf·mm
    const double kilonewtonMeterToDyneMeter = 1e10;
    const double kilonewtonMeterToDyneCentimeter = 1e8;
    const double kilonewtonMeterToDyneMillimeter = 1e9;
    const double kilonewtonMeterToPoundForceFoot =
        737.5621492773; // 1 kNm = 737.5621492773 lbf·ft
    const double kilonewtonMeterToPoundForceInch =
        8850.7457673787; // 1 kNm = 8850.7457673787 lbf·in
    const double kilonewtonMeterToOunceForceFoot =
        11800.943607046; // 1 lbf·ft = 16 ozf·ft, hence 1 kNm = 737.5621492773 * 16 ozf·ft
    const double kilonewtonMeterToOunceForceInch =
        141611.72488474; // 1 lbf·in = 16 ozf·in, hence 1 kNm = 8850.7457673787 * 16 ozf·in

    const double meganewtonMeterToMicronewtonMeter = 1e12;
    const double meganewtonMeterToMillinewtonMeter = 1e9;
    const double meganewtonMeterToNewtonMeter = 1e6;
    const double meganewtonMeterToKilonewtonMeter = 1000;
    const double meganewtonMeterToMeganewtonMeter = 1;
    const double meganewtonMeterToNewtonCentimeter = 1e8;
    const double meganewtonMeterToNewtonMillimeter = 1e9;
    const double meganewtonMeterToGramForceMeter =
        1.019716212977928e8; // 1 MNm = 1.019716212977928e8 gf·m
    const double meganewtonMeterToGramForceCentimeter =
        1.019716212977928e10; // 1 MNm = 1.019716212977928e10 gf·cm
    const double meganewtonMeterToGramForceMillimeter =
        1.019716212977928e11; // 1 MNm = 1.019716212977928e11 gf·mm
    const double meganewtonMeterToKilogramForceMeter =
        1.019716212977928e5; // 1 MNm = 1.019716212977928e5 kgf·m
    const double meganewtonMeterToKilogramForceCentimeter =
        1.019716212977928e7; // 1 MNm = 1.019716212977928e7 kgf·cm
    const double meganewtonMeterToKilogramForceMillimeter =
        1.019716212977928e8; // 1 MNm = 1.019716212977928e8 kgf·mm
    const double meganewtonMeterToDyneMeter = 1e13;
    const double meganewtonMeterToDyneCentimeter = 1e11;
    const double meganewtonMeterToDyneMillimeter = 1e12;
    const double meganewtonMeterToPoundForceFoot =
        737562.1492773; // 1 MNm = 737562.1492773 lbf·ft
    const double meganewtonMeterToPoundForceInch =
        8850745.7673787; // 1 MNm = 8850745.7673787 lbf·in
    const double meganewtonMeterToOunceForceFoot =
        11800943.607046; // 1 MNm = 11800943.607046 ozf·ft
    const double meganewtonMeterToOunceForceInch =
        141611724.88474; // 1 MNm = 141611724.88474 ozf·in

    const double newtonCentimeterToMicronewtonMeter = 10000;
    const double newtonCentimeterToMillinewtonMeter = 10;
    const double newtonCentimeterToNewtonMeter = 0.01;
    const double newtonCentimeterToKilonewtonMeter = 1e-5;
    const double newtonCentimeterToMeganewtonMeter = 1e-8;
    const double newtonCentimeterToNewtonCentimeter = 1;
    const double newtonCentimeterToNewtonMillimeter = 10;
    const double newtonCentimeterToGramForceMeter =
        1.019716212977928; // 1 Ncm = 1.019716212977928 gf·m
    const double newtonCentimeterToGramForceCentimeter =
        101.9716212977928; // 1 Ncm = 101.9716212977928 gf·cm
    const double newtonCentimeterToGramForceMillimeter =
        1019.716212977928; // 1 Ncm = 1019.716212977928 gf·mm
    const double newtonCentimeterToKilogramForceMeter =
        0.001019716212977928; // 1 Ncm = 0.001019716212977928 kgf·m
    const double newtonCentimeterToKilogramForceCentimeter =
        0.1019716212977928; // 1 Ncm = 0.1019716212977928 kgf·cm
    const double newtonCentimeterToKilogramForceMillimeter =
        1.019716212977928; // 1 Ncm = 1.019716212977928 kgf·mm
    const double newtonCentimeterToDyneMeter = 100000;
    const double newtonCentimeterToDyneCentimeter = 1000000;
    const double newtonCentimeterToDyneMillimeter = 10000000;
    const double newtonCentimeterToPoundForceFoot =
        0.007375621492772; // 1 Ncm = 0.007375621492772 lbf·ft
    const double newtonCentimeterToPoundForceInch =
        0.088507457773787; // 1 Ncm = 0.088507457773787 lbf·in
    const double newtonCentimeterToOunceForceFoot =
        0.11800943607046; // 1 Ncm = 0.11800943607046 ozf·ft
    const double newtonCentimeterToOunceForceInch =
        1.41611372488474; // 1 Ncm = 1.41611372488474 ozf·in

    const double newtonMillimeterToMicronewtonMeter = 1000;
    const double newtonMillimeterToMillinewtonMeter = 1;
    const double newtonMillimeterToNewtonMeter = 0.001;
    const double newtonMillimeterToKilonewtonMeter = 1e-6;
    const double newtonMillimeterToMeganewtonMeter = 1e-9;
    const double newtonMillimeterToNewtonCentimeter = 0.1;
    const double newtonMillimeterToNewtonMillimeter = 1;
    const double newtonMillimeterToGramForceMeter =
        0.10197162129779283; // 1 Nmm = 0.10197162129779283 gf·m
    const double newtonMillimeterToGramForceCentimeter =
        10.197162129779283; // 1 Nmm = 10.197162129779283 gf·cm
    const double newtonMillimeterToGramForceMillimeter =
        101.97162129779283; // 1 Nmm = 101.97162129779283 gf·mm
    const double newtonMillimeterToKilogramForceMeter =
        0.00010197162129779283; // 1 Nmm = 0.00010197162129779283 kgf·m
    const double newtonMillimeterToKilogramForceCentimeter =
        0.010197162129779283; // 1 Nmm = 0.010197162129779283 kgf·cm
    const double newtonMillimeterToKilogramForceMillimeter =
        0.10197162129779283; // 1 Nmm = 0.10197162129779283 kgf·mm
    const double newtonMillimeterToDyneMeter = 100000;
    const double newtonMillimeterToDyneCentimeter = 10000;
    const double newtonMillimeterToDyneMillimeter = 100000;
    const double newtonMillimeterToPoundForceFoot =
        0.0007375621492773; // 1 Nmm = 0.0007375621492773 lbf·ft
    const double newtonMillimeterToPoundForceInch =
        0.0088507457673787; // 1 Nmm = 0.0088507457673787 lbf·in
    const double newtonMillimeterToOunceForceFoot =
        0.011800943607046; // 1 Nmm = 0.011800943607046 ozf·ft
    const double newtonMillimeterToOunceForceInch =
        0.14161172488474; // 1 Nmm = 0.14161172488474 ozf·in

    const double gramForceMeterToMicronewtonMeter = 9806.65;
    const double gramForceMeterToMillinewtonMeter = 9.80665;
    const double gramForceMeterToNewtonMeter = 0.00980665;
    const double gramForceMeterToKilonewtonMeter = 9.80665e-6;
    const double gramForceMeterToMeganewtonMeter = 9.80665e-9;
    const double gramForceMeterToNewtonCentimeter = 0.980665;
    const double gramForceMeterToNewtonMillimeter = 9.80665;
    const double gramForceMeterToGramForceMeter = 1;
    const double gramForceMeterToGramForceCentimeter = 100;
    const double gramForceMeterToGramForceMillimeter = 1000;
    const double gramForceMeterToKilogramForceMeter = 0.001;
    const double gramForceMeterToKilogramForceCentimeter = 0.1;
    const double gramForceMeterToKilogramForceMillimeter = 1;
    const double gramForceMeterToDyneMeter = 980665;
    const double gramForceMeterToDyneCentimeter = 98066500;
    const double gramForceMeterToDyneMillimeter = 980665000;
    const double gramForceMeterToPoundForceFoot =
        0.0723301374515; // Using the conversion 1 kgf·m = 7.23301374515 lbf·ft and 1 gf·m = 0.001 kgf·m
    const double gramForceMeterToPoundForceInch =
        0.867961649818; // Since there are 12 inches in a foot
    const double gramForceMeterToOunceForceFoot =
        1.15728161874; // Since there are 16 ounces in one pound
    const double gramForceMeterToOunceForceInch =
        13.88737942489; // Since there are 12 inches in a foot and 16 ounces in one pound

    const double gramForceCentimeterToMicronewtonMeter = 98.0665;
    const double gramForceCentimeterToMillinewtonMeter = 0.0980665;
    const double gramForceCentimeterToNewtonMeter = 0.000980665;
    const double gramForceCentimeterToKilonewtonMeter = 9.80665e-7;
    const double gramForceCentimeterToMeganewtonMeter = 9.80665e-10;
    const double gramForceCentimeterToNewtonCentimeter = 1; // by definition
    const double gramForceCentimeterToNewtonMillimeter =
        0.1; // since 1 cm = 10 mm
    const double gramForceCentimeterToGramForceMeter =
        0.01; // since 1 m = 100 cm
    const double gramForceCentimeterToGramForceCentimeter = 1; // by definition
    const double gramForceCentimeterToGramForceMillimeter =
        10; // since 1 cm = 10 mm
    const double gramForceCentimeterToKilogramForceMeter =
        1e-5; // since 1 kgf·m = 100 gf·cm
    const double gramForceCentimeterToKilogramForceCentimeter =
        0.001; // since 1 kgf·cm = 1000 gf·cm
    const double gramForceCentimeterToKilogramForceMillimeter =
        0.01; // since 1 kgf·mm = 100 gf·cm
    const double gramForceCentimeterToDyneMeter =
        9806.65; // since 1 dyne·m = 100 gf·cm
    const double gramForceCentimeterToDyneCentimeter =
        980665; // since 1 dyne·cm = 1 gf·cm
    const double gramForceCentimeterToDyneMillimeter =
        9806650; // since 1 dyne·mm = 10 gf·cm
    const double gramForceCentimeterToPoundForceFoot =
        0.000723301374515; // since 1 lbf·ft = 13825.4954376 gf·cm
    const double gramForceCentimeterToPoundForceInch =
        0.00867961649818; // since 1 lbf·in = 1150.00000062 gf·cm
    const double gramForceCentimeterToOunceForceFoot =
        0.0115728161874; // since 1 ozf·ft = 862.000000049 gf·cm
    const double gramForceCentimeterToOunceForceInch =
        0.138878394489; // since 1 ozf·in = 71.6666666712 gf·cm

    const double gramForceMillimeterToMicronewtonMeter = 9.80665;
    const double gramForceMillimeterToMillinewtonMeter = 0.00980665;
    const double gramForceMillimeterToNewtonMeter = 0.00000980665;
    const double gramForceMillimeterToKilonewtonMeter = 9.80665e-9;
    const double gramForceMillimeterToMeganewtonMeter = 9.80665e-12;
    const double gramForceMillimeterToNewtonCentimeter =
        0.1; // since 10 mm = 1 cm
    const double gramForceMillimeterToNewtonMillimeter = 1; // by definition
    const double gramForceMillimeterToGramForceMeter =
        0.001; // since 1000 mm = 1 m
    const double gramForceMillimeterToGramForceCentimeter =
        0.1; // since 10 mm = 1 cm
    const double gramForceMillimeterToGramForceMillimeter = 1; // by definition
    const double gramForceMillimeterToKilogramForceMeter =
        1e-6; // since 1 kgf·m = 1000 gf·mm
    const double gramForceMillimeterToKilogramForceCentimeter =
        0.0001; // since 1 kgf·cm = 100 gf·mm
    const double gramForceMillimeterToKilogramForceMillimeter =
        0.001; // since 1 kgf·mm = 1000 gf·mm
    const double gramForceMillimeterToDyneMeter =
        980.665; // since 1 dyne·m = 1000 gf·mm
    const double gramForceMillimeterToDyneCentimeter =
        98066.5; // since 1 dyne·cm = 1 gf·mm
    const double gramForceMillimeterToDyneMillimeter =
        980665; // since 1 dyne·mm = 10 gf·mm
    const double gramForceMillimeterToPoundForceFoot =
        0.0000723301374515; // using the conversion 1 gf·mm to lbf·ft
    const double gramForceMillimeterToPoundForceInch =
        0.000867961649818; // using the conversion 1 gf·mm to lbf·in
    const double gramForceMillimeterToOunceForceFoot =
        0.00115728161874; // using the conversion 1 gf·mm to ozf·ft
    const double gramForceMillimeterToOunceForceInch =
        0.01388737942489; // using the conversion 1 gf·mm to ozf·in

    const double kilogramForceMeterToMicronewtonMeter = 9.80665e6;
    const double kilogramForceMeterToMillinewtonMeter = 9.80665e3;
    const double kilogramForceMeterToNewtonMeter = 9.80665;
    const double kilogramForceMeterToKilonewtonMeter = 0.00980665;
    const double kilogramForceMeterToMeganewtonMeter = 9.80665e-6;
    const double kilogramForceMeterToNewtonCentimeter = 980.665;
    const double kilogramForceMeterToNewtonMillimeter = 9806.65;
    const double kilogramForceMeterToGramForceMeter = 1000; // by definition
    const double kilogramForceMeterToGramForceCentimeter =
        100000; // since 1 m = 100 cm
    const double kilogramForceMeterToGramForceMillimeter =
        1e6; // since 1 m = 1000 mm
    const double kilogramForceMeterToKilogramForceMeter = 1; // by definition
    const double kilogramForceMeterToKilogramForceCentimeter =
        100; // since 1 m = 100 cm
    const double kilogramForceMeterToKilogramForceMillimeter =
        1000; // since 1 m = 1000 mm
    const double kilogramForceMeterToDyneMeter = 9.80665e7;
    const double kilogramForceMeterToDyneCentimeter = 9.80665e9;
    const double kilogramForceMeterToDyneMillimeter = 9.80665e10;
    const double kilogramForceMeterToPoundForceFoot =
        7.23301374515; // using the conversion 1 kgf·m to lbf·ft
    const double kilogramForceMeterToPoundForceInch =
        86.7961649818; // since there are 12 inches in a foot
    const double kilogramForceMeterToOunceForceFoot =
        115.728161874; // since there are 16 ounces in one pound
    const double kilogramForceMeterToOunceForceInch =
        1388.737942489; // since there are 12 inches in a foot and 16 ounces in one pound

    const double kilogramForceCentimeterToMicronewtonMeter = 98066.5;
    const double kilogramForceCentimeterToMillinewtonMeter = 98.0665;
    const double kilogramForceCentimeterToNewtonMeter = 0.0980665;
    const double kilogramForceCentimeterToKilonewtonMeter = 0.0000980665;
    const double kilogramForceCentimeterToMeganewtonMeter = 9.80665e-8;
    const double kilogramForceCentimeterToNewtonCentimeter =
        10; // since 1 kgf·cm = 10 N·cm
    const double kilogramForceCentimeterToNewtonMillimeter =
        100; // since 1 kgf·cm = 100 N·mm
    const double kilogramForceCentimeterToGramForceMeter =
        10; // since 1 kgf·cm = 10 gf·m
    const double kilogramForceCentimeterToGramForceCentimeter =
        1000; // by definition
    const double kilogramForceCentimeterToGramForceMillimeter =
        10000; // since 1 cm = 10 mm
    const double kilogramForceCentimeterToKilogramForceMeter =
        0.01; // since 1 m = 100 cm
    const double kilogramForceCentimeterToKilogramForceCentimeter =
        1; // by definition
    const double kilogramForceCentimeterToKilogramForceMillimeter =
        10; // since 1 cm = 10 mm
    const double kilogramForceCentimeterToDyneMeter =
        980665; // since 1 dyne·m = 1000 gf·cm
    const double kilogramForceCentimeterToDyneCentimeter =
        98066500; // since 1 dyne·cm = 1 kgf·cm
    const double kilogramForceCentimeterToDyneMillimeter =
        980665000; // since 1 dyne·mm = 10 kgf·cm
    const double kilogramForceCentimeterToPoundForceFoot =
        0.0723301374515; // using the conversion 1 kgf·m to lbf·ft and 1 kgf·cm to kgf·m
    const double kilogramForceCentimeterToPoundForceInch =
        0.867961649818; // since there are 12 inches in a foot
    const double kilogramForceCentimeterToOunceForceFoot =
        1.15728161874; // since there are 16 ounces in one pound
    const double kilogramForceCentimeterToOunceForceInch =
        13.88737942489; // since there are 12 inches in a foot and 16 ounces in one pound

    const double kilogramForceMillimeterToMicronewtonMeter = 9806.65;
    const double kilogramForceMillimeterToMillinewtonMeter = 9.80665;
    const double kilogramForceMillimeterToNewtonMeter = 0.00980665;
    const double kilogramForceMillimeterToKilonewtonMeter = 0.00000980665;
    const double kilogramForceMillimeterToMeganewtonMeter = 9.80665e-9;
    const double kilogramForceMillimeterToNewtonCentimeter =
        1; // since 10 mm = 1 cm
    const double kilogramForceMillimeterToNewtonMillimeter =
        10; // by definition
    const double kilogramForceMillimeterToGramForceMeter =
        1; // since 1000 mm = 1 m
    const double kilogramForceMillimeterToGramForceCentimeter =
        100; // since 10 mm = 1 cm
    const double kilogramForceMillimeterToGramForceMillimeter =
        1000; // by definition
    const double kilogramForceMillimeterToKilogramForceMeter =
        0.001; // since 1000 mm = 1 m
    const double kilogramForceMillimeterToKilogramForceCentimeter =
        0.1; // since 10 mm = 1 cm
    const double kilogramForceMillimeterToKilogramForceMillimeter =
        1; // by definition
    const double kilogramForceMillimeterToDyneMeter =
        98066.5; // since 1 dyne·m = 1000 gf·mm
    const double kilogramForceMillimeterToDyneCentimeter =
        9806650; // since 1 dyne·cm = 10 gf·mm
    const double kilogramForceMillimeterToDyneMillimeter =
        98066500; // since 1 dyne·mm = 1 kgf·mm
    const double kilogramForceMillimeterToPoundForceFoot =
        0.00723301374515; // using the conversion 1 kgf·m to lbf·ft and 1 kgf·mm to kgf·m
    const double kilogramForceMillimeterToPoundForceInch =
        0.0867961649818; // since there are 12 inches in a foot
    const double kilogramForceMillimeterToOunceForceFoot =
        0.115728161874; // since there are 16 ounces in one pound
    const double kilogramForceMillimeterToOunceForceInch =
        1.388737942489; // since there are 12 inches in a foot and 16 ounces in one pound

    const double dyneMeterToMicronewtonMeter = 10;
    const double dyneMeterToMillinewtonMeter = 0.01;
    const double dyneMeterToNewtonMeter = 1e-5;
    const double dyneMeterToKilonewtonMeter = 1e-8;
    const double dyneMeterToMeganewtonMeter = 1e-11;
    const double dyneMeterToNewtonCentimeter =
        0.0001; // since 1 dyn·m = 1e5 dyn·cm and 1 dyn·cm = 1e-5 N·m
    const double dyneMeterToNewtonMillimeter =
        0.001; // since 1 dyn·m = 1e5 dyn·mm and 1 dyn·mm = 1e-3 N·m
    const double dyneMeterToGramForceMeter =
        0.001019716212977928; // since 1 gf = 980.665 dyn and 1 m = 100 cm
    const double dyneMeterToGramForceCentimeter =
        1.019716212977928; // since 1 gf = 980.665 dyn
    const double dyneMeterToGramForceMillimeter =
        10.19716212977928; // since 1 gf·mm = 10 dyn
    const double dyneMeterToKilogramForceMeter =
        1.019716212977928e-6; // since 1 kgf = 9.80665e5 dyn and 1 m = 100 cm
    const double dyneMeterToKilogramForceCentimeter =
        0.0001019716212977928; // since 1 kgf = 9.80665e5 dyn
    const double dyneMeterToKilogramForceMillimeter =
        0.001019716212977928; // since 1 kgf·mm = 10 kgf·cm
    const double dyneMeterToDyneMeter = 1; // by definition
    const double dyneMeterToDyneCentimeter = 100000; // by definition
    const double dyneMeterToDyneMillimeter =
        1000000; // since 1 dyn·mm = 1e-3 dyn·m
    const double dyneMeterToPoundForceFoot =
        7.23301374515e-8; // from dyn·m to lbf·ft
    const double dyneMeterToPoundForceInch =
        8.67961649818e-7; // from dyn·m to lbf·in
    const double dyneMeterToOunceForceFoot =
        1.15728161874e-6; // from dyn·m to ozf·ft
    const double dyneMeterToOunceForceInch =
        1.388737942489e-5; // from dyn·m to ozf·in

    const double dyneCentimeterToMicronewtonMeter = 1000;
    const double dyneCentimeterToMillinewtonMeter = 1;
    const double dyneCentimeterToNewtonMeter = 0.0001;
    const double dyneCentimeterToKilonewtonMeter = 1e-7;
    const double dyneCentimeterToMeganewtonMeter = 1e-10;
    const double dyneCentimeterToNewtonCentimeter =
        0.01; // since 1 dyn·cm = 0.01 N·cm
    const double dyneCentimeterToNewtonMillimeter =
        0.1; // since 10 dyn·cm = 1 N·mm
    const double dyneCentimeterToGramForceMeter =
        0.001019716212977928; // since 1 gf·cm = 980.665 dyn·cm
    const double dyneCentimeterToGramForceCentimeter =
        1.019716212977928; // since 1 gf = 980.665 dyn
    const double dyneCentimeterToGramForceMillimeter =
        10.19716212977928; // since 10 gf·cm = 1 gf·mm
    const double dyneCentimeterToKilogramForceMeter =
        1.019716212977928e-5; // since 1000 gf·cm = 1 kgf·m
    const double dyneCentimeterToKilogramForceCentimeter =
        0.0001019716212977928; // since 1 kgf = 98066.5 dyn·cm
    const double dyneCentimeterToKilogramForceMillimeter =
        0.001019716212977928; // since 10 kgf·cm = 1 kgf·mm
    const double dyneCentimeterToDyneMeter = 0.1; // since 1 dyn·m = 100 dyn·cm
    const double dyneCentimeterToDyneCentimeter = 1; // by definition
    const double dyneCentimeterToDyneMillimeter =
        10; // since 1 dyn·mm = 0.1 dyn·cm
    const double dyneCentimeterToPoundForceFoot =
        7.23301374515e-6; // from dyn·cm to lbf·ft
    const double dyneCentimeterToPoundForceInch =
        8.67961649818e-5; // from dyn·cm to lbf·in
    const double dyneCentimeterToOunceForceFoot =
        1.15728161874e-4; // from dyn·cm to ozf·ft
    const double dyneCentimeterToOunceForceInch =
        0.001388737942489; // from dyn·cm to ozf·in

    const double dyneMillimeterToMicronewtonMeter = 100;
    const double dyneMillimeterToMillinewtonMeter = 0.1;
    const double dyneMillimeterToNewtonMeter = 0.00001;
    const double dyneMillimeterToKilonewtonMeter = 1e-8;
    const double dyneMillimeterToMeganewtonMeter = 1e-11;
    const double dyneMillimeterToNewtonCentimeter =
        0.001; // since 1 dyn·mm = 0.001 N·cm
    const double dyneMillimeterToNewtonMillimeter =
        0.01; // since 1 dyn·mm = 0.01 N·mm
    const double dyneMillimeterToGramForceMeter =
        0.0001019716212977928; // since 1 gf·mm = 980.665 dyn·mm
    const double dyneMillimeterToGramForceCentimeter =
        0.1019716212977928; // since 1 gf = 980.665 dyn
    const double dyneMillimeterToGramForceMillimeter =
        1.019716212977928; // by definition
    const double dyneMillimeterToKilogramForceMeter =
        1.019716212977928e-6; // since 1000 gf·mm = 1 kgf·m
    const double dyneMillimeterToKilogramForceCentimeter =
        0.000010197162129779283; // since 100 gf·mm = 1 kgf·cm
    const double dyneMillimeterToKilogramForceMillimeter =
        0.00010197162129779283; // since 10 kgf·cm = 1 kgf·mm
    const double dyneMillimeterToDyneMeter =
        0.01; // since 1 dyn·m = 1000 dyn·mm
    const double dyneMillimeterToDyneCentimeter =
        0.1; // since 1 dyn·cm = 10 dyn·mm
    const double dyneMillimeterToDyneMillimeter = 1; // by definition
    const double dyneMillimeterToPoundForceFoot =
        7.23301374515e-7; // from dyn·mm to lbf·ft
    const double dyneMillimeterToPoundForceInch =
        8.67961649818e-6; // from dyn·mm to lbf·in
    const double dyneMillimeterToOunceForceFoot =
        1.15728161874e-5; // from dyn·mm to ozf·ft
    const double dyneMillimeterToOunceForceInch =
        0.0001388773942489; // from dyn·mm to ozf·in

    const double poundForceFootToMicronewtonMeter = 1.3558179483314004e6;
    const double poundForceFootToMillinewtonMeter = 1355.8179483314004;
    const double poundForceFootToNewtonMeter = 1.3558179483314004;
    const double poundForceFootToKilonewtonMeter = 0.0013558179483314004;
    const double poundForceFootToMeganewtonMeter = 1.3558179483314004e-6;
    const double poundForceFootToNewtonCentimeter = 135.58179483314004;
    const double poundForceFootToNewtonMillimeter = 1355.8179483314004;
    const double poundForceFootToGramForceMeter =
        138.25502798621186; // since 1 lbf·ft = 138.25502798621186 gf·m
    const double poundForceFootToGramForceCentimeter =
        13825.502798621186; // since 1 gf·cm = 0.001 lbf·ft
    const double poundForceFootToGramForceMillimeter =
        138255.02798621186; // since 1 gf·mm = 0.01 lbf·ft
    const double poundForceFootToKilogramForceMeter =
        0.13825502798621186; // since 1 kgf·m = 7.23301374515 lbf·ft
    const double poundForceFootToKilogramForceCentimeter =
        13.825502798621186; // since 1 kgf·cm = 0.0723301374515 lbf·ft
    const double poundForceFootToKilogramForceMillimeter =
        138.25502798621186; // since 1 kgf·mm = 0.723301374515 lbf·ft
    const double poundForceFootToDyneMeter =
        13825502.798621186; // since 1 dyn·m = 0.0000723301374515 lbf·ft
    const double poundForceFootToDyneCentimeter =
        1382550279.8621186; // since 1 dyn·cm = 0.000000723301374515 lbf·ft
    const double poundForceFootToDyneMillimeter =
        13825502798.621186; // since 1 dyn·mm = 0.00000723301374515 lbf·ft
    const double poundForceFootToPoundForceFoot = 1; // by definition
    const double poundForceFootToPoundForceInch = 12; // since 1 ft = 12 in
    const double poundForceFootToOunceForceFoot = 16; // since 1 lb = 16 oz
    const double poundForceFootToOunceForceInch =
        192; // since 1 ft = 12 in and 1 lb = 16 oz

    const double poundForceInchToMicronewtonMeter = 112984.8290276167;
    const double poundForceInchToMillinewtonMeter = 112.9848290276167;
    const double poundForceInchToNewtonMeter = 0.1129848290276167;
    const double poundForceInchToKilonewtonMeter = 0.0001129848290276167;
    const double poundForceInchToMeganewtonMeter = 1.129848290276167e-7;
    const double poundForceInchToNewtonCentimeter = 11.29848290276167;
    const double poundForceInchToNewtonMillimeter = 112.9848290276167;
    const double poundForceInchToGramForceMeter =
        11.52124692682998; // since 1 lbf·in = 11.52124692682998 gf·m
    const double poundForceInchToGramForceCentimeter =
        1152.124692682998; // since 1 gf·cm = 0.000868055555556 lbf·in
    const double poundForceInchToGramForceMillimeter =
        11521.24692682998; // since 1 gf·mm = 0.00868055555556 lbf·in
    const double poundForceInchToKilogramForceMeter =
        0.01152124692682998; // since 1 kgf·m = 86.7961649818 lbf·in
    const double poundForceInchToKilogramForceCentimeter =
        1.152124692682998; // since 1 kgf·cm = 0.867961649818 lbf·in
    const double poundForceInchToKilogramForceMillimeter =
        11.52124692682998; // since 1 kgf·mm = 8.67961649818 lbf·in
    const double poundForceInchToDyneMeter =
        1152124.692682998; // since 1 dyn·m = 0.0000723301374515 lbf·ft and 1 ft = 12 in
    const double poundForceInchToDyneCentimeter =
        115212469.2682998; // since 1 dyn·cm = 0.000000868055555556 lbf·in
    const double poundForceInchToDyneMillimeter =
        1152124692.682998; // since 1 dyn·mm = 0.00000868055555556 lbf·in
    const double poundForceInchToPoundForceFoot =
        0.08333333333333333; // since 1 ft = 12 in
    const double poundForceInchToPoundForceInch = 1; // by definition
    const double poundForceInchToOunceForceFoot =
        1.333333333333333; // since 1 lbf = 16 ozf
    const double poundForceInchToOunceForceInch = 16; // since 1 lbf = 16 ozf

    const double ounceForceFootToMicronewtonMeter = 8478.614583333333 * 1000;
    const double ounceForceFootToMillinewtonMeter = 8478.614583333333;
    const double ounceForceFootToNewtonMeter = 8.478614583333333;
    const double ounceForceFootToKilonewtonMeter = 0.008478614583333333;
    const double ounceForceFootToMeganewtonMeter = 8.478614583333333e-6;
    const double ounceForceFootToNewtonCentimeter = 847.8614583333333;
    const double ounceForceFootToNewtonMillimeter = 8478.614583333333;
    const double ounceForceFootToGramForceMeter =
        864.8310538375718; // since 1 ozf·ft = 864.8310538375718 gf·m
    const double ounceForceFootToGramForceCentimeter =
        86483.10538375718; // since 1 gf·cm = 0.000115740740741 ozf·ft
    const double ounceForceFootToGramForceMillimeter =
        864831.0538375718; // since 1 gf·mm = 0.00115740740741 ozf·ft
    const double ounceForceFootToKilogramForceMeter =
        0.8648310538375718; // since 1 kgf·m = 115.728161874 ozf·ft
    const double ounceForceFootToKilogramForceCentimeter =
        86.48310538375718; // since 1 kgf·cm = 1.15728161874 ozf·ft
    const double ounceForceFootToKilogramForceMillimeter =
        864.8310538375718; // since 1 kgf·mm = 11.5728161874 ozf·ft
    const double ounceForceFootToDyneMeter =
        86483105.38375718; // since 1 dyn·m = 0.0000115728161874 ozf·ft
    const double ounceForceFootToDyneCentimeter =
        8648310538.375718; // since 1 dyn·cm = 0.000000115740740741 ozf·ft
    const double ounceForceFootToDyneMillimeter =
        86483105383.75718; // since 1 dyn·mm = 0.00000115740740741 ozf·ft
    const double ounceForceFootToPoundForceFoot =
        0.0625; // since 1 lbf·ft = 16 ozf·ft
    const double ounceForceFootToPoundForceInch =
        0.75; // since 1 lbf·in = 16 ozf·in and 1 ft = 12 in
    const double ounceForceFootToOunceForceFoot = 1; // by definition
    const double ounceForceFootToOunceForceInch = 12; // since 1 ft = 12 in

    const double ounceForceInchToMicronewtonMeter = 706.5517858565288;
    const double ounceForceInchToMillinewtonMeter = 0.7065517858565288;
    const double ounceForceInchToNewtonMeter = 0.0007065517858565288;
    const double ounceForceInchToKilonewtonMeter = 7.065517858565288e-7;
    const double ounceForceInchToMeganewtonMeter = 7.065517858565288e-10;
    const double ounceForceInchToNewtonCentimeter = 0.07065517858565288;
    const double ounceForceInchToNewtonMillimeter = 0.7065517858565288;
    const double ounceForceInchToGramForceMeter =
        0.07206782221496957; // using the conversion 1 ozf·in to gf·m
    const double ounceForceInchToGramForceCentimeter =
        7.206782221496957; // since 1 gf·cm = 0.001 lbf·in
    const double ounceForceInchToGramForceMillimeter =
        72.06782221496957; // since 1 gf·mm = 0.01 lbf·in
    const double ounceForceInchToKilogramForceMeter =
        0.00007206782221496957; // using the conversion 1 ozf·in to kgf·m
    const double ounceForceInchToKilogramForceCentimeter =
        0.007206782221496957; // using the conversion 1 ozf·in to kgf·cm
    const double ounceForceInchToKilogramForceMillimeter =
        0.07206782221496957; // using the conversion 1 ozf·in to kgf·mm
    const double ounceForceInchToDyneMeter =
        7206.782221496957; // since 1 dyn·m = 0.0000723301374515 lbf·ft and 1 lbf·ft = 192 ozf·in
    const double ounceForceInchToDyneCentimeter =
        720678.2221496957; // since 1 dyn·cm = 0.000000723301374515 lbf·ft
    const double ounceForceInchToDyneMillimeter =
        7206782.221496957; // since 1 dyn·mm = 0.00000723301374515 lbf·ft
    const double ounceForceInchToPoundForceFoot =
        0.005208333333333333; // since 1 lbf·ft = 192 ozf·in
    const double ounceForceInchToPoundForceInch =
        0.0625; // since 1 lbf·in = 16 ozf·in
    const double ounceForceInchToOunceForceFoot =
        0.08333333333333333; // since 1 ft = 12 in
    const double ounceForceInchToOunceForceInch = 1; // by definition

    // endregion
    switch (fromUnit) {}

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
      case 'Meters':
        switch (toUnit) {
          case 'Picometers':
            formula = 'Multiply the length value by 1,000,000,000,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1,000,000,000';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 1,000,000';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 1,000';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 100';
            break;
          case 'Meters':
            formula = 'The value remains unchanged';
            break;
          case 'Kilometers':
            formula = 'Divide the length value by 1,000';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 10,000,000,000';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 39,370.0787';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 39.3701';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 3.28084';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 1.09361';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 0.0497097';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 0.00497097';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 0.000621371';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 0.546807';
            break;
          case 'Cables':
            formula = 'Multiply the length value by 0.00539957';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 0.000539957';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 149,597,870,700';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+15';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+16';
            break;
          default:
            formula = 'Unknown conversion';
        }
        break;
      // PICOMETERS UNIT CONVERSION
      case 'Picometers':
        switch (toUnit) {
          case 'Picometers':
            formula = 'The value remains unchanged';
            break;
          case 'Nanometers':
            formula = 'Divide the length value by 1,000';
            break;
          case 'Micrometers':
            formula = 'Divide the length value by 1,000,000';
            break;
          case 'Millimeters':
            formula = 'Divide the length value by 1,000,000,000';
            break;
          case 'Centimeters':
            formula = 'Divide the length value by 10,000,000,000';
            break;
          case 'Meters':
            formula = 'Divide the length value by 1,000,000,000,000';
            break;
          case 'Kilometers':
            formula = 'Divide the length value by 1,000,000,000,000,000';
            break;
          case 'Angstrom':
            formula = 'Divide the length value by 100';
            break;
          case 'Thou':
            formula = 'Divide the length value by 25,400,000,000';
            break;
          case 'Inches':
            formula = 'Divide the length value by 25,400,000,000,000';
            break;
          case 'Feet':
            formula = 'Divide the length value by 304,800,000,000,000';
            break;
          case 'Yards':
            formula = 'Divide the length value by 914,400,000,000,000';
            break;
          case 'Chains':
            formula = 'Divide the length value by 20,116,800,000,000,000';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 201,168,000,000,000,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 1,609,344,000,000,000,000';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 1,828,800,000,000,000';
            break;
          case 'Cables':
            formula = 'Divide the length value by 185,200,000,000,000';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 1,852,000,000,000,000,000';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.496e+23';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+28';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+28';
            break;
// Add cases for any additional units here
          default:
            formula = 'Unknown conversion';
            break;
        }
        break; // This breaks out of the 'Picometers' case

      // NANOMETERS UNIT CONVERSION
      case 'Nanometers':
        switch (toUnit) {
          case 'Nanometers':
            formula = 'The value remains unchanged';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1,000';
            break;
          case 'Micrometers':
            formula = 'Divide the length value by 1,000';
            break;
          case 'Millimeters':
            formula = 'Divide the length value by 1,000,000';
            break;
          case 'Centimeters':
            formula = 'Divide the length value by 10,000,000';
            break;
          case 'Meters':
            formula = 'Divide the length value by 1,000,000,000';
            break;
          case 'Kilometers':
            formula = 'Divide the length value by 1,000,000,000,000';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 10';
            break;
          case 'Thou (mils)':
            formula = 'Divide the length value by 25,400,000';
            break;
          case 'Inches':
            formula = 'Divide the length value by 25,400,000,000';
            break;
          case 'Feet':
            formula = 'Divide the length value by 304,800,000,000';
            break;
          case 'Yards':
            formula = 'Divide the length value by 914,400,000,000';
            break;
          case 'Chains':
            formula = 'Divide the length value by 20,116,800,000,000';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 201,168,000,000,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 1,609,344,000,000,000';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 1,828,800,000,000';
            break;
          case 'Cables':
            formula = 'Divide the length value by 185,200,000,000,000';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 1,852,000,000,000,000';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.496e+23';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+28';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+28';
            break;

          // ... and so on for the rest of the units ...

          default:
            formula = 'Unknown conversion';
            break;
        }

      case 'Centimeters':
        switch (toUnit) {
          case 'Centimeters':
            formula = 'The value remains unchanged';
            break;
          case 'Meters':
            formula = 'Divide the length value by 100';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 10,000,000,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 10,000,000';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 10,000';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 10';
            break;
          case 'Kilometers':
            formula = 'Divide the length value by 100,000';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 100,000,000';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 393.700787';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 0.393700787';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 0.032808399';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 0.010936133';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 0.0049709695';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 0.00049709695';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 0.000006213712';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 0.054680665';
            break;
          case 'Cables':
            formula = 'Multiply the length value by 0.0053961182';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 0.000005399568';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 14959787070000';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+17';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+18';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
      case 'Millimeters':
        switch (toUnit) {
          case 'Millimeters':
            formula = 'The value remains unchanged';
            break;
          case 'Centimeters':
            formula = 'Divide the length value by 10';
            break;
          case 'Meters':
            formula = 'Divide the length value by 1,000';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1,000,000,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1,000,000';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 1,000';
            break;
          case 'Kilometers':
            formula = 'Divide the length value by 1,000,000';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 10,000,000';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 39.3700787';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 0.0393700787';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 0.0032808399';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 0.0010936133';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 0.0000497097';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 0.00000497097';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 0.000000621371192';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 0.000546806649';
            break;
          case 'Cables':
            formula = 'Multiply the length value by 0.0000539956803';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 0.000000539956803';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.495978707e+14';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+18';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+19';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Micrometers':
        switch (toUnit) {
          case 'Micrometers':
            formula = 'The value remains unchanged';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1,000';
            break;
          case 'Millimeters':
            formula = 'Divide the length value by 1,000';
            break;
          case 'Centimeters':
            formula = 'Divide the length value by 10,000';
            break;
          case 'Meters':
            formula = 'Divide the length value by 1,000,000';
            break;
          case 'Kilometers':
            formula = 'Divide the length value by 1,000,000,000';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 10,000';
            break;
          case 'Thou':
            formula = 'Divide the length value by 25.4';
            break;
          case 'Inches':
            formula = 'Divide the length value by 25,400';
            break;
          case 'Feet':
            formula = 'Divide the length value by 304,800';
            break;
          case 'Yards':
            formula = 'Divide the length value by 914,400';
            break;
          case 'Chains':
            formula = 'Divide the length value by 20,116,800';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 201,168,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 1,609,344,000';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 1,828,800';
            break;
          case 'Cables':
            formula = 'Divide the length value by 185,200';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 1,852,000,000';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.496e+17';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+21';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+22';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Kilometers':
        switch (toUnit) {
          case 'Kilometers':
            formula = 'The value remains unchanged';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 1,000';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 100,000';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 1,000,000';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 1,000,000,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1,000,000,000,000';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1,000,000,000,000,000';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 1e+13';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 39,370,078.7';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 39,370.0787';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 3,280.8399';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 1,093.6133';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 49.7096954';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 4.97096954';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 0.621371192';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 546.806649';
            break;
          case 'Cables':
            formula = 'Multiply the length value by 5.39956803';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 0.539956803';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 149.5978707';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+12';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+13';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Angstrom':
        switch (toUnit) {
          case 'Angstrom':
            formula = 'The value remains unchanged';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 100';
            break;
          case 'Nanometers':
            formula = 'Divide the length value by 10';
            break;
          case 'Micrometers':
            formula = 'Divide the length value by 10,000';
            break;
          case 'Millimeters':
            formula = 'Divide the length value by 10,000,000';
            break;
          case 'Centimeters':
            formula = 'Divide the length value by 100,000,000';
            break;
          case 'Meters':
            formula = 'Divide the length value by 1,000,000,000';
            break;
          case 'Kilometers':
            formula = 'Divide the length value by 1,000,000,000,000';
            break;
          case 'Thou':
            formula = 'Divide the length value by 254,000';
            break;
          case 'Inches':
            formula = 'Divide the length value by 25,400,000';
            break;
          case 'Feet':
            formula = 'Divide the length value by 304,800,000';
            break;
          case 'Yards':
            formula = 'Divide the length value by 914,400,000';
            break;
          case 'Chains':
            formula = 'Divide the length value by 20,116,800,000';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 201,168,000,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 1,609,344,000,000';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 1,828,800,000';
            break;
          case 'Cables':
            formula = 'Divide the length value by 185,200,000';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 1,852,000,000,000';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.496e+20';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+25';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+26';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Thou':
        switch (toUnit) {
          case 'Thou':
            formula = 'The value remains unchanged';
            break;
          case 'Inches':
            formula = 'Divide the length value by 1,000';
            break;
          case 'Feet':
            formula = 'Divide the length value by 12,000';
            break;
          case 'Yards':
            formula = 'Divide the length value by 36,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 63,360,000';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 0.0254';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 0.00254';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 0.0000254';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 2.54e-8';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 2.54e+7';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 2.54e+4';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 25.4';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 2.54e+5';
            break;
          case 'Chains':
            formula = 'Divide the length value by 792,000';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 7,920,000';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 72,000';
            break;
          case 'Cables':
            formula = 'Divide the length value by 729,000';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 7,290,000';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 2.54e+12';
            break;
          case 'Light years':
            formula = 'Divide the length value by 2.399e+20';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 7.823e+20';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Inches':
        switch (toUnit) {
          case 'Inches':
            formula = 'The value remains unchanged';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 1,000';
            break;
          case 'Feet':
            formula = 'Divide the length value by 12';
            break;
          case 'Yards':
            formula = 'Divide the length value by 36';
            break;
          case 'Miles':
            formula = 'Divide the length value by 63,360';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 25.4';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 2.54';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 0.0254';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 0.0000254';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 25.4e+9';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 25.4e+6';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 25,400';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 254,000,000';
            break;
          case 'Chains':
            formula = 'Divide the length value by 792';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 7,920';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 72';
            break;
          case 'Cables':
            formula = 'Divide the length value by 729.13';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 72,913.4';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 9.461e+12';
            break;
          case 'Light years':
            formula = 'Divide the length value by 5.879e+17';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 1.917e+18';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Feet':
        switch (toUnit) {
          case 'Feet':
            formula = 'The value remains unchanged';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 12';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 12,000';
            break;
          case 'Yards':
            formula = 'Divide the length value by 3';
            break;
          case 'Miles':
            formula = 'Divide the length value by 5,280';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 304.8';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 30.48';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 0.3048';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 0.0003048';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 304.8e+9';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 304.8e+6';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 304,800';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 3.048e+9';
            break;
          case 'Chains':
            formula = 'Divide the length value by 66';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 660';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 6';
            break;
          case 'Cables':
            formula = 'Divide the length value by 607.611';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 6,076.115';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 9.461e+11';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+16';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+17';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Yards':
        switch (toUnit) {
          case 'Yards':
            formula = 'The value remains unchanged';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 3';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 36';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 36,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 1,760';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 914.4';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 91.44';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 0.9144';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 0.0009144';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 914.4e+9';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 914.4e+6';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 914,400';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 9.144e+9';
            break;
          case 'Chains':
            formula = 'Divide the length value by 22';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 220';
            break;
          case 'Fathoms':
            formula = 'Divide the length value by 2';
            break;
          case 'Cables':
            formula = 'Divide the length value by 202.533';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 2,025.371';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 9.665e+11';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.665e+16';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.118e+17';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Chains':
        switch (toUnit) {
          case 'Chains':
            formula = 'The value remains unchanged';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 22';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 66';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 792';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 792,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 80';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 20,116.8';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 2,011.68';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 20.1168';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 0.0201168';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 20.1168e+12';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 20.1168e+9';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 20,116,800';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 201,168,000,000';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 10';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 11';
            break;
          case 'Cables':
            formula = 'Divide the length value by 9.225';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 92.25';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.341e+13';
            break;
          case 'Light years':
            formula = 'Divide the length value by 1.341e+18';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 4.134e+18';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Furlongs':
        switch (toUnit) {
          case 'Furlongs':
            formula = 'The value remains unchanged';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 10';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 220';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 660';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 7,920';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 7,920,000';
            break;
          case 'Miles':
            formula = 'Divide the length value by 8';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 201,168';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 20,116.8';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 201.168';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 0.201168';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 201.168e+12';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 201.168e+9';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 201,168,000';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 2.01168e+12';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 110';
            break;
          case 'Cables':
            formula = 'Divide the length value by 1.012';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 10.12';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.342e+12';
            break;
          case 'Light years':
            formula = 'Divide the length value by 1.342e+17';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 4.135e+17';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Miles':
        switch (toUnit) {
          case 'Miles':
            formula = 'The value remains unchanged';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 8';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 80';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 1,760';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 5,280';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 63,360';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 63,360,000';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 1.609344';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 1,609.344';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 160,934.4';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 1,609,344';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 1,609,344,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1.609344e+12';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1.609344e+15';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 1.609344e+17';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 880';
            break;
          case 'Cables':
            formula = 'Multiply the length value by 88.781';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 0.868976';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 9.296e+7';
            break;
          case 'Light years':
            formula = 'Divide the length value by 5.879e+12';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 1.917e+13';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Fathoms':
        switch (toUnit) {
          case 'Fathoms':
            formula = 'The value remains unchanged';
            break;
          case 'Miles':
            formula = 'Divide the length value by 880';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 110';
            break;
          case 'Chains':
            formula = 'Divide the length value by 11';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 2';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 6';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 72';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 72,000';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 0.0018288';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 1.8288';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 182.88';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 1,828.8';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 1,828,800';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1.8288e+9';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1.8288e+12';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 1.8288e+13';
            break;
          case 'Cables':
            formula = 'Divide the length value by 101.2';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 1,012';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.22e+11';
            break;
          case 'Light years':
            formula = 'Divide the length value by 1.22e+16';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.77e+16';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Cables':
        switch (toUnit) {
          case 'Cables':
            formula = 'The value remains unchanged';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 101.2';
            break;
          case 'Miles':
            formula = 'Divide the length value by 10.012';
            break;
          case 'Furlongs':
            formula = 'Divide the length value by 1.2515';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 8';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 202.53';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 607.61';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 7,291.34';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 7,291,339';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 0.1852';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 185.2';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 18,520';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 185,200';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 185,200,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 185.2e+9';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 185.2e+12';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 1.852e+13';
            break;
          case 'Nautical miles':
            formula = 'Divide the length value by 10';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.238e+12';
            break;
          case 'Light years':
            formula = 'Divide the length value by 1.238e+17';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.819e+17';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Nautical miles':
        switch (toUnit) {
          case 'Nautical miles':
            formula = 'The value remains unchanged';
            break;
          case 'Cables':
            formula = 'Multiply the length value by 10';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 1.15078';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 9.20624';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 92.0624';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 2,025.37';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 6,076.12';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 72,913.4';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 72,913,386';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 1,012.68591';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 1.852';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 1,852';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 185,200';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 1,852,000';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 1,852,000,000';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1.852e+12';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1.852e+15';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 1.852e+16';
            break;
          case 'Astronomical units':
            formula = 'Divide the length value by 1.496e+8';
            break;
          case 'Light years':
            formula = 'Divide the length value by 9.461e+12';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.086e+13';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Astronomical units':
        switch (toUnit) {
          case 'Astronomical units':
            formula = 'The value remains unchanged';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 1.496e+8';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 9.296e+7';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 7.456e+6';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 7.456e+5';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 1.09361e+8';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 3.28084e+8';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 3.93701e+9';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 3.93701e+12';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 5.46807e+7';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 1.496e+5';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 1.496e+8';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 1.496e+10';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 1.496e+11';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 1.496e+14';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 1.496e+17';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 1.496e+20';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 1.496e+21';
            break;
          case 'Light years':
            formula = 'Divide the length value by 63.241';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 206,265';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Light years':
        switch (toUnit) {
          case 'Light years':
            formula = 'The value remains unchanged';
            break;
          case 'Astronomical units':
            formula = 'Multiply the length value by 63,241';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 3.724e+12';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 5.879e+12';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 4.703e+13';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 4.703e+14';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 1.057e+13';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 3.172e+13';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 3.807e+14';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 3.807e+17';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 5.286e+12';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 9.461e+12';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 9.461e+15';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 9.461e+17';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 9.461e+18';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 9.461e+21';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 9.461e+24';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 9.461e+27';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 9.461e+28';
            break;
          case 'Parsecs':
            formula = 'Divide the length value by 3.262';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;
      case 'Parsecs':
        switch (toUnit) {
          case 'Parsecs':
            formula = 'The value remains unchanged';
            break;
          case 'Light years':
            formula = 'Multiply the length value by 3.262';
            break;
          case 'Astronomical units':
            formula = 'Multiply the length value by 206,265';
            break;
          case 'Nautical miles':
            formula = 'Multiply the length value by 1.917e+13';
            break;
          case 'Miles':
            formula = 'Multiply the length value by 1.917e+13';
            break;
          case 'Furlongs':
            formula = 'Multiply the length value by 1.534e+14';
            break;
          case 'Chains':
            formula = 'Multiply the length value by 1.534e+15';
            break;
          case 'Yards':
            formula = 'Multiply the length value by 3.447e+14';
            break;
          case 'Feet':
            formula = 'Multiply the length value by 1.034e+15';
            break;
          case 'Inches':
            formula = 'Multiply the length value by 1.240e+16';
            break;
          case 'Thou':
            formula = 'Multiply the length value by 1.240e+19';
            break;
          case 'Fathoms':
            formula = 'Multiply the length value by 1.724e+14';
            break;
          case 'Kilometers':
            formula = 'Multiply the length value by 3.086e+13';
            break;
          case 'Meters':
            formula = 'Multiply the length value by 3.086e+16';
            break;
          case 'Centimeters':
            formula = 'Multiply the length value by 3.086e+18';
            break;
          case 'Millimeters':
            formula = 'Multiply the length value by 3.086e+19';
            break;
          case 'Micrometers':
            formula = 'Multiply the length value by 3.086e+22';
            break;
          case 'Nanometers':
            formula = 'Multiply the length value by 3.086e+25';
            break;
          case 'Picometers':
            formula = 'Multiply the length value by 3.086e+28';
            break;
          case 'Angstrom':
            formula = 'Multiply the length value by 3.086e+29';
            break;
          case 'Cables':
            formula = 'Multiply the length value by 1.666e+14';
            break;

          default:
            formula = 'Unknown conversion';
            break;
        }
        break;

// ... after the last specific unit case ...
      default:
        formula = 'Select both units to see the formula';
        break;
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

    // Insert at the start of the list to act as a non-selectable hint
    // Insert a non-selectable 'Choose a conversion unit' hint at the start.
    items.insert(
        0,
        const DropdownMenuItem<String>(
          value: '',
          enabled: false, // An empty string represents no selection.
          child: Text(
            'Choose a conversion unit',
            style: TextStyle(color: Colors.grey, fontSize: 23),
          ), // This makes the item non-selectable.
        ));

    // Build the DropdownButtonFormField using the items list.
    // Build the DropdownButtonFormField using the items list.
    // Build the DropdownButtonFormField using the items list.
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
        textAlign: TextAlign.center, // This is correct for Text widget
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
            fromController.clear();
            toController.clear();
            // Trigger the conversion logic if needed.
          });
        }
      },
      dropdownColor: const Color(0xFF303134),
      items: items,
      isExpanded:
          true, // This will make sure the dropdown's content is centered
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      iconSize: 24,
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((DropdownMenuItem<String> item) {
          return Center(
            // Center the text for the selected item
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

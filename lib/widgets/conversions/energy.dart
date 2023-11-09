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

class EnergyUnitConverter extends StatefulWidget {
  const EnergyUnitConverter({super.key});

  @override
  _EnergyUnitConverterState createState() => _EnergyUnitConverterState();
}

class _EnergyUnitConverterState extends State<EnergyUnitConverter> {
  String fromUnit = 'Nanojoules';
  String toUnit = 'Microjoules';
  // Removed duplicate declarations of TextEditingController
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool _isExponentialFormat = false;
  // Flag to indicate if the change is due to user input
  bool _isUserInput = true;
  // Using string variables for prefixes
  String fromPrefix = 'nJ';
  String toPrefix = 'μJ';
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
          text: 'Check out my energy result!');
    }
  }

  void convert(String text) {
    String normalizedText = text.replaceAll(',', '.');
    if (normalizedText.isEmpty) return;
    var fromValue = double.tryParse(normalizedText);
    if (fromValue == null) return;
    double toValue = 0; // Your conversion logic here

//NANOJOULES
    const double NanojoulesToMicrojoules = 1e-6;
    const double NanojoulesToMillijoules = 0.001;
    const double NanojoulesToJoules = 1.0;
    const double NanojoulesToKilojoules = 1e3;
    const double NanojoulesToMegajoules = 1e6;
    const double NanojoulesToNewtonMetres =
        1.0; // Newton-metres are equivalent to Joules.
    const double NanojoulesToWattHours = 2.77778e-7;
    const double NanojoulesToKilowattHours = 2.77778e-10;
    const double NanojoulesToMegawattHours = 2.77778e-13;
    const double NanojoulesToCalories = 0.239006;
    const double NanojoulesToKilocalories = 0.000239006;
    const double NanojoulesToFootPoundsForce = 0.737562;
    const double NanojoulesToBritishThermalUnitsISO = 0.000947817;
    const double NanojoulesToTherms = 9.47817e-9;
    const double NanojoulesToHorsepowerHours = 3.72506e-7;
    const double NanojoulesToBarrelsOfOilEquivalent = 1.63456e-10;
    const double NanojoulesToTonnesOfOilEquivalent = 2.38846e-11;
    const double NanojoulesToTonnesOfTNT = 2.39006e-10;
    const double NanojoulesToKilotonnesOfTNT = 2.39006e-13;
    const double NanojoulesToMegatonnesOfTNT = 2.39006e-16;
    const double NanojoulesToErgs = 1e-7;
    const double NanojoulesToElectronvolt = 6.24150;
    const double NanojoulesToKiloelectronvolt = 0.00624150;
    const double NanojoulesToMegaelectronvolt = 6.24150e-6;
    const double NanojoulesToGigaelectronvolt = 6.24150e-9;

//MICROJOULES

    const double MicrojoulesToNanojoules = 1000.0;
    const double MicrojoulesToMicrojoules = 1e-6;
    const double MicrojoulesToMillijoules = 0.001;
    const double MicrojoulesToJoules = 1.0;
    const double MicrojoulesToKilojoules = 1000.0;
    const double MicrojoulesToMegajoules = 1e6;
    const double MicrojoulesToNewtonMetres =
        1.0; // Newton-metres are equivalent to Joules.
    const double MicrojoulesToWattHours = 0.0002777777777777778;
    const double MicrojoulesToKilowattHours = 2.77778e-7;
    const double MicrojoulesToMegawattHours = 2.77778e-10;
    const double MicrojoulesToCalories = 0.239006;
    const double MicrojoulesToKilocalories = 0.000239006;
    const double MicrojoulesToFootPoundsForce = 0.737562;
    const double MicrojoulesToBritishThermalUnitsISO = 0.000947817;
    const double MicrojoulesToTherms = 9.47817e-9;
    const double MicrojoulesToHorsepowerHours = 3.72506e-7;
    const double MicrojoulesToBarrelsOfOilEquivalent = 1.63456e-10;
    const double MicrojoulesToTonnesOfOilEquivalent = 2.38846e-11;
    const double MicrojoulesToTonnesOfTNT = 2.39006e-10;
    const double MicrojoulesToKilotonnesOfTNT = 2.39006e-13;
    const double MicrojoulesToMegatonnesOfTNT = 2.39006e-16;
    const double MicrojoulesToErgs = 1e-5;
    const double MicrojoulesToElectronvolt = 6.2415e6;
    const double MicrojoulesToKiloelectronvolt = 6241.5;
    const double MicrojoulesToMegaelectronvolt = 6.2415;
    const double MicrojoulesToGigaelectronvolt = 0.0062415;

//MILLIJOULES
    const double MillijoulesToNanojoules = 1000000.0;
    const double MillijoulesToMicrojoules = 1000.0;
    const double MillijoulesToMillijoules = 1.0;
    const double MillijoulesToJoules = 0.001;
    const double MillijoulesToKilojoules = 1e-6;
    const double MillijoulesToMegajoules = 1e-9;
    const double MillijoulesToNewtonMetres =
        0.001; // Newton-metres are equivalent to Joules.
    const double MillijoulesToWattHours = 2.77778e-7;
    const double MillijoulesToKilowattHours = 2.77778e-10;
    const double MillijoulesToMegawattHours = 2.77778e-13;
    const double MillijoulesToCalories = 0.000239006;
    const double MillijoulesToKilocalories = 2.39006e-7;
    const double MillijoulesToFootPoundsForce = 0.000737562;
    const double MillijoulesToBritishThermalUnitsISO = 9.47817e-7;
    const double MillijoulesToTherms = 9.47817e-12;
    const double MillijoulesToHorsepowerHours = 3.72506e-10;
    const double MillijoulesToBarrelsOfOilEquivalent = 1.63456e-13;
    const double MillijoulesToTonnesOfOilEquivalent = 2.38846e-14;
    const double MillijoulesToTonnesOfTNT = 2.39006e-13;
    const double MillijoulesToKilotonnesOfTNT = 2.39006e-16;
    const double MillijoulesToMegatonnesOfTNT = 2.39006e-19;
    const double MillijoulesToErgs = 10000.0;
    const double MillijoulesToElectronvolt = 6241500000000000.0;
    const double MillijoulesToKiloelectronvolt = 6241500000000.0;
    const double MillijoulesToMegaelectronvolt = 6241500000.0;
    const double MillijoulesToGigaelectronvolt = 6241500.0;

//JOULES
    const double JoulesToNanojoules = 1000000000.0;
    const double JoulesToMicrojoules = 1000000.0;
    const double JoulesToMillijoules = 1000.0;
    const double JoulesToJoules = 1.0;
    const double JoulesToKilojoules = 0.001;
    const double JoulesToMegajoules = 1e-6;
    const double JoulesToNewtonMetres =
        1.0; // Newton-metres are equivalent to Joules.
    const double JoulesToWattHours = 0.000277778;
    const double JoulesToKilowattHours = 2.77778e-7;
    const double JoulesToMegawattHours = 2.77778e-10;
    const double JoulesToCalories = 0.239006;
    const double JoulesToKilocalories = 0.000239006;
    const double JoulesToFootPoundsForce = 0.737562;
    const double JoulesToBritishThermalUnitsISO = 0.000947817;
    const double JoulesToTherms = 9.47817e-9;
    const double JoulesToHorsepowerHours = 3.72506e-7;
    const double JoulesToBarrelsOfOilEquivalent = 1.63456e-10;
    const double JoulesToTonnesOfOilEquivalent = 2.38846e-11;
    const double JoulesToTonnesOfTNT = 2.39006e-10;
    const double JoulesToKilotonnesOfTNT = 2.39006e-13;
    const double JoulesToMegatonnesOfTNT = 2.39006e-16;
    const double JoulesToErgs = 10000000.0;
    const double JoulesToElectronvolt = 6.2415e+18;
    const double JoulesToKiloelectronvolt = 6241500000000000.0;
    const double JoulesToMegaelectronvolt = 6241500000000.0;
    const double JoulesToGigaelectronvolt = 6241500000.0;

//KILOJOULES
    const double KilojoulesToNanojoules = 1e12;
    const double KilojoulesToMicrojoules = 1e9;
    const double KilojoulesToMillijoules = 1e6;
    const double KilojoulesToJoules = 1e3;
    const double KilojoulesToKilojoules = 1.0; // Identity
    const double KilojoulesToMegajoules = 0.001;
    const double KilojoulesToNewtonMetres =
        1e3; // Newton-metres are equivalent to Joules.
    const double KilojoulesToWattHours = 0.277778;
    const double KilojoulesToKilowattHours = 0.000277778;
    const double KilojoulesToMegawattHours = 2.77778e-7;
    const double KilojoulesToCalories = 239.006;
    const double KilojoulesToKilocalories = 0.239006;
    const double KilojoulesToFootPoundsForce = 737.562;
    const double KilojoulesToBritishThermalUnitsISO = 0.947817;
    const double KilojoulesToTherms = 9.47817e-6;
    const double KilojoulesToHorsepowerHours = 0.000372506;
    const double KilojoulesToBarrelsOfOilEquivalent = 1.63456e-7;
    const double KilojoulesToTonnesOfOilEquivalent = 2.38846e-8;
    const double KilojoulesToTonnesOfTNT = 2.39006e-7;
    const double KilojoulesToKilotonnesOfTNT = 2.39006e-10;
    const double KilojoulesToMegatonnesOfTNT = 2.39006e-13;
    const double KilojoulesToErgs = 1e10;
    const double KilojoulesToElectronvolt = 6.2415e21;
    const double KilojoulesToKiloelectronvolt = 6.2415e18;
    const double KilojoulesToMegaelectronvolt = 6.2415e15;
    const double KilojoulesToGigaelectronvolt = 6.2415e12;

//MEGAJOULES
    const double MegajoulesToNanojoules = 1e15;
    const double MegajoulesToMicrojoules = 1e12;
    const double MegajoulesToMillijoules = 1e9;
    const double MegajoulesToJoules = 1e6;
    const double MegajoulesToKilojoules = 1e3;
    const double MegajoulesToMegajoules = 1.0; // Identity
    const double MegajoulesToNewtonMetres =
        1e6; // Newton-metres are equivalent to Joules.
    const double MegajoulesToWattHours = 277.778;
    const double MegajoulesToKilowattHours = 0.277778;
    const double MegajoulesToMegawattHours = 0.000277778;
    const double MegajoulesToCalories = 239006.0;
    const double MegajoulesToKilocalories = 239.006;
    const double MegajoulesToFootPoundsForce = 737562.0;
    const double MegajoulesToBritishThermalUnitsISO = 947.817;
    const double MegajoulesToTherms = 0.00947817;
    const double MegajoulesToHorsepowerHours = 0.372506;
    const double MegajoulesToBarrelsOfOilEquivalent = 0.000163456;
    const double MegajoulesToTonnesOfOilEquivalent = 2.38846e-5;
    const double MegajoulesToTonnesOfTNT = 0.000239006;
    const double MegajoulesToKilotonnesOfTNT = 2.39006e-7;
    const double MegajoulesToMegatonnesOfTNT = 2.39006e-10;
    const double MegajoulesToErgs = 1e13;
    const double MegajoulesToElectronvolt = 6.2415e24;
    const double MegajoulesToKiloelectronvolt = 6.2415e21;
    const double MegajoulesToMegaelectronvolt = 6.2415e18;
    const double MegajoulesToGigaelectronvolt = 6.2415e15;

//NEWTON METRES
    const double NewtonMetresToNanojoules = 1e9;
    const double NewtonMetresToMicrojoules = 1e6;
    const double NewtonMetresToMillijoules = 1e3;
    const double NewtonMetresToJoules = 1.0; // Identity
    const double NewtonMetresToKilojoules = 0.001;
    const double NewtonMetresToMegajoules = 1e-6;
    const double NewtonMetresToNewtonMetres =
        1.0; // Newton-metres are equivalent to Joules.
    const double NewtonMetresToWattHours = 0.000277778;
    const double NewtonMetresToKilowattHours = 2.77778e-7;
    const double NewtonMetresToMegawattHours = 2.77778e-10;
    const double NewtonMetresToCalories = 0.239006;
    const double NewtonMetresToKilocalories = 0.000239006;
    const double NewtonMetresToFootPoundsForce = 0.737562;
    const double NewtonMetresToBritishThermalUnitsISO = 0.000947817;
    const double NewtonMetresToTherms = 9.47817e-9;
    const double NewtonMetresToHorsepowerHours = 3.72506e-7;
    const double NewtonMetresToBarrelsOfOilEquivalent = 1.63456e-10;
    const double NewtonMetresToTonnesOfOilEquivalent = 2.38846e-11;
    const double NewtonMetresToTonnesOfTNT = 2.39006e-10;
    const double NewtonMetresToKilotonnesOfTNT = 2.39006e-13;
    const double NewtonMetresToMegatonnesOfTNT = 2.39006e-16;
    const double NewtonMetresToErgs = 1e7;
    const double NewtonMetresToElectronvolt = 6.2415e+18;
    const double NewtonMetresToKiloelectronvolt = 6.2415e+15;
    const double NewtonMetresToMegaelectronvolt = 6.2415e+12;
    const double NewtonMetresToGigaelectronvolt = 6.2415e+9;

//WATTHOURS
    const double WattHoursToNanojoules = 3.6e12;
    const double WattHoursToMicrojoules = 3.6e9;
    const double WattHoursToMillijoules = 3.6e6;
    const double WattHoursToJoules = 3600.0;
    const double WattHoursToKilojoules = 3.6;
    const double WattHoursToMegajoules = 0.0036;
    const double WattHoursToNewtonMetres =
        3600.0; // Newton-metres are equivalent to Joules.
    const double WattHoursToWattHours = 1.0; // Identity
    const double WattHoursToKilowattHours = 0.001;
    const double WattHoursToMegawattHours = 1e-6;
    const double WattHoursToCalories = 860.4216;
    const double WattHoursToKilocalories = 0.8604216;
    const double WattHoursToFootPoundsForce = 2655.2232;
    const double WattHoursToBritishThermalUnitsISO = 3.4121412;
    const double WattHoursToTherms = 3.4121412e-5;
    const double WattHoursToHorsepowerHours = 0.0013410216;
    const double WattHoursToBarrelsOfOilEquivalent = 5.884416e-7;
    const double WattHoursToTonnesOfOilEquivalent = 8.598456e-8;
    const double WattHoursToTonnesOfTNT = 8.604216e-7;
    const double WattHoursToKilotonnesOfTNT = 8.604216e-10;
    const double WattHoursToMegatonnesOfTNT = 8.604216e-13;
    const double WattHoursToErgs = 3.6e10;
    const double WattHoursToElectronvolt = 2.24694e+22;
    const double WattHoursToKiloelectronvolt = 2.24694e+19;
    const double WattHoursToMegaelectronvolt = 2.24694e+16;
    const double WattHoursToGigaelectronvolt = 2.24694e+13;

//KILOWATT HOURS
    const double KilowattHoursToNanojoules = 3.6e15;
    const double KilowattHoursToMicrojoules = 3.6e12;
    const double KilowattHoursToMillijoules = 3.6e9;
    const double KilowattHoursToJoules = 3.6e6;
    const double KilowattHoursToKilojoules = 3600.0;
    const double KilowattHoursToMegajoules = 3.6;
    const double KilowattHoursToNewtonMetres =
        3.6e6; // Newton-metres are equivalent to Joules.
    const double KilowattHoursToWattHours = 1000.0;
    const double KilowattHoursToKilowattHours = 1.0; // Identity
    const double KilowattHoursToMegawattHours = 0.001;
    const double KilowattHoursToCalories = 860421.6;
    const double KilowattHoursToKilocalories = 860.4216;
    const double KilowattHoursToFootPoundsForce = 2655223.2;
    const double KilowattHoursToBritishThermalUnitsISO = 3412.1412;
    const double KilowattHoursToTherms = 0.034121412;
    const double KilowattHoursToHorsepowerHours = 1.3410216;
    const double KilowattHoursToBarrelsOfOilEquivalent = 0.0005884416;
    const double KilowattHoursToTonnesOfOilEquivalent = 0.00008598456;
    const double KilowattHoursToTonnesOfTNT = 0.0008604216;
    const double KilowattHoursToKilotonnesOfTNT = 8.604216e-7;
    const double KilowattHoursToMegatonnesOfTNT = 8.604216e-10;
    const double KilowattHoursToErgs = 3.6e13;
    const double KilowattHoursToElectronvolt = 2.24694e+25;
    const double KilowattHoursToKiloelectronvolt = 2.24694e+22;
    const double KilowattHoursToMegaelectronvolt = 2.24694e+19;
    const double KilowattHoursToGigaelectronvolt = 2.24694e+16;

//MEGAWATT HOURS
    const double MegawattHoursToNanojoules = 3.6e18;
    const double MegawattHoursToMicrojoules = 3.6e15;
    const double MegawattHoursToMillijoules = 3.6e12;
    const double MegawattHoursToJoules = 3.6e9;
    const double MegawattHoursToKilojoules = 3.6e6;
    const double MegawattHoursToMegajoules = 3600.0;
    const double MegawattHoursToNewtonMetres =
        3.6e9; // Newton-metres are equivalent to Joules.
    const double MegawattHoursToWattHours = 1e6;
    const double MegawattHoursToKilowattHours = 1000.0;
    const double MegawattHoursToMegawattHours = 1.0; // Identity
    const double MegawattHoursToCalories = 8.604216e8;
    const double MegawattHoursToKilocalories = 860421.6;
    const double MegawattHoursToFootPoundsForce = 2.6552232e9;
    const double MegawattHoursToBritishThermalUnitsISO = 3.4121412e6;
    const double MegawattHoursToTherms = 34121.412;
    const double MegawattHoursToHorsepowerHours = 1341.0216;
    const double MegawattHoursToBarrelsOfOilEquivalent = 0.5884416;
    const double MegawattHoursToTonnesOfOilEquivalent = 0.08598456;
    const double MegawattHoursToTonnesOfTNT = 0.8604216;
    const double MegawattHoursToKilotonnesOfTNT = 0.0008604216;
    const double MegawattHoursToMegatonnesOfTNT = 8.604216e-7;
    const double MegawattHoursToErgs = 3.6e16;
    const double MegawattHoursToElectronvolt = 2.24694e+28;
    const double MegawattHoursToKiloelectronvolt = 2.24694e+25;
    const double MegawattHoursToMegaelectronvolt = 2.24694e+22;
    const double MegawattHoursToGigaelectronvolt = 2.24694e+19;

//CALORIES
    const double CaloriesToNanojoules = 4.184e9;
    const double CaloriesToMicrojoules = 4.184e6;
    const double CaloriesToMillijoules = 4184.0;
    const double CaloriesToJoules = 4.184;
    const double CaloriesToKilojoules = 0.004184;
    const double CaloriesToMegajoules = 4.184e-6;
    const double CaloriesToNewtonMetres =
        4.184; // Newton-metres are equivalent to Joules.
    const double CaloriesToWattHours = 0.001162223152;
    const double CaloriesToKilowattHours = 1.162223152e-6;
    const double CaloriesToMegawattHours = 1.162223152e-9;
    const double CaloriesToCalories = 1.0; // Identity
    const double CaloriesToKilocalories = 0.001;
    const double CaloriesToFootPoundsForce = 3.085959408;
    const double CaloriesToBritishThermalUnitsISO = 0.003965666328;
    const double CaloriesToTherms = 3.965666328e-8;
    const double CaloriesToHorsepowerHours = 1.558565104e-6;
    const double CaloriesToBarrelsOfOilEquivalent = 6.83899904e-10;
    const double CaloriesToTonnesOfOilEquivalent = 9.99331664e-11;
    const double CaloriesToTonnesOfTNT = 1.000001104e-9;
    const double CaloriesToKilotonnesOfTNT = 1.000001104e-12;
    const double CaloriesToMegatonnesOfTNT = 1.000001104e-15;
    const double CaloriesToErgs = 4.184e7;
    const double CaloriesToElectronvolt = 2.6114436e+19;
    const double CaloriesToKiloelectronvolt = 2.6114436e+16;
    const double CaloriesToMegaelectronvolt = 2.6114436e+13;
    const double CaloriesToGigaelectronvolt = 2.6114436e+10;

//KILOCALORIES
    const double KilocaloriesToNanojoules = 4.184e12;
    const double KilocaloriesToMicrojoules = 4.184e9;
    const double KilocaloriesToMillijoules = 4.184e6;
    const double KilocaloriesToJoules = 4184.0;
    const double KilocaloriesToKilojoules = 4.184;
    const double KilocaloriesToMegajoules = 0.004184;
    const double KilocaloriesToNewtonMetres =
        4184.0; // Newton-metres are equivalent to Joules.
    const double KilocaloriesToWattHours = 1.162223152;
    const double KilocaloriesToKilowattHours = 0.001162223152;
    const double KilocaloriesToMegawattHours = 1.162223152e-6;
    const double KilocaloriesToCalories = 1000.0;
    const double KilocaloriesToKilocalories = 1.0; // Identity
    const double KilocaloriesToFootPoundsForce = 3085.959408;
    const double KilocaloriesToBritishThermalUnitsISO = 3.965666328;
    const double KilocaloriesToTherms = 3.965666328e-5;
    const double KilocaloriesToHorsepowerHours = 0.001558565104;
    const double KilocaloriesToBarrelsOfOilEquivalent = 6.83899904e-7;
    const double KilocaloriesToTonnesOfOilEquivalent = 9.99331664e-8;
    const double KilocaloriesToTonnesOfTNT = 1.000001104e-6;
    const double KilocaloriesToKilotonnesOfTNT = 1.000001104e-9;
    const double KilocaloriesToMegatonnesOfTNT = 1.000001104e-12;
    const double KilocaloriesToErgs = 4.184e10;
    const double KilocaloriesToElectronvolt = 2.6114436e+22;
    const double KilocaloriesToKiloelectronvolt = 2.6114436e+19;
    const double KilocaloriesToMegaelectronvolt = 2.6114436e+16;
    const double KilocaloriesToGigaelectronvolt = 2.6114436e+13;

//FOOTPOUNDS FORCE
    const double FootPoundsForceToNanojoules = 1.3558179483314004e9;
    const double FootPoundsForceToMicrojoules = 1.3558179483314004e6;
    const double FootPoundsForceToMillijoules = 1355.8179483314004;
    const double FootPoundsForceToJoules = 1.3558179483314004;
    const double FootPoundsForceToKilojoules = 0.0013558179483314004;
    const double FootPoundsForceToMegajoules = 1.3558179483314004e-6;
    const double FootPoundsForceToNewtonMetres =
        1.3558179483314004; // Newton-metres are equivalent to Joules.
    const double FootPoundsForceToWattHours = 0.00037661639805159974;
    const double FootPoundsForceToKilowattHours = 3.7661639805159974e-7;
    const double FootPoundsForceToMegawattHours = 3.7661639805159974e-10;
    const double FootPoundsForceToCalories = 0.3240486245588947;
    const double FootPoundsForceToKilocalories = 0.0003240486245588947;
    const double FootPoundsForceToFootPoundsForce = 1.0; // Identity
    const double FootPoundsForceToBritishThermalUnitsISO = 0.001285067300333623;
    const double FootPoundsForceToTherms = 1.285067300333623e-8;
    const double FootPoundsForceToHorsepowerHours = 5.050503206611366e-7;
    const double FootPoundsForceToBarrelsOfOilEquivalent =
        2.2161657856245736e-10;
    const double FootPoundsForceToTonnesOfOilEquivalent = 3.238316936871616e-11;
    const double FootPoundsForceToTonnesOfTNT = 3.240486245588947e-10;
    const double FootPoundsForceToKilotonnesOfTNT = 3.240486245588947e-13;
    const double FootPoundsForceToMegatonnesOfTNT = 3.240486245588947e-16;
    const double FootPoundsForceToErgs = 1.3558179483314004e7;
    const double FootPoundsForceToElectronvolt = 8.462337724510435e+18;
    const double FootPoundsForceToKiloelectronvolt = 8.462337724510435e+15;
    const double FootPoundsForceToMegaelectronvolt = 8.462337724510435e+12;
    const double FootPoundsForceToGigaelectronvolt = 8.462337724510435e+9;

//BRITISH THERMAL UNITS ISO
    const double BritishThermalUnitsISOTonanojoules = 1.05505585262e12;
    const double BritishThermalUnitsISOTomicrojoules = 1.05505585262e9;
    const double BritishThermalUnitsISOTomillijoules = 1.05505585262e6;
    const double BritishThermalUnitsISOTOjoules = 1.05505585262e3;
    const double BritishThermalUnitsISOTOkilojoules = 1.05505585262;
    const double BritishThermalUnitsISOTOMegajoules = 1.05505585262e-3;
    const double BritishThermalUnitsISOTONewtonMetres =
        1.05505585262e3; // Newton-metres are equivalent to Joules.
    const double BritishThermalUnitsISOTOWattHours = 0.2930713046290784;
    const double BritishThermalUnitsISOTOKilowattHours = 0.00029307130462907836;
    const double BritishThermalUnitsISOTOMegawattHours = 2.9307130462907833e-7;
    const double BritishThermalUnitsISOTOCalories = 252.16467911129573;
    const double BritishThermalUnitsISOTOKilocalories = 0.2521646791112957;
    const double BritishThermalUnitsISOTOFootPoundsForce = 778.1691047701125;
    const double BritishThermalUnitsISOTOBritishThermalUnitsISO =
        1.0; // Identity
    const double BritishThermalUnitsISOTOtherms = 9.999998730627305e-6;
    const double BritishThermalUnitsISOTOHorsepowerHours =
        0.0003930146354360657;
    const double BritishThermalUnitsISOTOBarrelsOfOilEquivalent =
        1.724552094458547e-7;
    const double BritishThermalUnitsISOTOTonnesOfOilEquivalent =
        2.5199587017487652e-8;
    const double BritishThermalUnitsISOTOTonnesOfTNT = 2.521646791112957e-7;
    const double BritishThermalUnitsISOTOKilotonnesOfTNT =
        2.5216467911129576e-10;
    const double BritishThermalUnitsISOTOMegatonnesOfTNT =
        2.5216467911129573e-13;
    const double BritishThermalUnitsISOTOErgs = 1.05505585262e10;
    const double BritishThermalUnitsISOTOElectronvolt = 6.58513110412773e+21;
    const double BritishThermalUnitsISOTOKiloelectronvolt =
        6.58513110412773e+18;
    const double BritishThermalUnitsISOTOMegaelectronvolt =
        6.58513110412773e+15;
    const double BritishThermalUnitsISOTOGigaelectronvolt =
        6.58513110412773e+12;

//THERMS
    const double ThermsToNanojoules = 1.05506e+17;
    const double ThermsToMicrojoules = 1.05506e+14;
    const double ThermsToMillijoules = 1.05506e+11;
    const double ThermsToJoules = 1.05506e+8;
    const double ThermsToKilojoules = 1.05506e+5;
    const double ThermsToMegajoules = 105.506;
    const double ThermsToNewtonMetres =
        1.05506e+8; // Newton-metres are equivalent to Joules.
    const double ThermsToWattHours = 29307.245668;
    const double ThermsToKilowattHours = 29.307245668;
    const double ThermsToMegawattHours = 0.029307245668;
    const double ThermsToCalories = 2.5216567036e+7;
    const double ThermsToKilocalories = 25216.567036;
    const double ThermsToFootPoundsForce = 7.7817216372e+7;
    const double ThermsToBritishThermalUnitsISO = 100000.380402;
    const double ThermsToTherms = 1.0; // Identity
    const double ThermsToHorsepowerHours = 39.301618036;
    const double ThermsToBarrelsOfOilEquivalent = 0.017245588736;
    const double ThermsToTonnesOfOilEquivalent = 0.0025199686076;
    const double ThermsToTonnesOfTNT = 0.025216567036;
    const double ThermsToKilotonnesOfTNT = 2.5216567036e-5;
    const double ThermsToMegatonnesOfTNT = 2.5216567036e-8;
    const double ThermsToErgs = 1.05506e+15;
    const double ThermsToElectronvolt = 6.58515699e+26;
    const double ThermsToKiloelectronvolt = 6.58515699e+23;
    const double ThermsToMegaelectronvolt = 6.58515699e+20;
    const double ThermsToGigaelectronvolt = 6.58515699e+17;

//HORSEPOWER HOURS
    const double HorsepowerHoursToNanojoules = 7.457e+11;
    const double HorsepowerHoursToMicrojoules = 7.457e+8;
    const double HorsepowerHoursToMillijoules = 7.457e+5;
    const double HorsepowerHoursToJoules = 745.7;
    const double HorsepowerHoursToKilojoules = 0.7457;
    const double HorsepowerHoursToMegajoules = 0.0007457;
    const double HorsepowerHoursToNewtonMetres =
        745.7; // Newton-metres are equivalent to Joules.
    const double HorsepowerHoursToWattHours = 0.2071390546;
    const double HorsepowerHoursToKilowattHours = 0.0002071390546;
    const double HorsepowerHoursToMegawattHours = 2.071390546e-7;
    const double HorsepowerHoursToCalories = 178.2267742;
    const double HorsepowerHoursToKilocalories = 0.1782267742;
    const double HorsepowerHoursToFootPoundsForce = 550.0; // approximately
    const double HorsepowerHoursToBritishThermalUnitsISO = 0.7067871369;
    const double HorsepowerHoursToTherms = 7.067871369e-6;
    const double HorsepowerHoursToHorsepowerHours = 1.0; // Identity
    const double HorsepowerHoursToBarrelsOfOilEquivalent = 1.218891392e-7;
    const double HorsepowerHoursToTonnesOfOilEquivalent = 1.781074622e-8;
    const double HorsepowerHoursToTonnesOfTNT = 1.782267742e-7;
    const double HorsepowerHoursToKilotonnesOfTNT = 1.782267742e-10;
    const double HorsepowerHoursToMegatonnesOfTNT = 1.782267742e-13;
    const double HorsepowerHoursToErgs = 7.457e+9;
    const double HorsepowerHoursToElectronvolt = 4.65428655e+21;
    const double HorsepowerHoursToKiloelectronvolt = 4.65428655e+18;
    const double HorsepowerHoursToMegaelectronvolt = 4.65428655e+15;
    const double HorsepowerHoursToGigaelectronvolt = 4.65428655e+12;
//BARRELS OF OIL EQUIVALENT
    const double BarrelsOfOilEquivalentToNanojoules = 6.1194e+18;
    const double BarrelsOfOilEquivalentToMicrojoules = 6.1194e+15;
    const double BarrelsOfOilEquivalentToMillijoules = 6.1194e+12;
    const double BarrelsOfOilEquivalentToJoules = 6.1194e+9;
    const double BarrelsOfOilEquivalentToKilojoules = 6.1194e+6;
    const double BarrelsOfOilEquivalentToMegajoules = 6119.4;
    const double BarrelsOfOilEquivalentToNewtonMetres =
        6.1194e+9; // Newton-metres are equivalent to Joules.
    const double BarrelsOfOilEquivalentToWattHours = 1699834.6932;
    const double BarrelsOfOilEquivalentToKilowattHours = 1699.8346932;
    const double BarrelsOfOilEquivalentToMegawattHours = 1.6998346932;
    const double BarrelsOfOilEquivalentToCalories = 1.4625733164e+9;
    const double BarrelsOfOilEquivalentToKilocalories = 1462573.3164;
    const double BarrelsOfOilEquivalentToFootPoundsForce = 4.5134369028e+9;
    const double BarrelsOfOilEquivalentToBritishThermalUnitsISO = 5800071.3498;
    const double BarrelsOfOilEquivalentToTherms = 58.000713498;
    const double BarrelsOfOilEquivalentToHorsepowerHours = 2279.5132164;
    const double BarrelsOfOilEquivalentToBarrelsOfOilEquivalent =
        1.0; // Identity
    const double BarrelsOfOilEquivalentToTonnesOfOilEquivalent = 0.14615942124;
    const double BarrelsOfOilEquivalentToTonnesOfTNT = 1.4625733164;
    const double BarrelsOfOilEquivalentToKilotonnesOfTNT = 0.0014625733164;
    const double BarrelsOfOilEquivalentToMegatonnesOfTNT = 1.4625733164e-6;
    const double BarrelsOfOilEquivalentToErgs = 6.1194e+16;
    const double BarrelsOfOilEquivalentToElectronvolt = 3.81942351e+28;
    const double BarrelsOfOilEquivalentToKiloelectronvolt = 3.81942351e+25;
    const double BarrelsOfOilEquivalentToMegaelectronvolt = 3.81942351e+22;
    const double BarrelsOfOilEquivalentToGigaelectronvolt = 3.81942351e+19;

//TONS OF OIL EQUIVALENT
    const double TonnesOfOilEquivalentToNanojoules = 4.1868e+19;
    const double TonnesOfOilEquivalentToMicrojoules = 4.1868e+16;
    const double TonnesOfOilEquivalentToMillijoules = 4.1868e+13;
    const double TonnesOfOilEquivalentToJoules = 4.1868e+10;
    const double TonnesOfOilEquivalentToKilojoules = 4.1868e+7;
    const double TonnesOfOilEquivalentToMegajoules = 41868.0;
    const double TonnesOfOilEquivalentToNewtonMetres =
        4.1868e+10; // Newton-metres are equivalent to Joules.
    const double TonnesOfOilEquivalentToWattHours = 11630009.304;
    const double TonnesOfOilEquivalentToKilowattHours = 11630.009304;
    const double TonnesOfOilEquivalentToMegawattHours = 11.630009304;
    const double TonnesOfOilEquivalentToCalories = 1.0006703208e+10;
    const double TonnesOfOilEquivalentToKilocalories = 10006703.208;
    const double TonnesOfOilEquivalentToFootPoundsForce = 3.0880245816e+10;
    const double TonnesOfOilEquivalentToBritishThermalUnitsISO = 39683202.156;
    const double TonnesOfOilEquivalentToTherms = 396.83202156;
    const double TonnesOfOilEquivalentToHorsepowerHours = 15596.081208;
    const double TonnesOfOilEquivalentToBarrelsOfOilEquivalent = 6.843575808;
    const double TonnesOfOilEquivalentToTonnesOfOilEquivalent = 1.0; // Identity
    const double TonnesOfOilEquivalentToTonnesOfTNT = 10.006703208;
    const double TonnesOfOilEquivalentToKilotonnesOfTNT = 0.010006703208;
    const double TonnesOfOilEquivalentToMegatonnesOfTNT = 1.0006703208e-5;
    const double TonnesOfOilEquivalentToErgs = 4.1868e+17;
    const double TonnesOfOilEquivalentToElectronvolt = 2.61319122e+29;
    const double TonnesOfOilEquivalentToKiloelectronvolt = 2.61319122e+26;
    const double TonnesOfOilEquivalentToMegaelectronvolt = 2.61319122e+23;
    const double TonnesOfOilEquivalentToGigaelectronvolt = 2.61319122e+20;

//TONNES OF TNT
    const double TonnesOfTNTToNanojoules = 4.184e+18;
    const double TonnesOfTNTToMicrojoules = 4.184e+15;
    const double TonnesOfTNTToMillijoules = 4.184e+12;
    const double TonnesOfTNTToJoules = 4.184e+9;
    const double TonnesOfTNTToKilojoules = 4.184e+6;
    const double TonnesOfTNTToMegajoules = 4184.0;
    const double TonnesOfTNTToNewtonMetres =
        4.184e+9; // Newton-metres are equivalent to Joules.
    const double TonnesOfTNTToWattHours = 1162223.152;
    const double TonnesOfTNTToKilowattHours = 1162.223152;
    const double TonnesOfTNTToMegawattHours = 1.162223152;
    const double TonnesOfTNTToCalories = 1e+9; // approximately
    const double TonnesOfTNTToKilocalories = 1e+6; // approximately
    const double TonnesOfTNTToFootPoundsForce = 3.085959408e+9;
    const double TonnesOfTNTToBritishThermalUnitsISO = 3965666.328;
    const double TonnesOfTNTToTherms = 39.65666328;
    const double TonnesOfTNTToHorsepowerHours = 1558.565104;
    const double TonnesOfTNTToBarrelsOfOilEquivalent = 0.683899904;
    const double TonnesOfTNTToTonnesOfOilEquivalent = 0.0999331664;
    const double TonnesOfTNTToKilotonnesOfTNT = 0.001;
    const double TonnesOfTNTToMegatonnesOfTNT = 1e-6;
    const double TonnesOfTNTToErgs = 4.184e+16;
    const double TonnesOfTNTToElectronvolt = 2.6114436e+28;
    const double TonnesOfTNTToKiloelectronvolt = 2.6114436e+25;
    const double TonnesOfTNTToMegaelectronvolt = 2.6114436e+22;
    const double TonnesOfTNTToGigaelectronvolt = 2.6114436e+19;

//KILOTONNES
    const double KilotonnesOfTNTToNanojoules = 4.184e+21;
    const double KilotonnesOfTNTToMicrojoules = 4.184e+18;
    const double KilotonnesOfTNTToMillijoules = 4.184e+15;
    const double KilotonnesOfTNTToJoules = 4.184e+12;
    const double KilotonnesOfTNTToKilojoules = 4.184e+9;
    const double KilotonnesOfTNTToMegajoules = 4.184e+6;
    const double KilotonnesOfTNTToNewtonMetres =
        4.184e+12; // Newton-metres are equivalent to Joules.
    const double KilotonnesOfTNTToWattHours = 1.162223152e+9;
    const double KilotonnesOfTNTToKilowattHours = 1.162223152e+6;
    const double KilotonnesOfTNTToMegawattHours = 1162.223152;
    const double KilotonnesOfTNTToCalories = 1e+12; // approximately
    const double KilotonnesOfTNTToKilocalories = 1e+9; // approximately
    const double KilotonnesOfTNTToFootPoundsForce = 3.085959408e+12;
    const double KilotonnesOfTNTToBritishThermalUnitsISO = 3.965666328e+9;
    const double KilotonnesOfTNTToTherms = 39656.66328;
    const double KilotonnesOfTNTToHorsepowerHours = 1.558565104e+6;
    const double KilotonnesOfTNTToBarrelsOfOilEquivalent = 683.899904;
    const double KilotonnesOfTNTToTonnesOfOilEquivalent = 99.9331664;
    const double KilotonnesOfTNTToTonnesOfTNT = 1000.0;
    const double KilotonnesOfTNTToMegatonnesOfTNT = 0.001;
    const double KilotonnesOfTNTToErgs = 4.184e+19;
    const double KilotonnesOfTNTToElectronvolt = 2.6114436e+31;
    const double KilotonnesOfTNTToKiloelectronvolt = 2.6114436e+28;
    const double KilotonnesOfTNTToMegaelectronvolt = 2.6114436e+25;
    const double KilotonnesOfTNTToGigaelectronvolt = 2.6114436e+22;

//MEGATONNES OF TNT
    const double MegatonnesOfTNTToNanojoules = 4.184e+24;
    const double MegatonnesOfTNTToMicrojoules = 4.184e+21;
    const double MegatonnesOfTNTToMillijoules = 4.184e+18;
    const double MegatonnesOfTNTToJoules = 4.184e+15;
    const double MegatonnesOfTNTToKilojoules = 4.184e+12;
    const double MegatonnesOfTNTToMegajoules = 4.184e+9;
    const double MegatonnesOfTNTToNewtonMetres =
        4.184e+15; // Newton-metres are equivalent to Joules.
    const double MegatonnesOfTNTToWattHours = 1.162223152e+9;
    const double MegatonnesOfTNTToKilowattHours = 1.162223152e+6;
    const double MegatonnesOfTNTToMegawattHours = 1162.223152;
    const double MegatonnesOfTNTToCalories = 1e+15; // approximately
    const double MegatonnesOfTNTToKilocalories = 1e+12; // approximately
    const double MegatonnesOfTNTToFootPoundsForce = 3.085959408e+15;
    const double MegatonnesOfTNTToBritishThermalUnitsISO = 3.965666328e+12;
    const double MegatonnesOfTNTToTherms = 39656663.28;
    const double MegatonnesOfTNTToHorsepowerHours = 1.558565104e+9;
    const double MegatonnesOfTNTToBarrelsOfOilEquivalent = 683899.904;
    const double MegatonnesOfTNTToTonnesOfOilEquivalent = 99933.1664;
    const double MegatonnesOfTNTToTonnesOfTNT = 1e+6;
    const double MegatonnesOfTNTToKilotonnesOfTNT = 1000.0;
    const double MegatonnesOfTNTToErgs = 4.184e+22;
    const double MegatonnesOfTNTToElectronvolt = 2.6114436e+34;
    const double MegatonnesOfTNTToKiloelectronvolt = 2.6114436e+31;
    const double MegatonnesOfTNTToMegaelectronvolt = 2.6114436e+28;
    const double MegatonnesOfTNTToGigaelectronvolt = 2.6114436e+25;

//ERGS
    const double ErgsToNanojoules = 100.0;
    const double ErgsToMicrojoules = 0.1;
    const double ErgsToMillijoules = 0.0001;
    const double ErgsToJoules = 1e-7;
    const double ErgsToKilojoules = 1e-10;
    const double ErgsToMegajoules = 1e-13;
    const double ErgsToNewtonMetres =
        1e-7; // Newton-metres are equivalent to Joules.
    const double ErgsToWattHours = 2.77778e-11;
    const double ErgsToKilowattHours = 2.77778e-14;
    const double ErgsToMegawattHours = 2.77778e-17;
    const double ErgsToCalories = 2.39006e-8;
    const double ErgsToKilocalories = 2.39006e-11;
    const double ErgsToFootPoundsForce = 7.37562e-8;
    const double ErgsToBritishThermalUnitsISO = 9.47817e-11;
    const double ErgsToTherms = 9.47817e-16;
    const double ErgsToHorsepowerHours = 3.72506e-14;
    const double ErgsToBarrelsOfOilEquivalent = 1.63456e-17;
    const double ErgsToTonnesOfOilEquivalent = 2.38846e-18;
    const double ErgsToTonnesOfTNT = 2.39006e-17;
    const double ErgsToKilotonnesOfTNT = 2.39006e-20;
    const double ErgsToMegatonnesOfTNT = 2.39006e-23;

    const double ErgsToElectronvolt = 6.2415e+11;
    const double ErgsToKiloelectronvolt = 6.2415e+8;
    const double ErgsToMegaelectronvolt = 624150.0;
    const double ErgsToGigaelectronvolt = 624.15;

//ELECTRONVOLT
    const double ElectronvoltToNanojoules = 1.60218e-10;
    const double ElectronvoltToMicrojoules = 1.60218e-13;
    const double ElectronvoltToMillijoules = 1.60218e-16;
    const double ElectronvoltToJoules = 1.60218e-19;
    const double ElectronvoltToKilojoules = 1.60218e-22;
    const double ElectronvoltToMegajoules = 1.60218e-25;
    const double ElectronvoltToNewtonMetres =
        1.60218e-19; // Newton-metres are equivalent to Joules.
    const double ElectronvoltToWattHours = 4.4505e-23;
    const double ElectronvoltToKilowattHours = 4.4505e-26;
    const double ElectronvoltToMegawattHours = 4.4505e-29;
    const double ElectronvoltToCalories = 3.8293e-20;
    const double ElectronvoltToKilocalories = 3.8293e-23;
    const double ElectronvoltToFootPoundsForce = 1.1817e-19;
    const double ElectronvoltToBritishThermalUnitsISO = 1.51857e-22;
    const double ElectronvoltToTherms = 1.51857e-27;
    const double ElectronvoltToHorsepowerHours = 5.9682e-26;
    const double ElectronvoltToBarrelsOfOilEquivalent = 2.6188e-29;
    const double ElectronvoltToTonnesOfOilEquivalent = 3.8267e-30;
    const double ElectronvoltToTonnesOfTNT = 3.8293e-29;
    const double ElectronvoltToKilotonnesOfTNT = 3.8293e-32;
    const double ElectronvoltToMegatonnesOfTNT = 3.8293e-35;
    const double ElectronvoltToErgs = 1.60218e-12;

//KILOELECTRONVOLT
    const double KiloelectronvoltToNanojoules = 1.60218e-7;
    const double KiloelectronvoltToMicrojoules = 1.60218e-10;
    const double KiloelectronvoltToMillijoules = 1.60218e-13;
    const double KiloelectronvoltToJoules = 1.60218e-16;
    const double KiloelectronvoltToKilojoules = 1.60218e-19;
    const double KiloelectronvoltToMegajoules = 1.60218e-22;
    const double KiloelectronvoltToNewtonMetres =
        1.60218e-16; // Newton-metres are equivalent to Joules.
    const double KiloelectronvoltToWattHours = 4.4505e-20;
    const double KiloelectronvoltToKilowattHours = 4.4505e-23;
    const double KiloelectronvoltToMegawattHours = 4.4505e-26;
    const double KiloelectronvoltToCalories = 3.8293e-17;
    const double KiloelectronvoltToKilocalories = 3.8293e-20;
    const double KiloelectronvoltToFootPoundsForce = 1.1817e-16;
    const double KiloelectronvoltToBritishThermalUnitsISO = 1.51857e-19;
    const double KiloelectronvoltToTherms = 1.51857e-24;
    const double KiloelectronvoltToHorsepowerHours = 5.9682e-23;
    const double KiloelectronvoltToBarrelsOfOilEquivalent = 2.6188e-26;
    const double KiloelectronvoltToTonnesOfOilEquivalent = 3.8267e-27;
    const double KiloelectronvoltToTonnesOfTNT = 3.8293e-26;
    const double KiloelectronvoltToKilotonnesOfTNT = 3.8293e-29;
    const double KiloelectronvoltToMegatonnesOfTNT = 3.8293e-32;
    const double KiloelectronvoltToErgs = 1.60218e-9;

//MEGAELECTRONVOLT
    const double MegaelectronvoltToNanojoules = 0.000160218;
    const double MegaelectronvoltToMicrojoules = 1.60218e-7;
    const double MegaelectronvoltToMillijoules = 1.60218e-10;
    const double MegaelectronvoltToJoules = 1.60218e-13;
    const double MegaelectronvoltToKilojoules = 1.60218e-16;
    const double MegaelectronvoltToMegajoules = 1.60218e-19;
    const double MegaelectronvoltToNewtonMetres =
        1.60218e-13; // Newton-metres are equivalent to Joules.
    const double MegaelectronvoltToWattHours = 4.4505e-17;
    const double MegaelectronvoltToKilowattHours = 4.4505e-20;
    const double MegaelectronvoltToMegawattHours = 4.4505e-23;
    const double MegaelectronvoltToCalories = 3.8293e-14;
    const double MegaelectronvoltToKilocalories = 3.8293e-17;
    const double MegaelectronvoltToFootPoundsForce = 1.1817e-13;
    const double MegaelectronvoltToBritishThermalUnitsISO = 1.51857e-16;
    const double MegaelectronvoltToTherms = 1.51857e-21;
    const double MegaelectronvoltToHorsepowerHours = 5.9682e-20;
    const double MegaelectronvoltToBarrelsOfOilEquivalent = 2.6188e-23;
    const double MegaelectronvoltToTonnesOfOilEquivalent = 3.8267e-24;
    const double MegaelectronvoltToTonnesOfTNT = 3.8293e-23;
    const double MegaelectronvoltToKilotonnesOfTNT = 3.8293e-26;
    const double MegaelectronvoltToMegatonnesOfTNT = 3.8293e-29;
    const double MegaelectronvoltToErgs = 1.60218e-6;

//GIGAELECTRONVOLT
    const double GigaelectronvoltToNanojoules = 0.160218;
    const double GigaelectronvoltToMicrojoules = 0.000160218;
    const double GigaelectronvoltToMillijoules = 1.60218e-7;
    const double GigaelectronvoltToJoules = 1.60218e-10;
    const double GigaelectronvoltToKilojoules = 1.60218e-13;
    const double GigaelectronvoltToMegajoules = 1.60218e-16;
    const double GigaelectronvoltToNewtonMetres =
        1.60218e-10; // Newton-metres are equivalent to Joules.
    const double GigaelectronvoltToWattHours = 4.4505e-14;
    const double GigaelectronvoltToKilowattHours = 4.4505e-17;
    const double GigaelectronvoltToMegawattHours = 4.4505e-20;
    const double GigaelectronvoltToCalories = 3.8293e-11;
    const double GigaelectronvoltToKilocalories = 3.8293e-14;
    const double GigaelectronvoltToFootPoundsForce = 1.1817e-10;
    const double GigaelectronvoltToBritishThermalUnitsISO = 1.51857e-13;
    const double GigaelectronvoltToTherms = 1.51857e-18;
    const double GigaelectronvoltToHorsepowerHours = 5.9682e-17;
    const double GigaelectronvoltToBarrelsOfOilEquivalent = 2.6188e-20;
    const double GigaelectronvoltToTonnesOfOilEquivalent = 3.8267e-21;
    const double GigaelectronvoltToTonnesOfTNT = 3.8293e-20;
    const double GigaelectronvoltToKilotonnesOfTNT = 3.8293e-23;
    const double GigaelectronvoltToMegatonnesOfTNT = 3.8293e-26;
    const double GigaelectronvoltToErgs = 1.60218e-3;

    switch (fromUnit) {
//NANOJOULES
      case 'Nanojoules':
        switch (toUnit) {
          case 'Nanojoules':
            toValue = fromValue;
            break;
          case 'Microjoules':
            toValue = fromValue * NanojoulesToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * NanojoulesToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * NanojoulesToJoules;
            break;
          case 'Kilojoules':
            toValue = fromValue * NanojoulesToKilojoules;
            break;
          case 'Megajoules':
            toValue = fromValue * NanojoulesToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * NanojoulesToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * NanojoulesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * NanojoulesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * NanojoulesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * NanojoulesToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * NanojoulesToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * NanojoulesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * NanojoulesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * NanojoulesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * NanojoulesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * NanojoulesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * NanojoulesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * NanojoulesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * NanojoulesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * NanojoulesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * NanojoulesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * NanojoulesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * NanojoulesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * NanojoulesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * NanojoulesToGigaelectronvolt;
            break;
          default:
            throw 'Unknown unit: $toUnit';
        }
        break;

//MICROJOULES
      case 'Microjoules':
        switch (toUnit) {
          case 'Microjoules':
            toValue = fromValue;
            break;

          case 'Nanojoules':
            toValue = fromValue * MicrojoulesToNanojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * MicrojoulesToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * MicrojoulesToJoules;
            break;
          case 'Kilojoules':
            toValue = fromValue * MicrojoulesToKilojoules;
            break;
          case 'Megajoules':
            toValue = fromValue * MicrojoulesToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * MicrojoulesToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * MicrojoulesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * MicrojoulesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * MicrojoulesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * MicrojoulesToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * MicrojoulesToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * MicrojoulesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * MicrojoulesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * MicrojoulesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * MicrojoulesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * MicrojoulesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * MicrojoulesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * MicrojoulesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * MicrojoulesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * MicrojoulesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * MicrojoulesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * MicrojoulesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * MicrojoulesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * MicrojoulesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * MicrojoulesToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//MILLIJOULES
      case 'Millijoules':
        switch (toUnit) {
          case 'Millijoules':
            toValue = fromValue;
            break;

          case 'Nanojoules':
            toValue = fromValue * MillijoulesToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * MillijoulesToMicrojoules;
            break;
          case 'Joules':
            toValue = fromValue * MillijoulesToJoules;
            break;
          case 'Kilojoules':
            toValue = fromValue * MillijoulesToKilojoules;
            break;
          case 'Megajoules':
            toValue = fromValue * MillijoulesToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * MillijoulesToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * MillijoulesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * MillijoulesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * MillijoulesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * MillijoulesToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * MillijoulesToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * MillijoulesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * MillijoulesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * MillijoulesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * MillijoulesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * MillijoulesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * MillijoulesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * MillijoulesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * MillijoulesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * MillijoulesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * MillijoulesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * MillijoulesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * MillijoulesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * MillijoulesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * MillijoulesToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//JOULES
      case 'Joules':
        switch (toUnit) {
          case 'Joules':
            toValue = fromValue;
            break;
          case 'Nanojoules':
            toValue = fromValue * JoulesToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * JoulesToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * JoulesToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue *
                JoulesToJoules; // This is redundant but keeps the structure consistent
            break;
          case 'Kilojoules':
            toValue = fromValue * JoulesToKilojoules;
            break;
          case 'Megajoules':
            toValue = fromValue * JoulesToMegajoules;
            break;
          case 'Newton-metres':
            toValue =
                fromValue * JoulesToNewtonMetres; // This is also redundant
            break;
          case 'Watt-hours':
            toValue = fromValue * JoulesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * JoulesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * JoulesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * JoulesToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * JoulesToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * JoulesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * JoulesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * JoulesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * JoulesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * JoulesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * JoulesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * JoulesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * JoulesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * JoulesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * JoulesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * JoulesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * JoulesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * JoulesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * JoulesToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOJOULES
      case 'Kilojoules':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue;
            break;

          case 'Joules':
            toValue = fromValue * KilojoulesToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * KilojoulesToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * KilojoulesToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * KilojoulesToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * KilojoulesToJoules;
            break;
          case 'Megajoules':
            toValue = fromValue * KilojoulesToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * KilojoulesToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * KilojoulesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * KilojoulesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * KilojoulesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * KilojoulesToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * KilojoulesToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * KilojoulesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * KilojoulesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * KilojoulesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * KilojoulesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * KilojoulesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * KilojoulesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * KilojoulesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * KilojoulesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * KilojoulesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * KilojoulesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * KilojoulesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * KilojoulesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * KilojoulesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * KilojoulesToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//MEGAJOULES
      case 'Megajoules':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * MegajoulesToKilojoules;
            break;

          case 'Joules':
            toValue = fromValue * MegajoulesToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * MegajoulesToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * MegajoulesToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * MegajoulesToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * MegajoulesToJoules;
            break;
          case 'Megajoules':
            toValue = fromValue;
            break;
          case 'Newton-metres':
            toValue = fromValue * MegajoulesToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * MegajoulesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * MegajoulesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * MegajoulesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * MegajoulesToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * MegajoulesToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * MegajoulesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * MegajoulesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * MegajoulesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * MegajoulesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * MegajoulesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * MegajoulesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * MegajoulesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * MegajoulesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * MegajoulesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * MegajoulesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * MegajoulesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * MegajoulesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * MegajoulesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * MegajoulesToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//NEWTON METRES
      case 'Newton-metres':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * NewtonMetresToKilojoules;
            break;

          case 'Joules':
            toValue = fromValue * NewtonMetresToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * NewtonMetresToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * NewtonMetresToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * NewtonMetresToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * NewtonMetresToJoules;
            break;
          case 'Megajoules':
            toValue = fromValue * NewtonMetresToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue;
            break;
          case 'Watt-hours':
            toValue = fromValue * NewtonMetresToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * NewtonMetresToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * NewtonMetresToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * NewtonMetresToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * NewtonMetresToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * NewtonMetresToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * NewtonMetresToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * NewtonMetresToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * NewtonMetresToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * NewtonMetresToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * NewtonMetresToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * NewtonMetresToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * NewtonMetresToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * NewtonMetresToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * NewtonMetresToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * NewtonMetresToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * NewtonMetresToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * NewtonMetresToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * NewtonMetresToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//WATTHOURS
      case 'Watt-hours':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * WattHoursToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * WattHoursToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * WattHoursToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * WattHoursToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * WattHoursToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * WattHoursToJoules;
            break;
          case 'Megajoules':
            toValue = fromValue * WattHoursToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * WattHoursToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * WattHoursToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * WattHoursToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * WattHoursToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * WattHoursToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * WattHoursToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * WattHoursToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * WattHoursToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * WattHoursToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * WattHoursToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * WattHoursToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * WattHoursToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * WattHoursToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * WattHoursToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * WattHoursToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * WattHoursToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * WattHoursToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * WattHoursToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * WattHoursToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOWATT HOURS
      case 'Kilowatt-hours':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * KilowattHoursToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * KilowattHoursToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * KilowattHoursToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * KilowattHoursToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * KilowattHoursToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * KilowattHoursToJoules;
            break;
          case 'Megajoules':
            toValue = fromValue * KilowattHoursToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * KilowattHoursToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * KilowattHoursToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * KilowattHoursToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * KilowattHoursToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * KilowattHoursToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * KilowattHoursToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * KilowattHoursToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * KilowattHoursToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * KilowattHoursToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * KilowattHoursToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * KilowattHoursToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * KilowattHoursToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * KilowattHoursToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * KilowattHoursToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * KilowattHoursToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * KilowattHoursToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * KilowattHoursToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * KilowattHoursToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * KilowattHoursToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
//MEGAWATT HOURS
      case 'Megawatt-hours':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * MegawattHoursToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * MegawattHoursToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * MegawattHoursToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * MegawattHoursToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * MegawattHoursToMillijoules;
            break;
          case 'Joules':
            toValue = fromValue * MegawattHoursToJoules;
            break;
          case 'Megajoules':
            toValue = fromValue * MegawattHoursToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * MegawattHoursToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * MegawattHoursToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * MegawattHoursToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * MegawattHoursToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * MegawattHoursToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * MegawattHoursToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * MegawattHoursToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * MegawattHoursToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * MegawattHoursToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * MegawattHoursToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * MegawattHoursToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * MegawattHoursToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * MegawattHoursToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * MegawattHoursToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * MegawattHoursToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * MegawattHoursToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * MegawattHoursToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * MegawattHoursToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * MegawattHoursToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * MegawattHoursToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//CALORIES
      case 'Calories':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * CaloriesToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * CaloriesToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * CaloriesToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * CaloriesToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * CaloriesToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * CaloriesToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * CaloriesToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * CaloriesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * CaloriesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * CaloriesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue;
            break;
          case 'Kilocalories':
            toValue = fromValue * CaloriesToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * CaloriesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * CaloriesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * CaloriesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * CaloriesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * CaloriesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * CaloriesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * CaloriesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * CaloriesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * CaloriesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * CaloriesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * CaloriesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * CaloriesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * CaloriesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * CaloriesToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOCALORIES
      case 'Kilocalories':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * KilocaloriesToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * KilocaloriesToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * KilocaloriesToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * KilocaloriesToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * KilocaloriesToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * KilocaloriesToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * KilocaloriesToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * KilocaloriesToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * KilocaloriesToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * KilocaloriesToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * KilocaloriesToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * KilocaloriesToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * KilocaloriesToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * KilocaloriesToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * KilocaloriesToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * KilocaloriesToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * KilocaloriesToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * KilocaloriesToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * KilocaloriesToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * KilocaloriesToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * KilocaloriesToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * KilocaloriesToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * KilocaloriesToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * KilocaloriesToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * KilocaloriesToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//FOOTPOUNDS FORCE
      case 'Foot-pounds Force':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * FootPoundsForceToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * FootPoundsForceToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * FootPoundsForceToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * FootPoundsForceToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * FootPoundsForceToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * FootPoundsForceToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * FootPoundsForceToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * FootPoundsForceToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * FootPoundsForceToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * FootPoundsForceToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * FootPoundsForceToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * FootPoundsForceToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * FootPoundsForceToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * FootPoundsForceToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * FootPoundsForceToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * FootPoundsForceToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * FootPoundsForceToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * FootPoundsForceToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * FootPoundsForceToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * FootPoundsForceToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * FootPoundsForceToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * FootPoundsForceToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * FootPoundsForceToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * FootPoundsForceToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * FootPoundsForceToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * FootPoundsForceToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//BRITISH THERMAL UNITS ISO
      case 'British Thermal Units (ISO)':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * BritishThermalUnitsISOTOkilojoules;
            break;
          case 'Joules':
            toValue = fromValue * BritishThermalUnitsISOTOjoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * BritishThermalUnitsISOTonanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * BritishThermalUnitsISOTomicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * BritishThermalUnitsISOTomillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * FootPoundsForceToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * BritishThermalUnitsISOTONewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * BritishThermalUnitsISOTOWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * BritishThermalUnitsISOTOKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * BritishThermalUnitsISOTOMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * BritishThermalUnitsISOTOCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * BritishThermalUnitsISOTOKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * BritishThermalUnitsISOTOFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue;
            break;
          case 'Therms':
            toValue = fromValue * BritishThermalUnitsISOTOtherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * BritishThermalUnitsISOTOHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue =
                fromValue * BritishThermalUnitsISOTOBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * BritishThermalUnitsISOTOTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * BritishThermalUnitsISOTOTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * BritishThermalUnitsISOTOKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * BritishThermalUnitsISOTOMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * BritishThermalUnitsISOTOErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * BritishThermalUnitsISOTOElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * BritishThermalUnitsISOTOKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * BritishThermalUnitsISOTOMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * BritishThermalUnitsISOTOGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//THERMS
      case 'Therms':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * ThermsToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * ThermsToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * ThermsToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * ThermsToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * ThermsToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * ThermsToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * ThermsToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * ThermsToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * ThermsToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * ThermsToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * ThermsToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * ThermsToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * ThermsToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * ThermsToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * ThermsToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * ThermsToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * ThermsToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * ThermsToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * ThermsToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * ThermsToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * ThermsToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * ThermsToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * ThermsToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * ThermsToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * ThermsToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//HORSEPOWER HOURS
      case 'Horsepower Hours':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * HorsepowerHoursToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * HorsepowerHoursToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * HorsepowerHoursToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * HorsepowerHoursToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * HorsepowerHoursToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * HorsepowerHoursToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * HorsepowerHoursToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * HorsepowerHoursToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * HorsepowerHoursToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * HorsepowerHoursToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * HorsepowerHoursToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * HorsepowerHoursToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * HorsepowerHoursToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * HorsepowerHoursToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * HorsepowerHoursToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * HorsepowerHoursToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * HorsepowerHoursToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * HorsepowerHoursToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * HorsepowerHoursToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * HorsepowerHoursToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * HorsepowerHoursToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * HorsepowerHoursToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * HorsepowerHoursToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * HorsepowerHoursToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * HorsepowerHoursToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * HorsepowerHoursToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//BARRELS OF OIL EQUIVALENT
      case 'Barrels of Oil Equivalent':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * BarrelsOfOilEquivalentToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * BarrelsOfOilEquivalentToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * BarrelsOfOilEquivalentToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * BarrelsOfOilEquivalentToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * BarrelsOfOilEquivalentToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * BarrelsOfOilEquivalentToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * BarrelsOfOilEquivalentToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * BarrelsOfOilEquivalentToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * BarrelsOfOilEquivalentToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * BarrelsOfOilEquivalentToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * BarrelsOfOilEquivalentToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * BarrelsOfOilEquivalentToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * BarrelsOfOilEquivalentToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue =
                fromValue * BarrelsOfOilEquivalentToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * BarrelsOfOilEquivalentToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * BarrelsOfOilEquivalentToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * BarrelsOfOilEquivalentToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * BarrelsOfOilEquivalentToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * BarrelsOfOilEquivalentToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * BarrelsOfOilEquivalentToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * BarrelsOfOilEquivalentToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * BarrelsOfOilEquivalentToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * BarrelsOfOilEquivalentToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * BarrelsOfOilEquivalentToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * BarrelsOfOilEquivalentToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//TONS OF OIL EQUIVALENT
      case 'Tonnes of Oil Equivalent':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * TonnesOfOilEquivalentToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * TonnesOfOilEquivalentToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * TonnesOfOilEquivalentToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * TonnesOfOilEquivalentToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * TonnesOfOilEquivalentToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * TonnesOfOilEquivalentToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * TonnesOfOilEquivalentToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * TonnesOfOilEquivalentToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * TonnesOfOilEquivalentToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * TonnesOfOilEquivalentToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * TonnesOfOilEquivalentToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * TonnesOfOilEquivalentToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * TonnesOfOilEquivalentToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * TonnesOfOilEquivalentToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * TonnesOfOilEquivalentToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * TonnesOfOilEquivalentToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * TonnesOfOilEquivalentToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * TonnesOfOilEquivalentToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * TonnesOfOilEquivalentToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * TonnesOfOilEquivalentToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * TonnesOfOilEquivalentToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * TonnesOfOilEquivalentToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * TonnesOfOilEquivalentToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * TonnesOfOilEquivalentToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * TonnesOfOilEquivalentToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * TonnesOfOilEquivalentToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//TONNES OF TNT
      case 'Tonnes of TNT':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * TonnesOfTNTToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * TonnesOfTNTToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * TonnesOfTNTToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * TonnesOfTNTToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * TonnesOfTNTToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * TonnesOfTNTToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * TonnesOfTNTToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * TonnesOfTNTToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * TonnesOfTNTToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * TonnesOfTNTToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * TonnesOfTNTToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * TonnesOfTNTToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * TonnesOfTNTToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * TonnesOfTNTToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * TonnesOfTNTToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * TonnesOfTNTToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * TonnesOfTNTToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * TonnesOfTNTToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * TonnesOfTNTToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * TonnesOfTNTToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * TonnesOfTNTToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * TonnesOfTNTToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * TonnesOfTNTToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * TonnesOfTNTToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * TonnesOfTNTToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOTONNES
      case 'Kilotonnes of TNT':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * KilotonnesOfTNTToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * KilotonnesOfTNTToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * KilotonnesOfTNTToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * KilotonnesOfTNTToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * KilotonnesOfTNTToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * KilotonnesOfTNTToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * KilotonnesOfTNTToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * KilotonnesOfTNTToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * KilotonnesOfTNTToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * KilotonnesOfTNTToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * KilotonnesOfTNTToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * KilotonnesOfTNTToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * KilotonnesOfTNTToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * KilotonnesOfTNTToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * KilotonnesOfTNTToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * KilotonnesOfTNTToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * KilotonnesOfTNTToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * KilotonnesOfTNTToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * KilotonnesOfTNTToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * KilotonnesOfTNTToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * KilotonnesOfTNTToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * KilotonnesOfTNTToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * KilotonnesOfTNTToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * KilotonnesOfTNTToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * KilotonnesOfTNTToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//MEGATONNES OF TNT
      case 'Megatonnes of TNT':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * MegatonnesOfTNTToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * MegatonnesOfTNTToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * MegatonnesOfTNTToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * MegatonnesOfTNTToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * MegatonnesOfTNTToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * MegatonnesOfTNTToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * MegatonnesOfTNTToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * MegatonnesOfTNTToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * MegatonnesOfTNTToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * MegatonnesOfTNTToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * MegatonnesOfTNTToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * MegatonnesOfTNTToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * MegatonnesOfTNTToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * MegatonnesOfTNTToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * MegatonnesOfTNTToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * MegatonnesOfTNTToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * MegatonnesOfTNTToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * MegatonnesOfTNTToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * MegatonnesOfTNTToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * MegatonnesOfTNTToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue;
            break;
          case 'Ergs':
            toValue = fromValue * MegatonnesOfTNTToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * MegatonnesOfTNTToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * MegatonnesOfTNTToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * MegatonnesOfTNTToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * MegatonnesOfTNTToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//ERGS
      case 'Ergs':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * ErgsToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * ErgsToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * ErgsToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * ErgsToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * ErgsToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * ErgsToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * ErgsToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * ErgsToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * ErgsToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * ErgsToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * ErgsToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * ErgsToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * ErgsToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * ErgsToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * ErgsToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * ErgsToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * ErgsToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * ErgsToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * ErgsToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * ErgsToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * ErgsToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue;
            break;
          case 'Electronvolt':
            toValue = fromValue * ErgsToElectronvolt;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * ErgsToKiloelectronvolt;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * ErgsToMegaelectronvolt;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * ErgsToGigaelectronvolt;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//ELECTRONVOLT
      case 'Electronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * ElectronvoltToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * ElectronvoltToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * ElectronvoltToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * ElectronvoltToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * ElectronvoltToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * ElectronvoltToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * ElectronvoltToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * ElectronvoltToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * ElectronvoltToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * ElectronvoltToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * ElectronvoltToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * ElectronvoltToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * ElectronvoltToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * ElectronvoltToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * ElectronvoltToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * ElectronvoltToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * ElectronvoltToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * ElectronvoltToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * ElectronvoltToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * ElectronvoltToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * ElectronvoltToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * ElectronvoltToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue / 1000;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * 0.000001;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue / 1000000000;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOELECTRONVOLT
      case 'Kiloelectronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * KiloelectronvoltToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * KiloelectronvoltToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * KiloelectronvoltToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * KiloelectronvoltToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * KiloelectronvoltToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * KiloelectronvoltToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * KiloelectronvoltToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * KiloelectronvoltToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * KiloelectronvoltToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * KiloelectronvoltToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * KiloelectronvoltToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * KiloelectronvoltToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * KiloelectronvoltToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * KiloelectronvoltToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * KiloelectronvoltToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * KiloelectronvoltToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * KiloelectronvoltToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * KiloelectronvoltToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * KiloelectronvoltToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * KiloelectronvoltToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * KiloelectronvoltToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * KiloelectronvoltToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * 1000;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue / 1000;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * 0.000001;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
//MEGAELECTRONVOLT
      case 'Megaelectronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * MegaelectronvoltToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * MegaelectronvoltToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * MegaelectronvoltToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * MegaelectronvoltToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * MegaelectronvoltToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * MegaelectronvoltToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * MegaelectronvoltToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * MegaelectronvoltToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * MegaelectronvoltToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * MegaelectronvoltToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * MegaelectronvoltToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * MegaelectronvoltToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * MegaelectronvoltToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * MegaelectronvoltToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * MegaelectronvoltToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * MegaelectronvoltToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * MegaelectronvoltToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * MegaelectronvoltToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * MegaelectronvoltToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * MegaelectronvoltToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * MegaelectronvoltToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * MegaelectronvoltToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * 1000000;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * 1000;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue * 0.001;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//GIGAELECTRONVOLT
      case 'Gigaelectronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            toValue = fromValue * GigaelectronvoltToKilojoules;
            break;
          case 'Joules':
            toValue = fromValue * GigaelectronvoltToJoules;
            break;
          case 'Nanojoules':
            toValue = fromValue * GigaelectronvoltToNanojoules;
            break;
          case 'Microjoules':
            toValue = fromValue * GigaelectronvoltToMicrojoules;
            break;
          case 'Millijoules':
            toValue = fromValue * GigaelectronvoltToMillijoules;
            break;
          case 'Megajoules':
            toValue = fromValue * GigaelectronvoltToMegajoules;
            break;
          case 'Newton-metres':
            toValue = fromValue * GigaelectronvoltToNewtonMetres;
            break;
          case 'Watt-hours':
            toValue = fromValue * GigaelectronvoltToWattHours;
            break;
          case 'Kilowatt-hours':
            toValue = fromValue * GigaelectronvoltToKilowattHours;
            break;
          case 'Megawatt-hours':
            toValue = fromValue * GigaelectronvoltToMegawattHours;
            break;
          case 'Calories':
            toValue = fromValue * GigaelectronvoltToCalories;
            break;
          case 'Kilocalories':
            toValue = fromValue * GigaelectronvoltToKilocalories;
            break;
          case 'Foot-pounds Force':
            toValue = fromValue * GigaelectronvoltToFootPoundsForce;
            break;
          case 'British Thermal Units (ISO)':
            toValue = fromValue * GigaelectronvoltToBritishThermalUnitsISO;
            break;
          case 'Therms':
            toValue = fromValue * GigaelectronvoltToTherms;
            break;
          case 'Horsepower Hours':
            toValue = fromValue * GigaelectronvoltToHorsepowerHours;
            break;
          case 'Barrels of Oil Equivalent':
            toValue = fromValue * GigaelectronvoltToBarrelsOfOilEquivalent;
            break;
          case 'Tonnes of Oil Equivalent':
            toValue = fromValue * GigaelectronvoltToTonnesOfOilEquivalent;
            break;
          case 'Tonnes of TNT':
            toValue = fromValue * GigaelectronvoltToTonnesOfTNT;
            break;
          case 'Kilotonnes of TNT':
            toValue = fromValue * GigaelectronvoltToKilotonnesOfTNT;
            break;
          case 'Megatonnes of TNT':
            toValue = fromValue * GigaelectronvoltToMegatonnesOfTNT;
            break;
          case 'Ergs':
            toValue = fromValue * GigaelectronvoltToErgs;
            break;
          case 'Electronvolt':
            toValue = fromValue * 1000000000;
            break;
          case 'Kiloelectronvolt':
            toValue = fromValue * 1000000;
            break;
          case 'Megaelectronvolt':
            toValue = fromValue * 1000;
            break;
          case 'Gigaelectronvolt':
            toValue = fromValue;
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
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
//NANOJOULES
      case 'Nanojoules':
        switch (toUnit) {
          case 'Nanojoules':
            formula = 'The value remains unchanged';
            break;
          case 'Microjoules':
            formula = 'Divide the energy value by 1000';
            break;
          case 'Millijoules':
            formula = 'Multiply the energy value by 1e-6';
            break;
          case 'Joules':
            formula = 'Divide the energy value by 1e-9';
            break;
          case 'Kilojoules':
            formula = 'Divide the energy value by 1e-12';
            break;
          case 'Megajoules':
            formula = 'Divide the energy value by 1e-15';
            break;
          case 'Newton-metres':
            formula = 'Divide the energy value by 1e-9';
            break;
          case 'Watt-hours':
            formula = 'Divide the energy value by 3,6e+12';
            break;
          case 'Kilowatt-hours':
            formula = 'Divide the energy value by 3,6e+15';
            break;
          case 'Megawatt-hours':
            formula = 'Divide the energy value by 3,6e+18';
            break;
          case 'Calories':
            formula = 'Divide the energy value by 4,184e+9';
            break;
          case 'Kilocalories':
            formula = 'Divide the energy value by 4,184e+12';
            break;
          case 'Foot-pounds Force':
            formula = 'Divide the energy value by  1,356e+6';
            break;
          case 'British Thermal Units (ISO)':
            formula = 'Divide the energy value by 1,055e+9';
            break;
          case 'Therms':
            formula = 'Divide the energy value by 1,055e+14';
            break;
          case 'Horsepower Hours':
            formula = 'Multiply the energy value by 3.7250614122937e-16';
            break;
          case 'Barrels of Oil Equivalent':
            formula = 'Divide the energy value by 6,118e+18';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = 'Divide the energy value by 4,187e+19';
            break;
          case 'Tonnes of TNT':
            formula = 'Divide the energy value by 4,184e+18';
            break;
          case 'Kilotonnes of TNT':
            formula = 'Divide the energy value by 4,184e+21';
            break;
          case 'Megatonnes of TNT':
            formula = 'Divide the energy value by 4,184e+24';
            break;
          case 'Ergs':
            formula = 'Divide the energy value by 100';
            break;
          case 'Electronvolt':
            formula = 'Multiply the energy value by 6,242e+9';
            break;
          case 'Kiloelectronvolt':
            formula = 'Multiply the energy value by 6241509.074461';
            break;
          case 'Megaelectronvolt':
            formula = 'Multiply the energy value by 6242';
            break;
          case 'Gigaelectronvolt':
            formula = 'Multiply the energy value by 6.24151';
            break;
          default:
            throw 'Unknown formula: $toUnit';
        }
        break;

//MICROJOULES
      case 'Microjoules':
        switch (toUnit) {
          case 'Microjoules':
            formula = '';
            break;

          case 'Nanojoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Kilojoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//MILLIJOULES
      case 'Millijoules':
        switch (toUnit) {
          case 'Millijoules':
            formula = '';
            break;

          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Kilojoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//JOULES
      case 'Joules':
        switch (toUnit) {
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Kilojoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOJOULES
      case 'Kilojoules':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;

          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//MEGAJOULES
      case 'Megajoules':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//NEWTON METRES
      case 'Newton-metres':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//WATTHOURS
      case 'Watt-hours':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOWATT HOURS
      case 'Kilowatt-hours':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
//MEGAWATT HOURS
      case 'Megawatt-hours':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//CALORIES
      case 'Calories':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOCALORIES
      case 'Kilocalories':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//FOOTPOUNDS FORCE
      case 'Foot-pounds Force':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//BRITISH THERMAL UNITS ISO
      case 'British Thermal Units (ISO)':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//THERMS
      case 'Therms':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//HORSEPOWER HOURS
      case 'Horsepower Hours':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//BARRELS OF OIL EQUIVALENT
      case 'Barrels of Oil Equivalent':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//TONS OF OIL EQUIVALENT
      case 'Tonnes of Oil Equivalent':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//TONNES OF TNT
      case 'Tonnes of TNT':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOTONNES
      case 'Kilotonnes of TNT':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//MEGATONNES OF TNT
      case 'Megatonnes of TNT':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//ERGS
      case 'Ergs':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//ELECTRONVOLT
      case 'Electronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//KILOELECTRONVOLT
      case 'Kiloelectronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }
//MEGAELECTRONVOLT
      case 'Megaelectronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
            break;
          default:
            throw Exception('Unknown unit: $toUnit');
        }

//GIGAELECTRONVOLT
      case 'Gigaelectronvolt':
        switch (toUnit) {
          case 'Kilojoules':
            formula = '';
            break;
          case 'Joules':
            formula = '';
            break;
          case 'Nanojoules':
            formula = '';
            break;
          case 'Microjoules':
            formula = '';
            break;
          case 'Millijoules':
            formula = '';
            break;
          case 'Megajoules':
            formula = '';
            break;
          case 'Newton-metres':
            formula = '';
            break;
          case 'Watt-hours':
            formula = '';
            break;
          case 'Kilowatt-hours':
            formula = '';
            break;
          case 'Megawatt-hours':
            formula = '';
            break;
          case 'Calories':
            formula = '';
            break;
          case 'Kilocalories':
            formula = '';
            break;
          case 'Foot-pounds Force':
            formula = '';
            break;
          case 'British Thermal Units (ISO)':
            formula = '';
            break;
          case 'Therms':
            formula = '';
            break;
          case 'Horsepower Hours':
            formula = '';
            break;
          case 'Barrels of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of Oil Equivalent':
            formula = '';
            break;
          case 'Tonnes of TNT':
            formula = '';
            break;
          case 'Kilotonnes of TNT':
            formula = '';
            break;
          case 'Megatonnes of TNT':
            formula = '';
            break;
          case 'Ergs':
            formula = '';
            break;
          case 'Electronvolt':
            formula = '';
            break;
          case 'Kiloelectronvolt':
            formula = '';
            break;
          case 'Megaelectronvolt':
            formula = '';
            break;
          case 'Gigaelectronvolt':
            formula = '';
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
                    'Convert Energy',
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
      case 'Nanojoules':
        return 'nJ';
      case 'Microjoules':
        return 'µJ';
      case 'Millijoules':
        return 'mJ';
      case 'Joules':
        return 'J';
      case 'Kilojoules':
        return 'kJ';
      case 'Megajoules':
        return 'MJ';
      case 'Newton-metres':
        return 'N⋅m';
      case 'Watt-hours':
        return 'Wh';
      case 'Kilowatt-hours':
        return 'kW⋅h';
      case 'Megawatt-hours':
        return 'MWh';
      case 'Calories':
        return 'cal';
      case 'Kilocalories':
        return 'kcal';
      case 'Foot-pounds Force':
        return 'ft⋅lbf';
      case 'British Thermal Units (ISO)':
        return 'BTU';
      case 'Therms':
        return 'thm';
      case 'Horsepower Hours':
        return 'hp⋅h';
      case 'Barrels of Oil Equivalent':
        return 'BOE';
      case 'Tonnes of Oil Equivalent':
        return 'toe';
      case 'Tonnes of TNT':
        return 'ton of TNT';
      case 'Kilotonnes of TNT':
        return 'KT TNT';
      case 'Megatonnes of TNT':
        return 'MT TNT';
      case 'Ergs':
        return 'erg';
      case 'Electronvolt':
        return 'eV';
      case 'Kiloelectronvolt':
        return 'keV';
      case 'Megaelectronvolt':
        return 'MeV';
      case 'Gigaelectronvolt':
        return 'GeV';
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
      'Nanojoules',
      'Microjoules',
      'Millijoules',
      'Joules',
      'Kilojoules',
      'Megajoules',
      'Newton-metres',
      'Watt-hours',
      'Kilowatt-hours',
      'Megawatt-hours',
      'Calories',
      'Kilocalories',
      'Foot-pounds Force',
      'British Thermal Units (ISO)',
      'Therms',
      'Horsepower Hours',
      'Barrels of Oil Equivalent',
      'Tonnes of Oil Equivalent',
      'Tonnes of TNT',
      'Kilotonnes of TNT',
      'Megatonnes of TNT',
      'Ergs',
      'Electronvolt',
      'Kiloelectronvolt',
      'Megaelectronvolt',
      'Gigaelectronvolt',
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

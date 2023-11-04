// ignore_for_file: library_private_types_in_public_api
import 'dart:io';

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

  @override
  void initState() {
    super.initState();
    // Add the convert function as a listener to both text controllers.
    fromController.addListener(convert);
    toController.addListener(convert);
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
    // Check if the text in fromController is not empty and is a valid number before converting
    if (fromController.text.isEmpty) return;
    var fromValue = double.tryParse(fromController.text);
    if (fromValue == null)
      return; // Could not parse the number, handle this case appropriately.

    double toValue;

    if (fromUnit == 'Meters' && toUnit == 'Centimeters') {
      // If converting from Meters to Centimeters, multiply by 100
      toValue = fromValue * 100;
    } else if (fromUnit == 'Centimeters' && toUnit == 'Meters') {
      // If converting from Centimeters to Meters, divide by 100
      toValue = fromValue / 100;
    } else {
      // If neither Meters nor Centimeters is selected, do not convert
      // You will later add more conditions here for other units
      return;
    }

    // Update the 'to' field with the converted value
    // Ensure that you update the UI on the main thread
    setState(() {
      toController.text = toValue
          .toStringAsFixed(2); // Formats the number to have 2 decimal places
    });
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
    });
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
                      color: Colors.lightBlue,
                      size: 40,
                    ), // Size increased
                    onPressed: swapUnits,
                  ),
                  _buildUnitColumn('To', toController, toUnit, toPrefix,
                      false), // for 'To' column
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Conversion formula will be displayed here',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
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
            onSubmitted: (value) => convert(), // <-- Add this line
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              // Removed prefix from labelText
              labelText: label,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              // Removed floatingLabelBehavior as we are no longer using the label as a prefix
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              isDense: true,
              // Add a prefix Text widget with the prefix variable
              prefix: Text('$prefix ',
                  style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
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
        child: Text(
          '${_getPrefix(value)} - $value', // '$value${_getPrefix(value)}-', // Swap these to put prefix before unit name
          style: const TextStyle(
            color: Color(0xFF9CC0C5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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

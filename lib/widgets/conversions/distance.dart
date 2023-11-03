// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DistanceUnitConverter extends StatefulWidget {
  const DistanceUnitConverter({super.key});

  @override
  _DistanceUnitConverterState createState() => _DistanceUnitConverterState();
}

class _DistanceUnitConverterState extends State<DistanceUnitConverter> {
  String fromUnit = 'Meters';
  String toUnit = 'Centimeters';
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
// This variable will hold the current prefix icon or text, it starts with an icon.
  Widget _fromPrefix = const Icon(Icons.line_weight);
  Widget _toPrefix = const Icon(Icons.line_weight);

  void convert() {
    // Conversion logic will go here
    // Update `toValue` based on `fromValue` and selected units
  }

  void swapUnits() {
    setState(() {
      String tempUnit = fromUnit;
      String tempValue = fromController.text;

      fromUnit = toUnit;
      fromController.text = toController.text;

      toUnit = tempUnit;
      toController.text = tempValue;

      convert();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464648),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Text(
              'Convert Distance',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50), // Adjust space as needed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUnitColumn('From', fromController, fromUnit,
                    true), // for 'From' column
                IconButton(
                  icon: const Icon(
                      Icons
                          .swap_horiz, // Changed to swap_vert for a more intuitive design
                      color: Colors.lightBlue,
                      size: 40), // Size increased
                  onPressed: swapUnits,
                ),
                _buildUnitColumn(
                    'To', toController, toUnit, false), // for 'To' column
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Conversion formula will be displayed here',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  // This method will help to determine the prefix based on the unit
  Widget _getPrefix(String unit) {
    switch (unit) {
      case 'Meters':
        return const Text('M',
            style: TextStyle(fontSize: 18.0)); // Just an example icon
      case 'Centimeters':
        return const Text('CM',
            style: TextStyle(fontSize: 18.0)); // Example text
      // Add other cases for different units with different icons or text
      default:
        return const Icon(Icons.line_weight); // Default icon
    }
  }

  Widget _buildUnitColumn(String label, TextEditingController controller,
      String unit, bool isFrom) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: label,
              prefixIcon:
                  isFrom ? _fromPrefix : _toPrefix, // Use respective prefix
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              isDense: true,
            ),
          ),
          _buildDropdownButton(label.toLowerCase(), unit,
              isFrom), // Pass the 'isFrom' flag // Pass the 'isFrom' flag
        ],
      ),
    );
  }

  // Correct the method signature by adding the isFrom parameter
  Widget _buildDropdownButton(String type, String currentValue, bool isFrom) {
    final items = <String>[
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
      'Parsecs'
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: const TextStyle(
            color: Color(0xFF9CC0C5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
    }).toList();

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
      icon: const Icon(Icons.arrow_downward, color: Colors.white, size: 30),
      elevation: 16,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          if (isFrom) {
            fromUnit = newValue!;
            fromController.clear();
            _fromPrefix = _getPrefix(
                newValue); // Update the prefix for the 'from' TextField
          } else {
            toUnit = newValue!;
            toController.clear();
            _toPrefix = _getPrefix(
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

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DistanceUnitConverter extends StatefulWidget {
  const DistanceUnitConverter({super.key});

  @override
  _DistanceUnitConverterState createState() => _DistanceUnitConverterState();
}

class _DistanceUnitConverterState extends State<DistanceUnitConverter> {
  String fromUnit = 'meters';
  String toUnit = 'centimeters';
  String fromValue = '';
  String toValue = '';
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  void convert() {
    // Conversion logic will go here
    // Update `toValue` based on `fromValue` and selected units
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distance Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Convert Distance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildDropdownButton('from', fromUnit),
                Expanded(
                  child: TextField(
                    controller: fromController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      fromValue = value;
                      convert();
                    },
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildDropdownButton('to', toUnit),
                Expanded(
                  child: TextField(
                    controller: toController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      toValue = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Conversion formula will be displayed here',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton(String type, String currentValue) {
    final items = [
      'picometers',
      'nanometers',
      'micrometers',
      'millimeters',
      'centimeters',
      'meters',
      'kilometers',
      'angstrom',
      'thou',
      'inches',
      'feet',
      'yards',
      'chains',
      'furlongs',
      'miles',
      'fathoms',
      'cables',
      'nautical miles',
      'astronomical units',
      'light years',
      'parsecs'
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return DropdownButton<String>(
      value: currentValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          if (type == 'from') {
            fromUnit = newValue!;
          } else {
            toUnit = newValue!;
          }
          convert();
        });
      },
      items: items,
    );
  }
}

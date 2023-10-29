// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hapticFeedback = false;
  bool pointSelected = true;
  bool commaSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin:
            const EdgeInsets.symmetric(horizontal: 20), // Set the margin here
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 30),
            const Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.grey,
                )
              ],
            ),

            const SizedBox(height: 50),
            // Settings UI
            SwitchListTile(
              title: const Text(
                'Button Haptic Feedback',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              value: hapticFeedback,
              onChanged: (bool value) {
                setState(() {
                  hapticFeedback = value;
                });
              },
              secondary: const Icon(Icons.touch_app, size: 38),
              subtitle: const Text(
                'Enable or disable haptic feedback for the buttons',
                style: TextStyle(color: Colors.white70),
              ),
              isThreeLine: true,
              dense: false,
              contentPadding: const EdgeInsets.all(8),
              activeColor: Colors.lightBlue,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.5),
              activeTrackColor: Colors.lightBlue.withOpacity(0.5),
              tileColor: Colors.grey[850],
              selected: hapticFeedback,
              selectedTileColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              autofocus: false,
              visualDensity: VisualDensity.comfortable,
            ),
            const SizedBox(height: 25),
            // Decimal Separator Settings
            const Text(
              'Choose Decimal Separator:',
              style: TextStyle(fontSize: 17, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildSwitchListTile(
              'Point',
              'As the decimal separator                        For example 3.1416',
              pointSelected,
              Icon(Icons.circle,
                  size: 30,
                  color:
                      pointSelected ? const Color(0xFF03A9F4) : Colors.white),
              (bool value) {
                setState(() {
                  if (value) {
                    pointSelected = true;
                    commaSelected = false;
                  }
                });
              },
            ),
            buildSwitchListTile(
              'Comma',
              'As the decimal separator                        For example 3,1416',
              commaSelected,
              Image.asset(
                commaSelected
                    ? 'assets/images/commaAzul.png'
                    : 'assets/images/comma.png',
                width: 30,
                height: 30,
                color: Colors.white,
              ),
              (bool value) {
                setState(() {
                  if (value) {
                    pointSelected = false;
                    commaSelected = true;
                  }
                });
              },
            ),
            const SizedBox(height: 25),
            // Add other UI components for different settings here
          ],
        ),
      ),
    );
  }

  SwitchListTile buildSwitchListTile(String title, String subtitle, bool value,
      Widget secondaryWidget, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      value: value,
      onChanged: onChanged,
      secondary: secondaryWidget,
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70),
      ),
      isThreeLine: true,
      dense: false,
      contentPadding: const EdgeInsets.all(8),
      activeColor: Colors.lightBlue,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.white.withOpacity(0.5),
      activeTrackColor: Colors.lightBlue.withOpacity(0.5),
      tileColor: Colors.grey[850],
      selected: value,
      selectedTileColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      controlAffinity: ListTileControlAffinity.trailing,
      autofocus: false,
      visualDensity: VisualDensity.comfortable,
    );
  }
}

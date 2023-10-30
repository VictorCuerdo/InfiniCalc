// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinicalc/controllers/font_size_provider.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import the required packages at the beginning of your file

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hapticFeedback = false;
  bool pointSelected = true;
  bool commaSelected = false;
  bool statusBarVisible = true;
  static const double smallFontSize = 14.0;
  static const double mediumFontSize = 18.0;
  static const double largeFontSize = 22.0;

  // Class variable to store the current font size
  double fontSize = mediumFontSize;

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fontSize = (prefs.getDouble('fontSize') ?? mediumFontSize);
    });
  }

  _saveFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', fontSize);
  }

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
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.navigateTo('/');
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            // NUMBER FORMATING ROW********
            // Decimal Separator Settings
            const Text(
              'Pick decimal separator:',
              style: TextStyle(fontSize: 17, color: Colors.white),
              textAlign: TextAlign.left,
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
            const SizedBox(height: 5),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(height: 5),

            // Settings UI
            // STATUS BAR ROW
            SwitchListTile(
              title: const Text(
                'Status bar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              value: statusBarVisible,
              onChanged: (bool value) {
                setState(() {
                  statusBarVisible = value;
                  SystemChrome.setEnabledSystemUIMode(
                      value
                          ? SystemUiMode.immersiveSticky
                          : SystemUiMode.manual,
                      overlays: value ? [] : SystemUiOverlay.values);
                });
              },
              secondary: const Icon(Icons.sim_card, size: 38),
              subtitle: const Text(
                'Enable or disable visibility of status bar',
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
              selected: statusBarVisible,
              selectedTileColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              autofocus: false,
              visualDensity: VisualDensity.comfortable,
            ),
            const SizedBox(height: 5),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(height: 5),

            // HAPTIC BUTTON ROW
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

            // Font Size Setting
            const SizedBox(height: 5),
            const Divider(color: Colors.white, thickness: 2),
            const SizedBox(height: 5),
            ListTile(
              title: Text(
                'Font Size',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize), // Use the dynamic font size here
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.text_fields, size: 20),
                    color: fontSize == smallFontSize
                        ? Colors.lightBlue
                        : Colors.white,
                    onPressed: () {
                      setState(() {
                        fontSize = smallFontSize;
                        _saveFontSize();
                      });
                      // Update the provider value
                      Provider.of<FontSizeProvider>(context, listen: false)
                          .fontSize = smallFontSize;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.text_fields, size: 30),
                    color: fontSize == mediumFontSize
                        ? Colors.lightBlue
                        : Colors.white,
                    onPressed: () {
                      setState(() {
                        fontSize = mediumFontSize;
                        _saveFontSize();
                      });
                      // Update the provider value
                      Provider.of<FontSizeProvider>(context, listen: false)
                          .fontSize = mediumFontSize;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.text_fields, size: 40),
                    color: fontSize == largeFontSize
                        ? Colors.lightBlue
                        : Colors.white,
                    onPressed: () {
                      setState(() {
                        fontSize = largeFontSize;
                        _saveFontSize();
                      });
                      // Update the provider value
                      Provider.of<FontSizeProvider>(context, listen: false)
                          .fontSize = largeFontSize;
                    },
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.all(8),
              tileColor: Colors.grey[850],
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.white, thickness: 2),
            const SizedBox(height: 5),
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

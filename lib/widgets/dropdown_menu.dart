import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';
import 'package:provider/provider.dart';

import '/controllers/font_size_provider.dart';

class DropdownMenu extends StatelessWidget {
  final void Function(Color) onColorSelected;
  final void Function() onSettingsSelected;
  final void Function() onHistorySelected;
  final void Function() onHelpSelected;
  final void Function() onShareSelected;
  final VoidCallback closeDropdown;

  const DropdownMenu({
    super.key,
    required this.onColorSelected,
    required this.onSettingsSelected,
    required this.onHistorySelected,
    required this.onHelpSelected,
    required this.onShareSelected,
    required this.closeDropdown,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.palette,
            label: 'Theme Color',
            onTap: () => _selectColor(context),
            fontSize: fontSize,
          ),
          _buildMenuItem(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {
              closeDropdown();
              context.navigateTo('/settings');
            },
            fontSize: fontSize,
          ),
          _buildMenuItem(
            icon: Icons.history,
            label: 'History',
            onTap: () {
              closeDropdown();
              context.navigateTo('/history');
            },
            fontSize: fontSize,
          ),
          _buildMenuItem(
            icon: Icons.help,
            label: 'Help',
            onTap: () {
              closeDropdown();
              context.navigateTo('/help');
            },
            fontSize: fontSize,
          ),
          _buildMenuItem(
            icon: Icons.share,
            label: 'Share the App',
            onTap: () {
              closeDropdown();
              _shareApp(context);
            },
            fontSize: fontSize,
          ),
        ],
      ),
    );
  }

  void _selectColor(BuildContext context) {
    Color selectedColor = Colors.blue; // Initial color for the picker
    closeDropdown(); // Close the dropdown before showing the color picker

    // Define your own colors
    List<Color> customColors = [
      const Color(0xFF1B2B34),
      const Color(0xFF2E4057),
      const Color(0xFF35424D),
      const Color(0xFF233D4D),
      const Color(0xFF1E434C),
      const Color(0xFF1B3A4B),
      const Color(0xFF325C74),
      const Color(0xFF274156),
      const Color(0xFF2F4454),
      const Color(0xFF1E3B49),
      const Color(0xFF2A2F36),
      const Color(0xFF364156),
      const Color(0xFF303B44),
      const Color(0xFF253341),
      const Color(0xFF38434E),
      const Color(0xFF313E48),
      const Color(0xFF2C3A47),
      const Color(0xFF1D2C33),
      const Color(0xFF2B3A42),
      const Color(0xFF35424A),
      const Color(0xFF2F343B),
      const Color(0xFF323F4F),
      const Color(0xFF293845),
      const Color(0xFF2C3E50),
      const Color(0xFFD4D4D2),
      const Color(0xFFA2BBCF),
      const Color(0xFF505050),
      const Color(0xFF142F44),
      const Color(0xFF1D3849),
      const Color(0xFF205B7A),
      const Color.fromARGB(255, 58, 41, 61),
      const Color(0xFFc2d4b1),
      const Color(0xFFa6b992),
      const Color(0xFF49a109),
      const Color(0xFF3E2723), // Dark brown
      const Color(0xFF4E342E), // Dark brown
      const Color(0xFF6D4C41), // Dark brown
      const Color(0xFFBF360C), // Dark orange
      const Color(0xFFD84315), // Dark orange
      const Color(0xFFFF9500),
      const Color(0xFFdd2d00),
      const Color(0xFFa17944),
      const Color(0xFFE64A19), // Dark orange
      const Color(0xFFEF6C00), // Dark orange
      const Color(0xFFF57C00), // Dark orange
      const Color(0xFFFF8F00), // Dark orange
      const Color(0xFFF9A825), // Dark yellow
      const Color(0xFFFDD835), // Dark yellow
      const Color(0xFFFFD600), // Dark yellow
      const Color(0xFFFFB300), // Dark yellow
      const Color(0xFFFF6F00), // Dark orange
      const Color(0xFFE65100), // Dark orange
      const Color(0xFFDD2C00), // Dark red
      const Color(0xFFBF360C), // Dark red
      const Color(0xFFB71C1C), // Dark red
      const Color(0xFFC62828), // Dark red
      const Color(0xFFD32F2F), // Dark red
      const Color(0xFFAD1457), // Dark red
      const Color(0xFF6A1B9A), // Dark purple
      const Color(0xFF4A148C), // Dark purple
      const Color(0xFF311B92), // Dark purple
      const Color(0xFFFFD700),
      Colors.black,
      Colors.white,
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ), */
          //shape: const CircleBorder(),

          shadowColor: Colors.black,
          scrollable: true,
          backgroundColor: Colors.white,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFF1B3A4B),
                width: 5.0,
              )),
          title: const Text(
            'Scroll and pick a color!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontSize: 20,
              color: Color(0xFF1B3A4B),
            ),
          ).tr(),
          content: SizedBox(
            height: 300, // or whatever height you want
            width:
                double.infinity, // Make sure the content takes the full width
            child: ScrollbarTheme(
              data: ScrollbarThemeData(
                thickness: MaterialStateProperty.all<double?>(20.0),
                thumbColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: selectedColor,
                    availableColors: customColors,
                    onColorChanged: (Color color) {
                      selectedColor = color;
                    },
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1B3A4B),
                ), // Set your desired text color
              ).tr(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Select',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1B3A4B),
                ), // Set your desired text color
              ).tr(),
              onPressed: () {
                onColorSelected(selectedColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double fontSize,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 32),
      title: Text(
        label.tr(), // Use .tr() to translate the label
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
      onTap: onTap,
    );
  }

  void _shareApp(BuildContext context) {
    String appLink =
        "https://play.google.com/store/apps/details?id=com.yourapp"; // Placeholder link

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFF1B3A4B),
                width: 5.0,
              )),
          title: const Text(
            'Share the App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ).tr(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 25),
              Image.asset(
                'assets/images/qrcode.png', // QR code image in assets
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 25),
              SelectableText(
                appLink,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ), // Making it selectable for easier copying
              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: appLink)).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      /*const SnackBar(
                        content: Text('Link copied to clipboard'),
                        duration: Duration(seconds: 3),
                      ), */
                      SnackBar(
                        content: const Text(
                          'Link copied to clipboard',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ).tr(),
                        backgroundColor: const Color(
                            0xFF1B3A4B), // Change the background color of the SnackBar
                        duration: const Duration(
                            seconds: 3), // How long the SnackBar will be shown
                        margin: const EdgeInsets.all(
                            10), // Outer margin of the SnackBar
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20), // Inner padding of the SnackBar
                        behavior: SnackBarBehavior
                            .floating, // Makes SnackBar floating above the bottom of the screen
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Rounded corners for the SnackBar
                        ),
                        elevation: 6.0, // The elevation of the SnackBar
                      ), // The width of the SnackBar. This is useful when behavior is floating
                    );
                  });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                child: const Text(
                  'Copy Link',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ).tr(),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 18),
              ).tr(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

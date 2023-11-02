import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/controllers/font_size_provider.dart';

class DropdownMenuFormat extends StatelessWidget {
  final VoidCallback closeDropdown;

  const DropdownMenuFormat({Key? key, required this.closeDropdown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;
    return SizedBox(
      height: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: const Color(0xFF464648),
            width: double
                .infinity, // This should make it stretch across the screen
            padding:
                const EdgeInsets.only(left: 20, right: 35, top: 8, bottom: 8),
            child: Text(
              'Select Result Format',
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20,
                  right: 35), // Reapply padding here for the other items
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildSingleItem(context, "Decimal", "0", fontSize),
                  _buildSingleItem(context, "Expression", "0", fontSize),
                  _buildSingleItem(context, "Mixed number", "", fontSize),
                  _buildSingleItem(
                      context, "Degrees, mins, secs", "0-0-0", fontSize),
                  _buildSingleItem(
                      context, "Polar coordinates", "0 <0", fontSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleItem(
      BuildContext context, String text1, String text2, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text1,
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
          ),
          Text(
            text2,
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}

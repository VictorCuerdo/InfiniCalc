// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/controllers/font_size_provider.dart';

class MatrixMenus extends StatefulWidget {
  final VoidCallback closeDropdown;

  const MatrixMenus({Key? key, required this.closeDropdown}) : super(key: key);

  @override
  _MatrixMenusState createState() => _MatrixMenusState();
}

class _MatrixMenusState extends State<MatrixMenus> {
  String? selectedLabel;

  // The labels as you provided.
  final List<String> buttonLabels = [
    "ident",
    "det",
    "trac",
    "rank",
    "[ ]^T",
    "[ ]^-1",
    "lu",
    "rRed",
    "minor",
    "cof",
    "adjug",
    "[ ]^H",
    "A⊙B",
    "A⊗B",
    "chPol",
    "eiVal",
    "eiVec",
    "diag",
    "A⋅B",
    "A×B",
    "eDist",
    "norm"
  ];

  final List<String> rightColumnLabels = [
    "Identity",
    "Determinant",
    "Trace",
    "Rank",
    "Transpose",
    "Inverse",
    "LU Decomposition",
    "Reduced Row Echelon Form",
    "Minors",
    "Cofactors",
    "Adjugate",
    "Conjugate Transpose",
    "Hadamard Product",
    "Kronecker Product",
    "Characteristic Polynomial",
    "Eigen Values",
    "Eigen Vectors",
    "Diagonalization",
    "Dot Product",
    "Cross Product",
    "Euclidean Distance",
    "Normalize"
  ];

  @override
  Widget build(BuildContext context) {
    // Retrieve the original font size from the provider.
    double originalFontSize = Provider.of<FontSizeProvider>(context).fontSize;

    // Scale down the font size for the list items.
    double scaledFontSize = originalFontSize * 0.9;

    // Adjust the height of each row based on the scaled font size.
    double rowHeight = scaledFontSize * 4;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9, // Adjusted height
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: const Color(0xFF464648),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Matrices and Vectors',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: scaledFontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: buttonLabels.length +
                  3, // Total rows including title and divider
              itemBuilder: (context, index) {
                if (index == 18) {
                  // The divider after the 18th item
                  return const Divider(
                    color: Colors.white,
                    thickness: 2,
                  );
                } else if (index > 18) {
                  // Adjust the index to account for the additional divider row
                  index -= 1;
                }

                // Now, if index is less than buttonLabels.length, proceed to build the button row.
                if (index < buttonLabels.length) {
                  String buttonText = buttonLabels[index];
                  String label = rightColumnLabels[index];
                  // Pass the rowHeight to the _buildButtonRow method to control the height of each row.
                  return _buildButtonRow(
                      context, buttonText, label, scaledFontSize, rowHeight);
                }

                // Return an empty container for indexes beyond the labels
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, String buttonText, String label,
      double fontSize, double rowHeight) {
    // Added rowHeight parameter
    bool isSuperscript = buttonText.contains("^");

    return GestureDetector(
      onTapDown: (_) => _handleTap(label, true),
      onTapUp: (_) => _handleTap(label, false),
      onTapCancel: () => _handleTap(label, false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: rowHeight, // Use the rowHeight for the height of the row
        decoration: BoxDecoration(
          color: selectedLabel == label ? Colors.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: isSuperscript
                    ? _buildSuperscriptText(buttonText, fontSize)
                    : Text(
                        buttonText,
                        style:
                            TextStyle(color: Colors.white, fontSize: fontSize),
                      ),
              ),
            ),
            const SizedBox(width: 10), // Space between the button and label
            Expanded(
              flex: 2, // Give more space to the right column if needed
              child: Text(
                label,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: fontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A helper method to handle tap events
  void _handleTap(String label, bool isDown) {
    setState(() {
      selectedLabel = isDown ? label : null;
    });
    if (!isDown) {
      // Do something when the button is pressed
      print("Button pressed: $label");
    }
  }

  Widget _buildSuperscriptText(String text, double fontSize) {
    List<String> parts = text.split('^');
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: fontSize),
        children: [
          TextSpan(text: parts[0]), // The base part
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: Transform.translate(
              offset: Offset(0, -fontSize * 0.4), // Adjust the position upwards
              child: Text(
                parts[1],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 0.7, // Smaller font size for superscript
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

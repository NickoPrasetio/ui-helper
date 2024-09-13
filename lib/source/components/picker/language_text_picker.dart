//
//  language_text_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class LanguageTextPicker extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;
  final String? selectedLanguage;
  final Map<String, String> languageCodes;
  final Map<String, Locale> languageLocaleCodes;
  final Function(Locale selectedLocale) onChanged;

  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;

  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const LanguageTextPicker({
    super.key,
    this.selectedLanguage,
    required this.languageCodes,
    required this.languageLocaleCodes,
    required this.onChanged,
    this.semanticsIdentifier,
    this.color = ColorPalette.textBlackColor,
    this.textAlign = TextAlign.left,
    this.fontSize = UIFont.h5,
    this.fontSystem = UIFontSystem.regular,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
  });

  // Widget Statte
  @override
  State<LanguageTextPicker> createState() => _LanguageTextPickerState();
}

class _LanguageTextPickerState extends State<LanguageTextPicker> {
  // Properties
  late String selectedLanguage;

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    selectedLanguage = widget.selectedLanguage ?? widget.languageCodes.keys.first;

    return Semantics(
      label: widget.semanticsIdentifier,
      excludeSemantics: true,
      child: DropdownButton<String>(
        value: selectedLanguage,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _onSelectionOf(newValue);
            });
          }
        },
        items: widget.languageCodes.keys.map<DropdownMenuItem<String>>((String value) {
          String keyValue = '${widget.languageCodes[value]}';

          return DropdownMenuItem<String>(
            value: value,
            child: AdaptiveText(
              semanticsIdentifier: '${widget.semanticsIdentifier}_$keyValue',
              text: value,
              color: widget.color,
              textAlign: widget.textAlign,
              fontSize: widget.fontSize,
              fontSystem: widget.fontSystem,
              desktopFactor: widget.desktopFactor,
              tabletFactor: widget.tabletFactor,
              mobileFactor: widget.mobileFactor,
              smallMobileFactor: widget.smallMobileFactor,
            ),
          );
        }).toList(),
      ),
    );
  }

  // Object Level Private Methods
  void _onSelectionOf(String value) {
    selectedLanguage = value;
    final selectedLanguageCode = widget.languageCodes[selectedLanguage];
    final selectedLocale = widget.languageLocaleCodes[selectedLanguageCode];
    if (selectedLocale != null) {
      widget.onChanged(selectedLocale);
    }
  }
}

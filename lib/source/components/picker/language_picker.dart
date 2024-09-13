//
//  language_widget_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class LanguagePicker extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;
  final String? selectedLanguageCode;
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
  const LanguagePicker({
    super.key,
    required this.languageLocaleCodes,
    required this.onChanged,
    this.selectedLanguageCode,
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

  // Widget State
  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  // Properties
  late String selectedLanguage;

  // Widget Methods
  @override
  void initState() {
    selectedLanguage = widget.selectedLanguageCode ?? widget.languageLocaleCodes.keys.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveDropDownButton(
      semanticsIdentifier: widget.semanticsIdentifier,
      items: widget.languageLocaleCodes.keys.map((String value) {
        String index = '${List.from(widget.languageLocaleCodes.keys).indexOf(value)}';

        return PopupMenuItem<String>(
          onTap: () {
            setState(() {
              _onSelectionOf(value);
            });
          },
          value: value,
          child: Semantics(
            label: '${widget.semanticsIdentifier}_$index',
            child: Row(children: [Text(value)]),
          ),
        );
      }).toList(),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: Icon(Icons.language, color: ColorPalette.blue),
          ),
          AdaptiveText(
            text: selectedLanguage,
            color: widget.color,
            textAlign: widget.textAlign,
            fontSize: widget.fontSize,
            fontSystem: widget.fontSystem,
            desktopFactor: widget.desktopFactor,
            tabletFactor: widget.tabletFactor,
            mobileFactor: widget.mobileFactor,
            smallMobileFactor: widget.smallMobileFactor,
          ),
          Icon(Icons.keyboard_arrow_down_sharp, color: widget.color, size: 20),
        ],
      ),
    );
  }

  // Object Level Private Methods
  void _onSelectionOf(String value) {
    selectedLanguage = value;
    final selectedLocale = widget.languageLocaleCodes[selectedLanguage];
    if (selectedLocale != null) {
      widget.onChanged(selectedLocale);
    }
  }
}

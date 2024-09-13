//
//  adaptive_radio_button_form_field.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 23/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

enum RadioLayoutDirection { vertical, horizontal }

class AdaptiveRadioButtonFormField extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;
  final AdaptiveText titleLabel;
  final Color unselectedColor;
  final Color selectedColor;
  final List<String> options;
  final String? initialValue;
  final int numberOfButtonsInRow;
  final double spaceBetweenButtons;
  final double buttonsLeftSpace;
  final double buttonsTopSpace;
  final ValueChanged<String>? onChanged;
  final RadioLayoutDirection layoutDirection;
  final bool disable;
  final Color optionTextColor;
  final double optionTextFontSize;
  final UIFontSystem optionTextFontSystem;

  // Class Constructor
  const AdaptiveRadioButtonFormField({
    super.key,
    this.semanticsIdentifier,
    required this.titleLabel,
    this.unselectedColor = ColorPalette.gray2,
    this.selectedColor = ColorPalette.blue,
    required this.options,
    this.initialValue,
    this.onChanged,
    required this.layoutDirection,
    this.spaceBetweenButtons = 16.0,
    this.numberOfButtonsInRow = 4,
    this.buttonsTopSpace = 2.0,
    this.buttonsLeftSpace = 16,
    this.disable = false,
    this.optionTextColor = ColorPalette.textBlackColor,
    this.optionTextFontSize = UIFont.h5,
    this.optionTextFontSystem = UIFontSystem.regular,
  });

  // Widget State
  @override
  State<AdaptiveRadioButtonFormField> createState() => _AdaptiveRadioButtonFormFieldState();
}

class _AdaptiveRadioButtonFormFieldState extends State<AdaptiveRadioButtonFormField> {
  // State Properties
  late String _selectedOption;

  // Widget Methods
  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue ?? widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.options.isEmpty) {
      return widget.titleLabel;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.titleLabel,
        SizedBox(height: widget.buttonsTopSpace),
        _buildRadioButtons(),
      ],
    );
  }

  // Object Level Private Methods
  Widget _buildRadioButtons() {
    switch (widget.layoutDirection) {
      case RadioLayoutDirection.vertical:
        return _buildVerticalRadioButtons();
      case RadioLayoutDirection.horizontal:
        return _buildHorizontalRadioButtons();
    }
  }

  /// Vertical Radio Buttons
  Widget _buildVerticalRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.options.length, (index) {
        return _buildOption(index);
      }),
    );
  }

  /// Horizontal Radio Buttons
  Widget _buildHorizontalRadioButtons() {
    List<String> options = List.from(widget.options);
    List<Widget> rows = [];
    int numOptions = options.length;
    int index = 0;

    while (numOptions > 0) {
      int numButtonsInCurrentRow =
          numOptions <= widget.numberOfButtonsInRow ? numOptions : widget.numberOfButtonsInRow;

      List<String> optionsInRow = options.sublist(index, index + numButtonsInCurrentRow);
      rows.add(
        Row(
          children: optionsInRow.map(
            (option) {
              return _buildOption(options.indexOf(option));
            },
          ).toList(),
        ),
      );

      numOptions -= numButtonsInCurrentRow;
      index += numButtonsInCurrentRow;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }

  Widget _buildOption(int index) {
    String option = widget.options[index];

    Widget radioButton;
    // if (!Device.isBrowser && Device.isIOS) {
    //   radioButton = CupertinoRadio<String>(
    //     value: option,
    //     groupValue: _selectedOption,
    //     onChanged: (value) {
    //       setState(() {
    //         _selectedOption = value!;
    //         if (widget.onChanged != null) {
    //           widget.onChanged!(value);
    //         }
    //       });
    //     },
    //   );
    // } else {
    radioButton = Radio<String>(
      fillColor: WidgetStateColor.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return widget.selectedColor;
          }
          return widget.unselectedColor;
        },
      ),
      value: option,
      groupValue: _selectedOption,
      onChanged: (value) {
        if (!widget.disable) {
          setState(() {
            _selectedOption = value!;
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          });
        }
      },
    );
    // }

    return Row(children: [
      SizedBox(width: widget.buttonsLeftSpace),
      radioButton,
      AdaptiveText(
        text: option,
        color: widget.optionTextColor,
        fontSize: widget.optionTextFontSize,
        fontSystem: widget.optionTextFontSystem,
      ),
      SizedBox(width: widget.spaceBetweenButtons),
    ]);
  }
}

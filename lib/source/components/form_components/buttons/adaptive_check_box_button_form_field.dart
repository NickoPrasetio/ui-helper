//
//  adaptive_check_box_button_form_field.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 23/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

enum CheckboxLayoutDirection { vertical, horizontal }

class AdaptiveCheckboxFormField extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;
  final AdaptiveText titleLabel;
  final Color unselectedBGColor;
  final Color unselectedColor;
  final Color selectedColor;
  final List<String> options;
  final List<String>? initialValues;
  final int numberOfButtonsInRow;
  final double spaceBetweenButtons;
  final double buttonsTopSpace;
  final ValueChanged<List<String>>? onChanged;
  final CheckboxLayoutDirection layoutDirection;
  final bool disable;
  final Color optionTextColor;
  final double optionTextFontSize;
  final UIFontSystem optionTextFontSystem;

  // Class Constructor
  const AdaptiveCheckboxFormField({
    super.key,
    this.semanticsIdentifier,
    required this.titleLabel,
    this.unselectedBGColor = ColorPalette.transparent,
    this.unselectedColor = ColorPalette.gray2,
    this.selectedColor = ColorPalette.blue,
    required this.options,
    this.initialValues,
    this.onChanged,
    required this.layoutDirection,
    this.spaceBetweenButtons = 8.0,
    this.numberOfButtonsInRow = 4,
    this.buttonsTopSpace = 8.0,
    this.disable = false,
    this.optionTextColor = ColorPalette.textBlackColor,
    this.optionTextFontSize = UIFont.h5,
    this.optionTextFontSystem = UIFontSystem.regular,
  });

  // Widget State
  @override
  State<AdaptiveCheckboxFormField> createState() => _AdaptiveCheckboxFormFieldState();
}

class _AdaptiveCheckboxFormFieldState extends State<AdaptiveCheckboxFormField> {
  // State Properties
  late List<String> _selectedOptions;

  // Widget Methods
  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.initialValues ?? [];
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
        _buildCheckboxButtons(),
      ],
    );
  }

  // Object Level Private Methods
  Widget _buildCheckboxButtons() {
    switch (widget.layoutDirection) {
      case CheckboxLayoutDirection.vertical:
        return _buildVerticalCheckboxButtons();
      case CheckboxLayoutDirection.horizontal:
        return _buildHorizontalCheckboxButtons();
    }
  }

  /// Vertical CheckBox Buttons
  Widget _buildVerticalCheckboxButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.options.length, (index) {
        return _buildOption(index);
      }),
    );
  }

  /// Horizontal CheckBox Buttons
  Widget _buildHorizontalCheckboxButtons() {
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
          children: optionsInRow.map((option) {
            return _buildOption(options.indexOf(option));
          }).toList(),
        ),
      );
      numOptions -= numButtonsInCurrentRow;
      index += numButtonsInCurrentRow;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _buildOption(int index) {
    String option = widget.options[index];
    return Row(
      children: [
        Checkbox(
          fillColor: WidgetStateColor.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return widget.selectedColor;
              }
              return widget.unselectedBGColor;
            },
          ),
          side: BorderSide(color: widget.unselectedColor),
          value: _selectedOptions.contains(option),
          onChanged: (checked) {
            if (!widget.disable) {
              setState(() {
                _selectedOptions = _updateSelectedOptions(option, checked);
                if (widget.onChanged != null) {
                  widget.onChanged!(_selectedOptions);
                }
              });
            }
          },
        ),
        AdaptiveText(
          text: option,
          color: widget.optionTextColor,
          fontSize: widget.optionTextFontSize,
          fontSystem: widget.optionTextFontSystem,
        ),
      ],
    );
  }

  List<String> _updateSelectedOptions(String option, bool? checked) {
    final List<String> updatedOptions = List.from(_selectedOptions);
    if (checked ?? false) {
      updatedOptions.add(option);
    } else {
      updatedOptions.remove(option);
    }
    return updatedOptions;
  }
}

//
//  month_year_picker.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 04/01/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearPicker extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;
  final DateTime? selectedValue;
  final String localeIdentifier;
  final int numberOfMonthsBackToShowFromNow;
  final Function(DateTime selectedValue) onChanged;

  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;

  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const MonthYearPicker({
    super.key,
    required this.onChanged,
    this.selectedValue,
    this.semanticsIdentifier,
    this.color = ColorPalette.textBlackColor,
    this.textAlign = TextAlign.left,
    this.fontSize = UIFont.h5,
    this.fontSystem = UIFontSystem.regular,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
    this.numberOfMonthsBackToShowFromNow = 100,
    this.localeIdentifier = 'en',
  });

  // Widget State
  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  // Properties
  late DateTime selectedValue;

  // Widget Methods
  @override
  void initState() {
    selectedValue = widget.selectedValue ?? _generateMonthList().first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> months = _generateMonthList();

    return AdaptiveDropDownButton(
      semanticsIdentifier: widget.semanticsIdentifier,
      items: months.map((DateTime value) {
        String displayValue = DateFormat(
          DateTimeFormat.fullMonthAndYear,
          widget.localeIdentifier,
        ).format(value);
        return PopupMenuItem<String>(
          onTap: () {
            setState(() {
              _onSelectionOf(value);
            });
          },
          value: displayValue,
          child: Row(children: [Text(displayValue)]),
        );
      }).toList(),
      child: Row(
        children: [
          AdaptiveText(
            text: DateFormat(
              Device.isSmallScreen(context)
                  ? DateTimeFormat.monthAndYear
                  : DateTimeFormat.fullMonthAndYear,
              widget.localeIdentifier,
            ).format(selectedValue),
            color: widget.color,
            textAlign: widget.textAlign,
            fontSize: widget.fontSize,
            fontSystem: widget.fontSystem,
            desktopFactor: widget.desktopFactor,
            tabletFactor: widget.tabletFactor,
            mobileFactor: widget.mobileFactor,
            smallMobileFactor: widget.smallMobileFactor,
          ),
          Icon(Icons.keyboard_arrow_down_sharp, color: widget.color, size: 22),
        ],
      ),
    );
  }

  // Object Level Private Methods
  void _onSelectionOf(DateTime value) {
    selectedValue = value;
    widget.onChanged(selectedValue);
  }

  List<DateTime> _generateMonthList() {
    final List<DateTime> months = [];
    DateTime currentDate = DateTime.now();

    for (int i = 0; i < widget.numberOfMonthsBackToShowFromNow; i++) {
      months.add(currentDate);
      currentDate = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    }

    return months;
  }
}

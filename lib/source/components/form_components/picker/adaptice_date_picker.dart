//
//  adaptice_date_picker.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 16/06/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:intl/intl.dart';

class AdaptiveDatePicker extends StatefulWidget {
  // Properties
  final void Function(DateTime selectedDate) onChanged;
  final String? semanticsIdentifier;

  final bool showTitle;
  final String titleText;
  final UIFontSystem titleFontSystem;
  final Color titleColor;

  final String dateFormat;
  final String localeIdentifier;
  final bool isMandatory;
  final DateTime? initialDate;
  final bool enabled;

  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;

  final bool showUnderline;
  final Color underlineColor;
  final Widget? prefix;
  final Widget? suffix;

  final IconData dropDownIcon;
  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const AdaptiveDatePicker({
    super.key,
    required this.onChanged,
    this.isMandatory = false,
    this.titleText = '',
    this.showTitle = true,
    this.titleFontSystem = UIFontSystem.regular,
    this.titleColor = ColorPalette.textBlackColor,
    this.semanticsIdentifier,
    this.color = ColorPalette.textBlackColor,
    this.textAlign = TextAlign.left,
    this.fontSize = UIFont.h5,
    this.fontSystem = UIFontSystem.regular,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
    this.dropDownIcon = Icons.keyboard_arrow_down_sharp,
    this.showUnderline = true,
    this.underlineColor = ColorPalette.gray2,
    this.dateFormat = DateTimeFormat.dateWithFullMonthSymbols,
    this.localeIdentifier = 'en',
    this.enabled = true,
    this.prefix,
    this.suffix,
    this.initialDate,
  });

  // Widget State
  @override
  State<AdaptiveDatePicker> createState() => _AdaptiveDatePickerState();
}

class _AdaptiveDatePickerState extends State<AdaptiveDatePicker> {
  // State Properties
  DateTime? _selectedDate;

  // Widget Methods
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    String labelText = widget.isMandatory ? '${widget.titleText}*' : widget.titleText;
    return AdaptiveTapGesture(
      semanticsIdentifier: widget.semanticsIdentifier,
      onTap: () {
        if (widget.enabled) {
          _selectDate(context);
        }
      },
      child: Row(
        children: [
          if (widget.prefix != null) widget.prefix!,
          if (widget.prefix != null) const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.showTitle)
                  AdaptiveText(
                    text: labelText,
                    fontSystem: widget.titleFontSystem,
                    color: widget.titleColor,
                  ),
                Row(
                  children: [
                    AdaptiveText(
                      text: _getLocalizedDateStrFrom(context),
                      color: widget.color,
                      textAlign: widget.textAlign,
                      fontSize: widget.fontSize,
                      fontSystem: widget.fontSystem,
                      desktopFactor: widget.desktopFactor,
                      tabletFactor: widget.tabletFactor,
                      mobileFactor: widget.mobileFactor,
                      smallMobileFactor: widget.smallMobileFactor,
                    ),
                    const Spacer(),
                    Icon(
                      widget.dropDownIcon,
                      color: widget.enabled ? widget.color : ColorPalette.gray3,
                      size: 24,
                    ),
                  ],
                ),
                if (widget.showUnderline)
                  Container(
                    height: 1,
                    color: widget.enabled ? widget.underlineColor : ColorPalette.gray3,
                  )
              ],
            ),
          ),
          if (widget.suffix != null) const SizedBox(width: 8),
          if (widget.suffix != null) widget.suffix!,
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      // Customize the date picker for different platforms
      // For example, you can customize the appearance for iOS and Android here
      // iOS date picker options:
      // iOSDatePickerMode.time (default), iOSDatePickerMode.date, iOSDatePickerMode.dateAndTime
      // Android date picker automatically adapts to the platform style
      // For web, a Material design date picker is used by default
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        widget.onChanged(picked);
      });
    }
  }

  String _getLocalizedDateStrFrom(BuildContext context) {
    if (_selectedDate != null) {
      return DateFormat(widget.dateFormat, widget.localeIdentifier).format(_selectedDate!);
    }
    return '';
  }
}

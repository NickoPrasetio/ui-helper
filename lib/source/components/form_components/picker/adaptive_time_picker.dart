//
//  adaptive_time_picker.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 16/06/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class AdaptiveTimePicker extends StatefulWidget {
  // Properties
  final void Function(String selectedTimeStr) onChanged;
  final String? semanticsIdentifier;
  final bool showTitle;
  final String titleText;
  final UIFontSystem titleFontSystem;
  final Color titleColor;
  final bool isMandatory;
  final String? initialTime;
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
  const AdaptiveTimePicker({
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
    this.enabled = true,
    this.prefix,
    this.suffix,
    this.initialTime,
  });

  // Widget State
  @override
  State<AdaptiveTimePicker> createState() => _AdaptiveTimePickerState();
}

class _AdaptiveTimePickerState extends State<AdaptiveTimePicker> {
  // State Properties
  String _hour = '';
  String _minute = '';
  String _second = '';

  // Widget Methods
  @override
  void initState() {
    super.initState();
    List<String> parts = (widget.initialTime ?? '00:00:00').split(':');
    if (parts.length == 3) {
      _hour = parts[0].toString().padLeft(2, '0');
      _minute = parts[1].toString().padLeft(2, '0');
      _second = parts[2].toString().padLeft(2, '0');
    } else if (parts.length == 2) {
      _hour = parts[0].toString().padLeft(2, '0');
      _minute = parts[1].toString().padLeft(2, '0');
      _second = '00';
    }
  }

  @override
  Widget build(BuildContext context) {
    String labelText = widget.isMandatory ? '${widget.titleText}*' : widget.titleText;
    final hours = List.generate(24, (index) => index)
        .map((hour) => PopOverMenuItem(
              code: hour.toString().padLeft(2, '0'),
              displayName: hour.toString().padLeft(2, '0'),
            ))
        .toList();
    final minutesAndSeconds = List.generate(60, (index) => index)
        .map((hour) => PopOverMenuItem(
              code: hour.toString().padLeft(2, '0'),
              displayName: hour.toString().padLeft(2, '0'),
            ))
        .toList();

    return Row(
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
                  SizedBox(
                    width: 50,
                    child: AdaptiveDropDownPickerFormField(
                      semanticsIdentifier: '${widget.semanticsIdentifier}_hour',
                      isMandatory: widget.isMandatory,
                      selectedItemKey: _hour,
                      enabled: widget.enabled,
                      showTitle: false,
                      fontSystem: widget.fontSystem,
                      items: hours,
                      showUnderline: widget.showUnderline,
                      underlineColor: widget.underlineColor,
                      onChanged: (selectedItem) {
                        setState(() {
                          _hour = selectedItem.code;
                          widget.onChanged('$_hour:$_minute:$_second');
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 50,
                    child: AdaptiveDropDownPickerFormField(
                      semanticsIdentifier: '${widget.semanticsIdentifier}_minute',
                      isMandatory: widget.isMandatory,
                      selectedItemKey: _minute,
                      enabled: widget.enabled,
                      showTitle: false,
                      fontSystem: widget.fontSystem,
                      items: minutesAndSeconds,
                      showUnderline: widget.showUnderline,
                      underlineColor: widget.underlineColor,
                      onChanged: (selectedItem) {
                        setState(() {
                          _minute = selectedItem.code;
                          widget.onChanged('$_hour:$_minute:$_second');
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 50,
                    child: AdaptiveDropDownPickerFormField(
                      semanticsIdentifier: '${widget.semanticsIdentifier}_second',
                      isMandatory: widget.isMandatory,
                      selectedItemKey: _second,
                      enabled: widget.enabled,
                      showTitle: false,
                      fontSystem: widget.fontSystem,
                      items: minutesAndSeconds,
                      showUnderline: widget.showUnderline,
                      underlineColor: widget.underlineColor,
                      onChanged: (selectedItem) {
                        setState(() {
                          _second = selectedItem.code;
                          widget.onChanged('$_hour:$_minute:$_second');
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (widget.suffix != null) const SizedBox(width: 8),
        if (widget.suffix != null) widget.suffix!,
      ],
    );
  }
}

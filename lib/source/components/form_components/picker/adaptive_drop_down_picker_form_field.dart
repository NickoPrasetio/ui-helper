//
//  adaptive_drop_down_picker_form_field.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 23/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

enum AdaptiveDropDownPickerFormFieldType { iconButton, titleWithoutBox }

class AdaptiveDropDownPickerFormField extends StatefulWidget {
  // Properties
  final void Function(PopOverMenuItem selectedItem) onChanged;
  final String? semanticsIdentifier;
  final bool showTitle;
  final String titleText;
  final UIFontSystem titleFontSystem;
  final Color titleColor;

  final AdaptiveDropDownPickerFormFieldType pickerType;
  final IconData? iconForButtonType;
  final Color borderColorForButtonType;
  final double borderWidthForButtonType;

  final String? selectedItemKey;
  final List<PopOverMenuItem> items;
  final bool isMandatory;
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
  const AdaptiveDropDownPickerFormField({
    super.key,
    required this.items,
    required this.onChanged,
    this.pickerType = AdaptiveDropDownPickerFormFieldType.titleWithoutBox,
    this.iconForButtonType = Icons.filter_list_outlined,
    this.borderColorForButtonType = ColorPalette.gray3,
    this.borderWidthForButtonType = 1.5,
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
    this.selectedItemKey,
    this.dropDownIcon = Icons.keyboard_arrow_down_sharp,
    this.showUnderline = true,
    this.underlineColor = ColorPalette.gray2,
    this.enabled = true,
    this.prefix,
    this.suffix,
  });

  // Widget State
  @override
  State<AdaptiveDropDownPickerFormField> createState() => _AdaptiveDropDownPickerFormFieldState();
}

class _AdaptiveDropDownPickerFormFieldState extends State<AdaptiveDropDownPickerFormField> {
  // State Properties
  PopOverMenuItem? _selectedItem;

  // Widget Methods
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String labelText = widget.isMandatory ? '${widget.titleText}*' : widget.titleText;
    if (widget.selectedItemKey != null && widget.selectedItemKey!.isNotEmpty) {
      _selectedItem =
          widget.items.where((item) => item.code == widget.selectedItemKey).toList().first;
    }
    Widget child = Container(
      decoration: HelperConstant.getBorderBoxDecoration(
        borderColor: widget.borderColorForButtonType,
        width: widget.borderWidthForButtonType,
      ),
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
      child: Icon(widget.iconForButtonType, color: widget.color, size: 24),
    );
    if (widget.pickerType == AdaptiveDropDownPickerFormFieldType.titleWithoutBox) {
      child = Row(
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
                      text: _selectedItem?.displayName ?? '',
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
      );
    }
    return AdaptiveDropDownButton(
      semanticsIdentifier: widget.semanticsIdentifier,
      enabled: widget.enabled,
      items: widget.items.map<PopupMenuEntry<PopOverMenuItem>>((PopOverMenuItem newValue) {
        return PopupMenuItem<PopOverMenuItem>(
          onTap: () {
            setState(() {
              _selectedItem = newValue;
              widget.onChanged(newValue);
            });
          },
          value: newValue,
          child: Row(
            children: [
              if (newValue.iconData != null) ...{
                Icon(newValue.iconData!, color: widget.color),
                const SizedBox(width: 8),
              },
              Expanded(
                child: AdaptiveText(
                  text: newValue.displayName,
                  color: widget.color,
                  textAlign: widget.textAlign,
                  fontSize: widget.fontSize,
                  fontSystem: widget.fontSystem,
                  desktopFactor: widget.desktopFactor,
                  tabletFactor: widget.tabletFactor,
                  mobileFactor: widget.mobileFactor,
                  smallMobileFactor: widget.smallMobileFactor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      child: child,
    );
  }
}

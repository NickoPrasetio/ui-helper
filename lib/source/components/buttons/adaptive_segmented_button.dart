//
//  adaptive_segmented_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 11/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class AdaptiveSegmentedButton extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;

  final List<String> items;
  final void Function(int, String)? onTap;
  final Color unselectedColor;
  final Color selectedColor;
  final Color borderColor;
  final Color pressedColor;
  final EdgeInsetsGeometry? padding;

  final int selectedIndex;

  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;

  final bool applyAdaptiveFont;
  final double? desktopFont;
  final double? tabletFont;
  final double? mobileFont;
  final double? smallMobileFont;

  final bool applyAdaptiveScaleFactor;
  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const AdaptiveSegmentedButton({
    super.key,
    this.semanticsIdentifier,
    required this.items,
    this.unselectedColor = ColorPalette.white,
    this.selectedColor = ColorPalette.blue,
    this.borderColor = ColorPalette.blue,
    this.pressedColor = ColorPalette.gray,
    this.padding,
    this.onTap,
    this.textAlign = TextAlign.center,
    this.fontSize = UIFont.h5,
    this.fontSystem = UIFontSystem.bold,
    this.applyAdaptiveFont = false,
    this.desktopFont = UIFont.h5,
    this.tabletFont = UIFont.h5,
    this.mobileFont = UIFont.h5,
    this.smallMobileFont = UIFont.h5,
    this.applyAdaptiveScaleFactor = true,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
    this.selectedIndex = 0,
  });

  @override
  State<AdaptiveSegmentedButton> createState() => _AdaptiveSegmentedButtonState();
}

class _AdaptiveSegmentedButtonState extends State<AdaptiveSegmentedButton> {
  // Properties
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? layoutFont;
    double scaleFactor = 1.0;
    var newFontSize = widget.fontSize;
    var fontWeight = UIFont.getFontWeightFrom(widget.fontSystem);

    if (Device.isLargeScreen(context)) {
      layoutFont = widget.desktopFont;
      scaleFactor = widget.desktopFactor;
    } else if (Device.isMediumScreen(context)) {
      layoutFont = widget.tabletFont;
      scaleFactor = widget.tabletFactor;
    } else if (Device.isSmallScreen(context)) {
      layoutFont = widget.mobileFont;
      scaleFactor = widget.mobileFactor;
    } else {
      layoutFont = widget.smallMobileFont;
      scaleFactor = widget.smallMobileFactor;
    }

    if (widget.applyAdaptiveScaleFactor && scaleFactor != 1) {
      newFontSize = widget.fontSize * scaleFactor;
    }

    if (widget.applyAdaptiveFont) {
      newFontSize = layoutFont ?? widget.fontSize;
    }

    final baseTextStyle = TextStyle(
      fontSize: newFontSize,
      fontWeight: fontWeight,
      height: 1.0,
    );

    if (!Device.isBrowser && Device.isIOS) {
      return _getCupertinoSegmentedButton(baseTextStyle);
    } else {
      return _getMaterialSegmentedButton(baseTextStyle);
    }
  }

  Widget _getCupertinoSegmentedButton(TextStyle baseTextStyle) {
    return CupertinoSegmentedControl<int>(
      unselectedColor: widget.unselectedColor,
      selectedColor: widget.selectedColor,
      borderColor: widget.borderColor,
      pressedColor: widget.pressedColor,
      padding: widget.padding,
      groupValue: _selectedIndex,
      onValueChanged: (index) {
        setState(() {
          _selectedIndex = index;
          widget.onTap?.call(index, widget.items[index]);
        });
      },
      children: Map.fromEntries(
        widget.items.asMap().entries.map(
              (entry) => MapEntry(
                entry.key,
                Padding(
                  padding: widget.padding ?? const EdgeInsets.only(left: 10, right: 10),
                  child: Semantics(
                    label: '${widget.semanticsIdentifier ?? ''}_${entry.key}',
                    excludeSemantics: true,
                    child: Text(entry.value, textAlign: widget.textAlign, style: baseTextStyle),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Widget _getMaterialSegmentedButton(TextStyle textStyle) {
    List<ButtonSegment<int>> buttonSegments = [];
    for (int index = 0; index < widget.items.length; index++) {
      buttonSegments.add(
        ButtonSegment<int>(
          value: index,
          label: Semantics(
            label: '${widget.semanticsIdentifier ?? ''}_$index',
            excludeSemantics: true,
            child: Text(widget.items[index], textAlign: widget.textAlign, style: textStyle),
          ),
        ),
      );
    }

    return SegmentedButton<int>(
      style: _getSegmentedButtonStyle(textStyle),
      segments: buttonSegments,
      selected: <int>{_selectedIndex},
      selectedIcon: const Icon(
        Icons.add_box_outlined,
        size: 0,
        color: Colors.transparent,
      ),
      onSelectionChanged: (Set<int> newSelection) {
        setState(() {
          _selectedIndex = newSelection.first;
          widget.onTap?.call(_selectedIndex, widget.items[_selectedIndex]);
        });
      },
    );
  }

  ButtonStyle _getSegmentedButtonStyle(TextStyle textStyle) {
    return ButtonStyle(
      padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
        (Set<WidgetState> states) {
          return widget.padding ?? EdgeInsets.zero;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return widget.selectedColor;
          } else {
            return widget.unselectedColor;
          }
        },
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return widget.pressedColor;
          }
          return null;
        },
      ),
      side: WidgetStateProperty.resolveWith<BorderSide?>(
        (Set<WidgetState> states) {
          return BorderSide(color: widget.borderColor, width: 1.0);
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return widget.unselectedColor;
          } else {
            return widget.selectedColor;
          }
        },
      ),
    );
  }
}

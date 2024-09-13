//
//  adaptive_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

enum AdaptiveButtonType { blackButton, blueButton, redButton, grayButton, whiteButton, clearButton }

class AdaptiveButton extends StatelessWidget {
  // Properties
  final String? semanticsIdentifier;
  final String titleText;
  final VoidCallback onTap;
  final AdaptiveButtonType buttonType;
  final EdgeInsets padding;
  final double prefixTitleSpace;
  final double suffixTitleSpace;
  final bool isDisabled;
  final bool addBorder;
  final double borderWidth;
  final Color borderColor;

  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;

  final bool addGradient;

  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;
  final Widget? prefix;
  final Widget? suffix;

  // Class Constructor
  const AdaptiveButton({
    super.key,
    required this.titleText,
    required this.onTap,
    this.buttonType = AdaptiveButtonType.blueButton,
    this.semanticsIdentifier,
    this.color = ColorPalette.textwhiteColor,
    this.textAlign = TextAlign.center,
    this.fontSize = UIFont.h5,
    this.fontSystem = UIFontSystem.bold,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
    this.padding = const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
    this.prefixTitleSpace = 8,
    this.suffixTitleSpace = 8,
    this.addGradient = false,
    this.isDisabled = false,
    this.addBorder = false,
    this.borderWidth = 1,
    this.borderColor = ColorPalette.frenchBlue,
    this.prefix,
    this.suffix,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    EdgeInsets textPadding = const EdgeInsets.all(0);
    if (prefix != null && suffix != null) {
      textPadding = EdgeInsets.only(left: prefixTitleSpace, right: suffixTitleSpace);
    } else if (prefix != null && suffix == null) {
      textPadding = EdgeInsets.only(left: prefixTitleSpace);
    } else if (prefix == null && suffix != null) {
      textPadding = EdgeInsets.only(right: suffixTitleSpace);
    }
    return AdaptiveTapGesture(
      semanticsIdentifier: semanticsIdentifier,
      onTap: onTap,
      isDisabled: isDisabled,
      child: Container(
        padding: padding,
        decoration: _getDecorationFor(buttonType),
        child: Row(
          children: [
            if (prefix != null) prefix!,
            Expanded(
              child: Padding(
                padding: textPadding,
                child: AdaptiveText(
                  text: titleText,
                  color: color,
                  textAlign: textAlign,
                  fontSize: fontSize,
                  fontSystem: fontSystem,
                  desktopFactor: desktopFactor,
                  tabletFactor: tabletFactor,
                  mobileFactor: mobileFactor,
                  smallMobileFactor: smallMobileFactor,
                ),
              ),
            ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }

  // Object Level Private Methods
  BoxDecoration _getDecorationFor(AdaptiveButtonType type) {
    List<Color> gradientColors;
    var color = ColorPalette.blue;
    var borderRadius = BorderRadius.circular(HelperConstant.borderRadius);
    switch (type) {
      case AdaptiveButtonType.blackButton:
        color = ColorPalette.black;
        gradientColors = [ColorPalette.gray, ColorPalette.black];
        break;
      case AdaptiveButtonType.blueButton:
        color = ColorPalette.blue;
        gradientColors = [ColorPalette.gray, ColorPalette.blue];
        break;
      case AdaptiveButtonType.redButton:
        color = ColorPalette.red;
        gradientColors = [ColorPalette.gray, ColorPalette.red];
        break;
      case AdaptiveButtonType.grayButton:
        color = ColorPalette.gray;
        gradientColors = [ColorPalette.gray, ColorPalette.gray3];
        break;
      case AdaptiveButtonType.whiteButton:
        color = ColorPalette.whiteBGColor;
        gradientColors = [ColorPalette.gray, ColorPalette.gray3];
        borderRadius = BorderRadius.circular(HelperConstant.borderRadius11);
        break;
      case AdaptiveButtonType.clearButton:
        color = ColorPalette.transparent;
        gradientColors = [ColorPalette.gray, ColorPalette.gray3];
        borderRadius = BorderRadius.circular(HelperConstant.borderRadius11);
        break;
    }

    if (addGradient) {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.circular(HelperConstant.borderRadius),
        border: addBorder ? Border.all(width: borderWidth, color: borderColor) : null,
      );
    }

    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      border: addBorder ? Border.all(width: borderWidth, color: borderColor) : null,
    );
  }
}

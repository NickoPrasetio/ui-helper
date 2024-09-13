//
//  adaptive_text.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  // Properties
  final String? semanticsIdentifier;
  final String text;
  final String serialNumberText;

  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;
  final int? maxLines;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;
  final TextDecorationStyle? decorationStyle;
  final double? lineSpacing;

  final List<TextSpan>? richTextSpans;

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
  final TextOverflow overflow;

  // Class Constructor
  const AdaptiveText({
    super.key,
    required this.text,
    this.serialNumberText = '',
    this.color = ColorPalette.textBlackColor,
    this.textAlign = TextAlign.left,
    this.fontSize = UIFont.h5,
    this.applyAdaptiveFont = false,
    this.desktopFont = UIFont.h5,
    this.tabletFont = UIFont.h5,
    this.mobileFont = UIFont.h5,
    this.smallMobileFont = UIFont.h5,
    this.fontSystem = UIFontSystem.regular,
    this.applyAdaptiveScaleFactor = true,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
    this.lineSpacing = 1.5,
    this.semanticsIdentifier,
    this.richTextSpans,
    this.maxLines,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
    this.decorationStyle,
    this.overflow = TextOverflow.clip,
  });

  const AdaptiveText.richText({
    super.key,
    required this.richTextSpans,
    this.text = '',
    this.serialNumberText = '',
    this.color = ColorPalette.textBlackColor,
    this.textAlign = TextAlign.left,
    this.fontSize = UIFont.h5,
    this.applyAdaptiveFont = false,
    this.desktopFont = UIFont.h5,
    this.tabletFont = UIFont.h5,
    this.mobileFont = UIFont.h5,
    this.smallMobileFont = UIFont.h5,
    this.fontSystem = UIFontSystem.regular,
    this.applyAdaptiveScaleFactor = true,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
    this.semanticsIdentifier,
    this.lineSpacing = 1.5,
    this.maxLines,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
    this.decorationStyle,
    this.overflow = TextOverflow.clip,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    double? layoutFont;
    double scaleFactor = 1.0;
    var newFontSize = fontSize;
    var fontWeight = UIFont.getFontWeightFrom(fontSystem);

    if (Device.isLargeScreen(context)) {
      layoutFont = desktopFont;
      scaleFactor = desktopFactor;
    } else if (Device.isMediumScreen(context)) {
      layoutFont = tabletFont;
      scaleFactor = tabletFactor;
    } else if (Device.isSmallScreen(context)) {
      layoutFont = mobileFont;
      scaleFactor = mobileFactor;
    } else {
      layoutFont = smallMobileFont;
      scaleFactor = smallMobileFactor;
    }

    if (applyAdaptiveScaleFactor && scaleFactor != 1) {
      newFontSize = fontSize * scaleFactor;
    }

    if (applyAdaptiveFont) {
      newFontSize = layoutFont ?? fontSize;
    }

    final baseTextStyle = TextStyle(
      fontSize: newFontSize,
      fontWeight: fontWeight,
      height: lineSpacing,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      decorationStyle: decorationStyle,
    );

    if (richTextSpans != null && richTextSpans!.isNotEmpty) {
      List<TextSpan> list = [];
      for (TextSpan textSpan in richTextSpans!) {
        list.add(
          TextSpan(
            text: textSpan.text,
            style: TextStyle(
              fontFamily: HelperConstant.fontFamily,
              fontStyle: textSpan.style?.fontStyle ?? FontStyle.normal,
              fontSize: textSpan.style?.fontSize ?? newFontSize,
              fontWeight: textSpan.style?.fontWeight ?? fontWeight,
              height: textSpan.style?.height ?? lineSpacing,
              color: textSpan.style?.color ?? color,
              decoration: textSpan.style?.decoration ?? decoration,
              decorationColor: textSpan.style?.decorationColor ?? decorationColor,
              decorationThickness: textSpan.style?.decorationThickness ?? decorationThickness,
              decorationStyle: textSpan.style?.decorationStyle ?? decorationStyle,
            ),
          ),
        );
      }
      return _buildText(
        widget: Semantics(
          label: semanticsIdentifier,
          excludeSemantics: true,
          child: RichText(
            maxLines: maxLines,
            textAlign: textAlign,
            text: TextSpan(style: baseTextStyle, children: list),
          ),
        ),
        style: baseTextStyle,
      );
    }

    return _buildText(
      widget: Semantics(
        label: semanticsIdentifier,
        excludeSemantics: true,
        child: Text(text,
            textAlign: textAlign, style: baseTextStyle, maxLines: maxLines, overflow: overflow),
      ),
      style: baseTextStyle,
    );
  }

  Widget _buildText({required Widget widget, required TextStyle style}) {
    if (serialNumberText.isEmpty) {
      return widget;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(serialNumberText, textAlign: TextAlign.left, style: style),
        const SizedBox(width: 4),
        Expanded(child: widget),
      ],
    );
  }
}

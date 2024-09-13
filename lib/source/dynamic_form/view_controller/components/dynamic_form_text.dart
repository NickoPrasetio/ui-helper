//
//  dynamic_form_text.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 14/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class DynamicFormText extends AdaptiveText {
  // Properties
  final bool shouldValidate;
  final String formkey;
  final bool isValid;
  final LabelProperties labelProperties;

  // Class Constructor
  const DynamicFormText({
    super.key,
    required this.shouldValidate,
    required this.formkey,
    this.isValid = true,
    required this.labelProperties,
    required super.text,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    Color textColor = UIColor.fromHex(labelProperties.color) ?? ColorPalette.textBlackColor;

    if (shouldValidate) {
      textColor = isValid ? textColor : ColorPalette.textRedColor;
    }

    return AdaptiveText(
      semanticsIdentifier: formkey,
      text: text,
      serialNumberText: labelProperties.serialNumber ?? '',
      color: textColor,
      textAlign: HelperConstant.getTextAlignFrom(labelProperties.alignment),
      fontSize: labelProperties.fontSize,
      fontSystem: labelProperties.fontSystem,
      applyAdaptiveFont: labelProperties.applyAdaptiveFont,
      desktopFont: labelProperties.desktopFont,
      tabletFont: labelProperties.tabletFont,
      mobileFont: labelProperties.mobileFont,
      smallMobileFont: labelProperties.smallMobileFont,
      applyAdaptiveScaleFactor: labelProperties.applyAdaptiveScaleFactor,
      desktopFactor: labelProperties.desktopFactor,
      tabletFactor: labelProperties.tabletFactor,
      mobileFactor: labelProperties.mobileFactor,
      smallMobileFactor: labelProperties.smallMobileFactor,
    );
  }
}

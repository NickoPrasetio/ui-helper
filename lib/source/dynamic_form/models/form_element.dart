//
//  form_element.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

// =============== Classes Supporting Form Elements =============== //

class EmptySpaceProperties {
  final double height;
  EmptySpaceProperties({required this.height});

  factory EmptySpaceProperties.fromJson(Map<String, dynamic> json) {
    return EmptySpaceProperties(height: json['height'].toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'height': height};
  }
}

class LabelProperties {
  final double fontSize;
  final UIFontSystem fontSystem;
  final UITextAlignment alignment;
  final String color;

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

  final bool showUnderline;
  final double underlineHeight;
  final double underlineTopSpacing;
  final bool isUnderlineWidthSameAsLabelWidth;

  final String? serialNumber;
  final List<String>? listOfWordToBeItalic;

  LabelProperties({
    this.fontSize = 16,
    this.fontSystem = UIFontSystem.regular,
    this.alignment = UITextAlignment.left,
    this.color = ColorPalette.blackHexCode,
    this.showUnderline = false,
    this.underlineHeight = 1,
    this.underlineTopSpacing = 0,
    this.isUnderlineWidthSameAsLabelWidth = false,
    this.serialNumber,
    this.listOfWordToBeItalic,
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
  });

  factory LabelProperties.fromJson(Map<String, dynamic> json) {
    return LabelProperties(
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16,
      fontSystem: EnumSerialization.fromJson(
        json['fontSystem'],
        UIFontSystem.values,
        defaultValue: UIFontSystem.regular,
      ),
      alignment: EnumSerialization.fromJson(
        json['alignment'],
        UITextAlignment.values,
        defaultValue: UITextAlignment.left,
      ),
      color: json['color'] as String? ?? ColorPalette.blackHexCode,
      showUnderline: json['showUnderline'] as bool? ?? false,
      underlineHeight: (json['underlineHeight'] as num?)?.toDouble() ?? 1,
      underlineTopSpacing: (json['underlineTopSpacing'] as num?)?.toDouble() ?? 0,
      isUnderlineWidthSameAsLabelWidth: json['isUnderlineWidthSameAsLabelWidth'] as bool? ?? false,
      serialNumber: json['serialNumber'] as String?,
      listOfWordToBeItalic: (json['listOfWordToBeItalic'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'textFontSize': fontSize,
      'textFontSystem': jsonEncode(fontSystem.toJson()),
      'textAlignment': jsonEncode(alignment.toJson()),
      'textColor': color,
      'showUnderline': showUnderline,
      'underlineHeight': underlineHeight,
      'underlineTopSpacing': underlineTopSpacing,
      'isUnderlineWidthSameAsLabelWidth': isUnderlineWidthSameAsLabelWidth,
      'serialNumber': serialNumber,
      'listOfWordToBeItalic': listOfWordToBeItalic,
    };
  }
}

class ButtonProperties {
  final AdaptiveButtonType buttonType;
  final double padding;
  final bool isDisabled;
  final String colorHex;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;
  final bool addGradient;
  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  ButtonProperties({
    this.buttonType = AdaptiveButtonType.blueButton,
    this.padding = 15,
    this.isDisabled = false,
    this.colorHex = ColorPalette.whiteHexCode,
    this.textAlign = TextAlign.center,
    this.fontSize = UIFont.h5,
    this.fontSystem = UIFontSystem.bold,
    this.addGradient = false,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
  });

  factory ButtonProperties.fromJson(Map<String, dynamic> json) {
    return ButtonProperties(
      padding: json['padding'].toDouble(),
      fontSize: json['fontSize'].toDouble(),
      addGradient: json['addGradient'],
      desktopFactor: json['desktopFactor'].toDouble(),
      tabletFactor: json['tabletFactor'].toDouble(),
      mobileFactor: json['mobileFactor'].toDouble(),
      smallMobileFactor: json['smallMobileFactor'].toDouble(),
      buttonType: json['buttonType'],
      isDisabled: json['isDisabled'],
      textAlign: json['textAlign'],
      colorHex: json['colorHex'],
      fontSystem: json['fontSystem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'padding': padding,
      'fontSize': fontSize,
      'addGradient': addGradient,
      'desktopFactor': desktopFactor,
      'tabletFactor': tabletFactor,
      'mobileFactor': mobileFactor,
      'smallMobileFactor': smallMobileFactor,
      'buttonType': buttonType,
      'isDisabled': isDisabled,
      'textFontSystem': jsonEncode(fontSystem.toJson()),
      'textAlign': jsonEncode(textAlign.toJson()),
      'colorHex': colorHex,
      'fontSystem': fontSystem,
    };
  }
}

class RadioButtonProperties {
  final LabelProperties titleLabel;
  final List<String> options;
  final String? initialValues;
  final int numberOfButtonsInRow;
  final double spaceBetweenButtons;
  final double buttonsLeftSpace;
  final double buttonsTopSpace;
  final RadioLayoutDirection layoutDirection;
  final String unselectedHexColor;
  final String selectedHexColor;

  RadioButtonProperties({
    required this.titleLabel,
    required this.options,
    this.initialValues = '',
    this.layoutDirection = RadioLayoutDirection.horizontal,
    this.spaceBetweenButtons = 16.0,
    this.numberOfButtonsInRow = 4,
    this.buttonsTopSpace = 2.0,
    this.buttonsLeftSpace = 16.0,
    this.unselectedHexColor = ColorPalette.gray2HexCode,
    this.selectedHexColor = ColorPalette.blueHexCode,
  });

  factory RadioButtonProperties.fromJson(Map<String, dynamic> json) {
    return RadioButtonProperties(
      titleLabel: LabelProperties.fromJson(json['titleLabel']),
      options: List<String>.from(json['options']),
      initialValues: json['initialValues'] as String?,
      numberOfButtonsInRow: json['numberOfButtonsInRow'],
      spaceBetweenButtons: json['spaceBetweenButtons'].toDouble(),
      buttonsTopSpace: json['buttonsTopSpace'].toDouble(),
      buttonsLeftSpace: json['buttonsLeftSpace'].toDouble(),
      layoutDirection: RadioLayoutDirection.values[json['layoutDirection']],
      unselectedHexColor: json['unselectedHexColor'],
      selectedHexColor: json['selectedHexColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleLabel': titleLabel.toJson(),
      'options': options,
      'initialValues': initialValues,
      'numberOfButtonsInRow': numberOfButtonsInRow,
      'spaceBetweenButtons': spaceBetweenButtons,
      'buttonsTopSpace': buttonsTopSpace,
      'layoutDirection': layoutDirection.index,
      'unselectedHexColor': unselectedHexColor,
      'selectedHexColor': selectedHexColor,
      'buttonsLeftSpace': buttonsLeftSpace,
    };
  }
}

class CheckboxProperties {
  final LabelProperties titleLabel;
  final List<String> options;
  final List<String>? initialValues;
  final int numberOfButtonsInRow;
  final double spaceBetweenButtons;
  final double buttonsTopSpace;
  final CheckboxLayoutDirection layoutDirection;
  final String unselectedHexColor;
  final String selectedHexColor;

  CheckboxProperties({
    required this.titleLabel,
    required this.options,
    required this.initialValues,
    required this.numberOfButtonsInRow,
    required this.spaceBetweenButtons,
    required this.buttonsTopSpace,
    required this.layoutDirection,
    this.unselectedHexColor = ColorPalette.gray2HexCode,
    this.selectedHexColor = ColorPalette.blueHexCode,
  });

  factory CheckboxProperties.fromJson(Map<String, dynamic> json) {
    return CheckboxProperties(
      titleLabel: LabelProperties.fromJson(json['titleLabel']),
      options: List<String>.from(json['options']),
      initialValues:
          json['initialValues'] != null ? List<String>.from(json['initialValues']) : null,
      numberOfButtonsInRow: json['numberOfButtonsInRow'],
      spaceBetweenButtons: json['spaceBetweenButtons'].toDouble(),
      buttonsTopSpace: json['buttonsTopSpace'].toDouble(),
      layoutDirection: CheckboxLayoutDirection.values[json['layoutDirection']],
      unselectedHexColor: json['unselectedHexColor'],
      selectedHexColor: json['selectedHexColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleLabel': titleLabel.toJson(),
      'options': options,
      'initialValues': initialValues,
      'numberOfButtonsInRow': numberOfButtonsInRow,
      'spaceBetweenButtons': spaceBetweenButtons,
      'buttonsTopSpace': buttonsTopSpace,
      'layoutDirection': layoutDirection.index,
      'unselectedHexColor': unselectedHexColor,
      'selectedHexColor': selectedHexColor,
    };
  }
}

class TitleValueProperties {
  final IconData? icon;
  final LabelProperties titleLabel;
  final LabelProperties valueLabel;
  final CrossAxisAlignment crossAxisAlignment;
  final TitleValueTextDirection layoutDirection;

  TitleValueProperties({
    required this.titleLabel,
    required this.valueLabel,
    this.icon,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.layoutDirection = TitleValueTextDirection.vertical,
  });

  factory TitleValueProperties.fromJson(Map<String, dynamic> json) {
    return TitleValueProperties(
      titleLabel: LabelProperties.fromJson(json['titleLabel']),
      valueLabel: LabelProperties.fromJson(json['valueLabel']),
      icon: null, //json['icon'] != '' ? IconData(json['icon'], fontFamily: 'MaterialIcons') : null,
      crossAxisAlignment: CrossAxisAlignment.values[json['crossAxisAlignment']],
      layoutDirection: TitleValueTextDirection.values[json['layoutDirection']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleLabel': titleLabel.toJson(),
      'valueLabel': valueLabel.toJson(),
      'icon': icon != null ? icon!.codePoint : '',
      'crossAxisAlignment': crossAxisAlignment.index,
      'layoutDirection': layoutDirection.index,
    };
  }
}

class TextFieldProperties {
  final String hintText;
  final bool isObscure;
  final List<Regex>? validations;
  final AdaptiveTextFormFieldType textFieldType;
  // final TextInputType keyboardType;
  final TextDirection textDirection;

  final bool isMandatory;
  final String mandatoryErrorMsg;
  final int errorMaxLines;

  final bool autofocus;
  final bool readOnly;
  final bool showCursor;
  final bool enableInteractiveSelection;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;

  final String titleHexColor;
  final double titleFontSize;
  final UIFontSystem titleFontSystem;

  final String valueHexColor;
  final TextAlign valueTextAlign;
  final double valueFontSize;
  final UIFontSystem valueFontSystem;

  final String errorHexColor;
  final double errorFontSize;
  final UIFontSystem errorFontSystem;

  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  TextFieldProperties({
    this.isMandatory = false,
    this.mandatoryErrorMsg = 'cannot be blank',
    this.errorMaxLines = 3,
    this.textFieldType = AdaptiveTextFormFieldType.titleWithoutBox,
    this.isObscure = false,
    this.hintText = '',
    this.validations,
    // this.keyboardType = TextInputType.text,
    this.textDirection = TextDirection.ltr,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor = true,
    this.enableInteractiveSelection = true,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforcement,
    this.titleHexColor = ColorPalette.blueHexCode,
    this.titleFontSize = UIFont.h5,
    this.titleFontSystem = UIFontSystem.bold,
    this.valueHexColor = ColorPalette.blackHexCode,
    this.valueTextAlign = TextAlign.left,
    this.valueFontSize = UIFont.h5,
    this.valueFontSystem = UIFontSystem.regular,
    this.errorHexColor = ColorPalette.redHexCode,
    this.errorFontSize = UIFont.h8,
    this.errorFontSystem = UIFontSystem.regular,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
  });

  factory TextFieldProperties.fromJson(Map<String, dynamic> json) {
    return TextFieldProperties(
      hintText: json['hintText'] ?? '',
      isObscure: json['isObscure'] ?? false,
      validations:
          (json['validations'] as List<dynamic>?)?.map((json) => Regex.fromJson(json)).toList(),
      textFieldType: AdaptiveTextFormFieldType.values[json['textFieldType']],
      textDirection: TextDirection.values[json['textDirection']],
      isMandatory: json['isMandatory'] ?? false,
      mandatoryErrorMsg: json['mandatoryErrorMsg'] ?? 'cannot be blank',
      errorMaxLines: json['errorMaxLines'] ?? 3,
      autofocus: json['autofocus'] ?? false,
      readOnly: json['readOnly'] ?? false,
      showCursor: json['showCursor'] ?? true,
      enableInteractiveSelection: json['enableInteractiveSelection'] ?? true,
      enabled: json['enabled'] ?? true,
      maxLines: json['maxLines'] ?? 1,
      maxLength: json['maxLength'],
      maxLengthEnforcement: MaxLengthEnforcement.values[json['maxLengthEnforcement']],
      titleHexColor: json['titleHexColor'] ?? ColorPalette.blueHexCode,
      titleFontSize: json['titleFontSize'] ?? UIFont.h5,
      titleFontSystem: UIFontSystem.values[json['titleFontSystem']],
      valueHexColor: json['valueHexColor'] ?? ColorPalette.blackHexCode,
      valueTextAlign: TextAlign.values[json['valueTextAlign']],
      valueFontSize: json['valueFontSize'] ?? UIFont.h5,
      valueFontSystem: UIFontSystem.values[json['valueFontSystem']],
      errorHexColor: json['errorHexColor'] ?? ColorPalette.redHexCode,
      errorFontSize: json['errorFontSize'] ?? UIFont.h8,
      errorFontSystem: UIFontSystem.values[json['errorFontSystem']],
      desktopFactor: json['desktopFactor'] ?? 1.0,
      tabletFactor: json['tabletFactor'] ?? 1.0,
      mobileFactor: json['mobileFactor'] ?? 1.0,
      smallMobileFactor: json['smallMobileFactor'] ?? 1.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hintText': hintText,
      'isObscure': isObscure,
      'validations': validations?.map((regex) => regex.toJson()).toList(),
      'textFieldType': textFieldType.index,
      'textDirection': textDirection.index,
      'isMandatory': isMandatory,
      'mandatoryErrorMsg': mandatoryErrorMsg,
      'errorMaxLines': errorMaxLines,
      'autofocus': autofocus,
      'readOnly': readOnly,
      'showCursor': showCursor,
      'enableInteractiveSelection': enableInteractiveSelection,
      'enabled': enabled,
      'maxLines': maxLines,
      'maxLength': maxLength,
      'maxLengthEnforcement': maxLengthEnforcement?.index,
      'titleHexColor': titleHexColor,
      'titleFontSize': titleFontSize,
      'titleFontSystem': titleFontSystem.index,
      'valueHexColor': valueHexColor,
      'valueTextAlign': valueTextAlign.index,
      'valueFontSize': valueFontSize,
      'valueFontSystem': valueFontSystem.index,
      'errorHexColor': errorHexColor,
      'errorFontSize': errorFontSize,
      'errorFontSystem': errorFontSystem.index,
      'desktopFactor': desktopFactor,
      'tabletFactor': tabletFactor,
      'mobileFactor': mobileFactor,
      'smallMobileFactor': smallMobileFactor,
    };
  }
}

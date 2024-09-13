//
//  adaptive_textfield.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AdaptiveTextFieldType { boxShowingHint, titleWithoutBox }

class AdaptiveTextField extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;
  final String titleText;
  final String hintText;
  final bool isObscure;
  final List<Regex>? validations;
  final TextEditingController controller;
  final AdaptiveTextFieldType textFieldType;
  final TextInputType keyboardType;
  final TextDirection textDirection;

  final Widget? prefix;

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

  final Color titleColor;
  final double titleFontSize;
  final UIFontSystem titleFontSystem;

  final Color valueColor;
  final TextAlign valueTextAlign;
  final double valueFontSize;
  final UIFontSystem valueFontSystem;

  final Color errorColor;
  final double errorFontSize;
  final UIFontSystem errorFontSystem;

  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const AdaptiveTextField({
    super.key,
    required this.controller,
    this.isMandatory = false,
    this.mandatoryErrorMsg = 'cannot be blank',
    this.errorMaxLines = 3,
    this.textFieldType = AdaptiveTextFieldType.titleWithoutBox,
    this.isObscure = false,
    this.titleText = '',
    this.hintText = '',
    this.validations,
    this.semanticsIdentifier,
    this.keyboardType = TextInputType.text,
    this.textDirection = TextDirection.ltr,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor = true,
    this.enableInteractiveSelection = true,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforcement,
    this.titleColor = ColorPalette.blue,
    this.titleFontSize = UIFont.h5,
    this.titleFontSystem = UIFontSystem.bold,
    this.valueColor = ColorPalette.black,
    this.valueTextAlign = TextAlign.left,
    this.valueFontSize = UIFont.h5,
    this.valueFontSystem = UIFontSystem.regular,
    this.errorColor = ColorPalette.textRedColor,
    this.errorFontSize = UIFont.h8,
    this.errorFontSystem = UIFontSystem.regular,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
    this.prefix,
  });

  // Widget State
  @override
  State<AdaptiveTextField> createState() => _AdaptiveTextFieldState();
}

class _AdaptiveTextFieldState extends State<AdaptiveTextField> {
  Regex? firstFailedRegex;
  bool showPassword = false;

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var scaleFactor = Device.getScaleFactor(context, widget.desktopFactor, widget.tabletFactor,
        widget.mobileFactor, widget.smallMobileFactor);

    return Semantics(
      label: widget.semanticsIdentifier,
      textField: true,
      child: TextField(
        onChanged: (text) {
          _validate(text);
        },
        controller: widget.controller,
        obscureText: widget.isObscure && !showPassword,
        decoration: _getDecoration(screenWidth),
        keyboardType: widget.keyboardType,
        textDirection: widget.textDirection,
        textAlign: widget.valueTextAlign,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        showCursor: widget.showCursor,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        style: TextStyle(
          fontSize: widget.valueFontSize * scaleFactor,
          fontWeight: UIFont.getFontWeightFrom(widget.valueFontSystem),
          color: widget.valueColor,
        ),
      ),
    );
  }

  // Object Level Private Methods

  /// Decoration Settings
  InputDecoration _getDecoration(double screenWidth) {
    if (widget.textFieldType == AdaptiveTextFieldType.boxShowingHint) {
      return _getBoxDecoration();
    }

    return _getTitleDecoration();
  }

  InputDecoration _getBoxDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 10, right: 10),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.gray3, width: 1.5),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.gray3, width: 1.5),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.gray3, width: 1.5),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.red),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.red),
      ),
      fillColor: ColorPalette.bgColor,
      filled: true,
      hintText: widget.hintText,
      hintStyle: TextStyle(color: Colors.grey[500]),
      errorText: firstFailedRegex?.errorMessage,
      errorMaxLines: widget.errorMaxLines,
      prefixIcon: widget.prefix,
      suffixIcon: widget.isObscure ? _getObscureSuffixIcon() : null,
      counterStyle: const TextStyle(height: double.minPositive),
      counterText: '',
    );
  }

  /// Inspire Default Title Value Decoration
  InputDecoration _getTitleDecoration() {
    var scaleFactor = Device.getScaleFactor(context, widget.desktopFactor, widget.tabletFactor,
        widget.mobileFactor, widget.smallMobileFactor);

    return InputDecoration(
      labelText: widget.isMandatory ? '${widget.titleText}*' : widget.titleText,
      labelStyle: TextStyle(
        fontSize: widget.titleFontSize * scaleFactor,
        fontWeight: UIFont.getFontWeightFrom(widget.titleFontSystem),
        color: widget.titleColor,
      ),
      errorText: firstFailedRegex?.errorMessage,
      errorMaxLines: widget.errorMaxLines,
      errorStyle: TextStyle(
        fontSize: widget.errorFontSize * scaleFactor,
        fontWeight: UIFont.getFontWeightFrom(widget.errorFontSystem),
        color: widget.errorColor,
      ),
      suffixIcon: widget.isObscure ? _getObscureSuffixIcon() : null,
      counterStyle: const TextStyle(height: double.minPositive),
      counterText: '',
    );
  }

  /// Trailing Icons
  IconButton _getObscureSuffixIcon() {
    double iconSize = Device.isMediumScreenAndAbove(context) ? 24.0 : 18.0;
    return IconButton(
      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off, size: iconSize),
      onPressed: () {
        setState(() {
          showPassword = !showPassword;
        });
      },
    );
  }

  /// Validate
  void _validate(String text) {
    Regex? failedRegex;

    if (widget.isMandatory && text.isEmpty) {
      failedRegex = Regex(
        expression: '',
        errorMessage: '${widget.titleText} ${widget.mandatoryErrorMsg}',
      );
    } else {
      for (Regex regex in widget.validations ?? []) {
        var result = regex.validate(text);
        if (!result) {
          failedRegex = regex;
          break;
        }
      }
    }
    setState(() {
      firstFailedRegex = failedRegex;
    });
  }
}

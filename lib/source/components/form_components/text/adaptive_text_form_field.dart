//
//  adaptive_text_form_field.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

enum AdaptiveTextFormFieldType {
  boxShowingHint,
  titleWithoutBox,
  titleWithoutBoxAndAsterisk,
  denseBoxShowingHint
}

class AdaptiveTextFormField extends StatefulWidget {
  // Properties
  final String? semanticsIdentifier;
  final String titleText;
  final String hintText;
  final Color? hintColor;
  final bool isObscure;
  final List<Regex>? validations;
  final TextEditingController controller;
  final AdaptiveTextFormFieldType textFieldType;
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

  final double boxBorderWidth;
  final Color boxFillColor;
  final Color boxBorderColor;
  final double boxBorderCornerRadius;

  final EdgeInsets contentPadding;
  final Widget? suffixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;

  final Function(String?)? composeCustomErrorMsg;
  final List<TextInputFormatter>? textInputFormatters;
  final bool isValid;
  final Function(String)? onChanged;

  // Class Constructor
  const AdaptiveTextFormField({
    super.key,
    required this.controller,
    this.isMandatory = false,
    this.mandatoryErrorMsg = 'cannot be blank',
    this.errorMaxLines = 3,
    this.textFieldType = AdaptiveTextFormFieldType.titleWithoutBox,
    this.isObscure = false,
    this.titleText = '',
    this.hintText = '',
    this.hintColor = ColorPalette.lemonGrass,
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
    this.boxFillColor = ColorPalette.bgColor,
    this.contentPadding = const EdgeInsets.only(left: 10, right: 10),
    this.suffixIcon,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.composeCustomErrorMsg,
    this.textInputFormatters,
    this.isValid = true,
    this.onChanged,
    this.boxBorderWidth = 1.5,
    this.boxBorderColor = ColorPalette.gray3,
    this.boxBorderCornerRadius = 4,
  });

  // Widget State
  @override
  State<AdaptiveTextFormField> createState() => _AdaptiveTextFormFieldState();
}

class _AdaptiveTextFormFieldState extends State<AdaptiveTextFormField> {
  // State Properties
  bool showPassword = false;
  String? errorMessage;

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var scaleFactor = Device.getScaleFactor(context, widget.desktopFactor, widget.tabletFactor,
        widget.mobileFactor, widget.smallMobileFactor);
    final textField = Semantics(
      label: widget.semanticsIdentifier,
      textField: true,
      child: TextFormField(
        onChanged: (text) {
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
          setState(() {
            errorMessage = checkTextFieldValidity(text);
          });
        },
        validator: (text) {
          errorMessage = checkTextFieldValidity(text);
          return errorMessage;
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
        inputFormatters: widget.textInputFormatters,
      ),
    );
    if (widget.textFieldType == AdaptiveTextFormFieldType.titleWithoutBox) {
      return Row(
        children: [
          if (widget.prefix != null) ...[widget.prefix!, const SizedBox(width: 8)],
          Expanded(child: textField),
        ],
      );
    }
    return textField;
  }

  String? checkTextFieldValidity(String? text) {
    String? errorMessage = _validate(text)?.errorMessage;
    if (null != widget.composeCustomErrorMsg && null == errorMessage) {
      return widget.composeCustomErrorMsg!(text);
    }
    return errorMessage;
  }

  // Object Level Private Methods
  InputDecoration _getDecoration(double screenWidth) {
    if (widget.textFieldType == AdaptiveTextFormFieldType.boxShowingHint ||
        widget.textFieldType == AdaptiveTextFormFieldType.denseBoxShowingHint) {
      return _getBoxDecoration();
    }
    return _getTitleDecoration();
  }

  InputDecoration _getBoxDecoration() {
    Color borderColor = ColorPalette.gray3;
    Color errorBorderColor = ColorPalette.red;
    bool isDense = false;

    if (widget.textFieldType == AdaptiveTextFormFieldType.denseBoxShowingHint) {
      borderColor = ColorPalette.transparent;
      isDense = true;
    }

    return InputDecoration(
      contentPadding: widget.contentPadding,
      isDense: isDense,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.boxBorderCornerRadius),
        borderSide: BorderSide(color: widget.boxBorderColor, width: widget.boxBorderWidth),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.boxBorderCornerRadius),
        borderSide: BorderSide(color: widget.boxBorderColor, width: widget.boxBorderWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.boxBorderCornerRadius),
        borderSide: BorderSide(color: widget.boxBorderColor, width: widget.boxBorderWidth),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.boxBorderCornerRadius),
        borderSide: const BorderSide(color: ColorPalette.red),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.boxBorderCornerRadius),
        borderSide: const BorderSide(color: ColorPalette.red),
      ),
      fillColor: widget.boxFillColor,
      filled: true,
      hintText: widget.hintText,
      hintStyle: TextStyle(color: widget.hintColor),
      errorText: errorMessage,
      errorMaxLines: widget.errorMaxLines,
      prefixIcon: widget.prefix,
      suffixIcon: widget.isObscure ? _getObscureSuffixIcon() : widget.suffixIcon,
      counterStyle: const TextStyle(height: double.minPositive),
      counterText: '',
    );
  }

  /// Inspire Default Title Value Decoration
  InputDecoration _getTitleDecoration() {
    var scaleFactor = Device.getScaleFactor(context, widget.desktopFactor, widget.tabletFactor,
        widget.mobileFactor, widget.smallMobileFactor);
    String labelText = widget.isMandatory ? '${widget.titleText}*' : widget.titleText;
    String? helperText;
    Widget? prefix;
    if (widget.textFieldType == AdaptiveTextFormFieldType.titleWithoutBoxAndAsterisk) {
      prefix = widget.prefix;
      labelText = widget.titleText;
      helperText = '';
      if (!widget.isValid) {
        errorMessage = checkTextFieldValidity(widget.controller.text);
      }
    }
    return InputDecoration(
      floatingLabelBehavior: widget.floatingLabelBehavior,
      hintText: widget.hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: widget.titleFontSize * scaleFactor,
        fontWeight: UIFont.getFontWeightFrom(widget.titleFontSystem),
        color: widget.titleColor,
      ),
      errorText: errorMessage,
      errorMaxLines: widget.errorMaxLines,
      errorStyle: TextStyle(
        fontSize: widget.errorFontSize * scaleFactor,
        fontWeight: UIFont.getFontWeightFrom(widget.errorFontSystem),
        color: widget.errorColor,
      ),
      suffixIcon: widget.isObscure ? _getObscureSuffixIcon() : widget.suffixIcon,
      counterStyle: const TextStyle(height: double.minPositive),
      counterText: '',
      contentPadding: EdgeInsets.zero,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: widget.errorColor),
      ),
      prefix: prefix,
      helperText: helperText,
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
  Regex? _validate(String? textValue) {
    Regex? failedRegex;
    final text = textValue ?? '';

    if (widget.isMandatory && text.isEmpty) {
      String prefixText =
          (widget.textFieldType != AdaptiveTextFormFieldType.titleWithoutBoxAndAsterisk &&
                  widget.textFieldType != AdaptiveTextFormFieldType.denseBoxShowingHint)
              ? '${widget.titleText} '
              : '';
      failedRegex = Regex(
        expression: '',
        errorMessage: '$prefixText${widget.mandatoryErrorMsg}',
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

    return failedRegex;
  }
}

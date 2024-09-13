//
//  form_text_field.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 06/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class DynamicFormTextField extends StatefulWidget {
  // Properties
  final FormObject formObject;
  final bool shouldValidate;

  // Class Constructor
  const DynamicFormTextField({
    super.key,
    required this.formObject,
    required this.shouldValidate,
  });

  // Widget State
  @override
  State<DynamicFormTextField> createState() => _AdaptiveFormTextFieldState();
}

class _AdaptiveFormTextFieldState extends State<DynamicFormTextField> {
  // State Properties
  final _txtController = TextEditingController();

  // Widget Methods
  @override
  void initState() {
    super.initState();
    _txtController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _txtController.removeListener(_onTextChanged);
    _txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        widget.formObject.isMandatory ? '${widget.formObject.title}*' : widget.formObject.title;
    final textFieldProperties = widget.formObject.formProperties.textFieldProperties;
    Color textColor =
        hexStringToColor(textFieldProperties?.titleHexColor ?? ColorPalette.blackHexCode);
    if (widget.shouldValidate) {
      textColor = widget.formObject.isValid().value ? textColor : ColorPalette.textRedColor;
    }

    if (textFieldProperties != null) {
      return AdaptiveTextFormField(
        controller: _txtController,
        titleText: title,
        semanticsIdentifier: widget.formObject.key,
        isMandatory: textFieldProperties.isMandatory,
        mandatoryErrorMsg: textFieldProperties.mandatoryErrorMsg,
        errorMaxLines: textFieldProperties.errorMaxLines,
        textFieldType: textFieldProperties.textFieldType,
        isObscure: textFieldProperties.isObscure,
        hintText: textFieldProperties.hintText,
        validations: textFieldProperties.validations,
        textDirection: textFieldProperties.textDirection,
        autofocus: textFieldProperties.autofocus,
        readOnly: textFieldProperties.readOnly,
        showCursor: textFieldProperties.showCursor,
        enableInteractiveSelection: textFieldProperties.enableInteractiveSelection,
        enabled: textFieldProperties.enabled,
        maxLines: textFieldProperties.maxLines,
        maxLength: textFieldProperties.maxLength,
        maxLengthEnforcement: textFieldProperties.maxLengthEnforcement,
        titleColor: textColor,
        titleFontSize: textFieldProperties.titleFontSize,
        titleFontSystem: textFieldProperties.titleFontSystem,
        valueColor: hexStringToColor(textFieldProperties.valueHexColor),
        valueTextAlign: textFieldProperties.valueTextAlign,
        valueFontSize: textFieldProperties.valueFontSize,
        valueFontSystem: textFieldProperties.valueFontSystem,
        errorColor: hexStringToColor(textFieldProperties.errorHexColor),
        errorFontSize: textFieldProperties.errorFontSize,
        errorFontSystem: textFieldProperties.errorFontSystem,
        desktopFactor: textFieldProperties.desktopFactor,
        tabletFactor: textFieldProperties.tabletFactor,
        mobileFactor: textFieldProperties.mobileFactor,
        smallMobileFactor: textFieldProperties.smallMobileFactor,
      );
    }

    return const EmptyWidget();
  }

  // Object Level Private Methods
  void _onTextChanged() {
    String text = _txtController.text;
    setState(() {
      widget.formObject.value = text;
    });
  }
}

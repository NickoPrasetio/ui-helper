//
//  form_object_properties.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:convert';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class FormProperties {
  // Properties

  FormType formType;
  EmptySpaceProperties? emptySpaceProperties;
  LabelProperties? labelProperties;
  ButtonProperties? buttonProperties;
  RadioButtonProperties? radioButtonProperties;
  CheckboxProperties? checkboxProperties;
  TitleValueProperties? titleValueProperties;
  TextFieldProperties? textFieldProperties;

  // KeyboardType keyboardType;
  // FormBorderType borderType;

  // Class Constructor
  FormProperties({
    required this.formType,
    this.emptySpaceProperties,
    this.labelProperties,
    this.buttonProperties,
    this.radioButtonProperties,
    this.checkboxProperties,
    this.titleValueProperties,
    this.textFieldProperties,
    // this.keyboardType = KeyboardType.defaultType,
    // this.borderType = FormBorderType.noBorder,
  });

  FormProperties.emptySpace({required EmptySpaceProperties? properties})
      : formType = FormType.emptySpace,
        emptySpaceProperties = properties;

  FormProperties.label({required LabelProperties? properties})
      : formType = FormType.label,
        labelProperties = properties;

  FormProperties.button({required ButtonProperties? properties})
      : formType = FormType.button,
        buttonProperties = properties;

  FormProperties.radioButton({required RadioButtonProperties? properties})
      : formType = FormType.labelWithRadioButton,
        radioButtonProperties = properties;

  FormProperties.checkBoxButton({required CheckboxProperties? properties})
      : formType = FormType.labelWithCheckBoxButton,
        checkboxProperties = properties;

  FormProperties.titleValue({required TitleValueProperties? properties})
      : formType = FormType.labelTitleValuePair,
        titleValueProperties = properties;

  FormProperties.textField({required TextFieldProperties? properties})
      : formType = FormType.labelWithTextField,
        textFieldProperties = properties;

  // =============== JSON Serialization =============== //
  // Deserialize JSON to FormProperties
  factory FormProperties.fromJson(Map<String, dynamic> json) {
    return FormProperties(
      formType: EnumSerialization.fromJson(
        json['formType'],
        FormType.values,
        defaultValue: FormType.label,
      ),
      emptySpaceProperties: EmptySpaceProperties.fromJson(json['emptySpaceProperties']),
      labelProperties: LabelProperties.fromJson(json['labelProperties']),
      buttonProperties: ButtonProperties.fromJson(json['buttonProperties']),
      radioButtonProperties: RadioButtonProperties.fromJson(json['radioButtonProperties']),
      checkboxProperties: CheckboxProperties.fromJson(json['checkboxProperties']),
      titleValueProperties: TitleValueProperties.fromJson(json['titleValueProperties']),
      textFieldProperties: TextFieldProperties.fromJson(json['textFieldProperties']),
      // keyboardType: EnumSerialization.fromJson(
      //   json['keyboardType'],
      //   KeyboardType.values,
      //   defaultValue: KeyboardType.defaultType,
      // ),
      // borderType: EnumSerialization.fromJson(
      //   json['borderType'],
      //   FormBorderType.values,
      //   defaultValue: FormBorderType.noBorder,
      // ),
    );
  }

  // Serialize FormProperties To JSON
  Map<String, dynamic> toJson() {
    return {
      'formType': jsonEncode(formType.toJson()),
      'emptySpaceProperties': jsonEncode(emptySpaceProperties?.toJson()),
      'labelProperties': jsonEncode(labelProperties?.toJson()),
      'buttonProperties': jsonEncode(buttonProperties?.toJson()),
      'radioButtonProperties': jsonEncode(radioButtonProperties?.toJson()),
      'checkboxProperties': jsonEncode(checkboxProperties?.toJson()),
      'titleValueProperties': jsonEncode(titleValueProperties?.toJson()),
      'textFieldProperties': jsonEncode(textFieldProperties?.toJson()),
      // 'keyboardType': jsonEncode(keyboardType.toJson()),
      // 'borderType': jsonEncode(borderType.toJson()),
    };
  }
}

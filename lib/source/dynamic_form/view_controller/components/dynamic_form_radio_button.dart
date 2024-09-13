//
//  dynamic_form_radio_button.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 14/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class DynamicFormRadioButton extends StatelessWidget {
  // Properties
  final bool shouldValidate;
  final FormObject formObject;
  final ValueChanged<String>? onChanged;

  // Class Constructor
  const DynamicFormRadioButton({
    super.key,
    required this.shouldValidate,
    required this.formObject,
    required this.onChanged,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    final radioButtonProperties = formObject.formProperties.radioButtonProperties;

    if (radioButtonProperties != null) {
      return AdaptiveRadioButtonFormField(
        titleLabel: DynamicFormText(
            shouldValidate: shouldValidate,
            formkey: formObject.key,
            text: formObject.isMandatory ? '${formObject.title}*' : formObject.title,
            isValid: formObject.isValid().value,
            labelProperties: radioButtonProperties.titleLabel),
        options: radioButtonProperties.options,
        initialValue: radioButtonProperties.initialValues,
        layoutDirection: radioButtonProperties.layoutDirection,
        spaceBetweenButtons: radioButtonProperties.spaceBetweenButtons,
        buttonsLeftSpace: radioButtonProperties.buttonsLeftSpace,
        numberOfButtonsInRow: radioButtonProperties.numberOfButtonsInRow,
        buttonsTopSpace: radioButtonProperties.buttonsTopSpace,
        unselectedColor: hexStringToColor(radioButtonProperties.unselectedHexColor),
        selectedColor: hexStringToColor(radioButtonProperties.selectedHexColor),
        onChanged: onChanged,
      );
    }

    return const EmptyWidget();
  }
}

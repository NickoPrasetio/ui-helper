//
//  dynamic_form_check_box_button.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 14/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class DynamicFormCheckBoxButton extends StatelessWidget {
  // Properties
  final bool shouldValidate;
  final FormObject formObject;
  final ValueChanged<List<String>>? onChanged;

  // Class Constructor
  const DynamicFormCheckBoxButton({
    super.key,
    required this.shouldValidate,
    required this.formObject,
    required this.onChanged,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    // List<String> myList = formObject.value.split(', ');
    final checkboxProperties = formObject.formProperties.checkboxProperties;
    if (checkboxProperties != null) {
      return AdaptiveCheckboxFormField(
        titleLabel: DynamicFormText(
            shouldValidate: shouldValidate,
            formkey: formObject.key,
            text: formObject.isMandatory ? '${formObject.title}*' : formObject.title,
            isValid: formObject.isValid().value,
            labelProperties: checkboxProperties.titleLabel),
        options: checkboxProperties.options,
        initialValues: checkboxProperties.initialValues,
        layoutDirection: checkboxProperties.layoutDirection,
        spaceBetweenButtons: checkboxProperties.spaceBetweenButtons,
        numberOfButtonsInRow: checkboxProperties.numberOfButtonsInRow,
        buttonsTopSpace: checkboxProperties.buttonsTopSpace,
        unselectedColor: hexStringToColor(checkboxProperties.unselectedHexColor),
        selectedColor: hexStringToColor(checkboxProperties.selectedHexColor),
        onChanged: onChanged,
      );
    }

    return const EmptyWidget();
  }
}

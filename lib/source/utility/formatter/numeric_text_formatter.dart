/*
  numeric_text_formatter.dart
  
  Created by GABRIELSORE on 18/06/24.
  Copyright © 2024 Allianz. All rights reserved.
*/

import 'package:flutter/services.dart';

class NumericTextFormatter extends TextInputFormatter {
  final String thousandSeparator;

  const NumericTextFormatter({this.thousandSeparator = ','});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      var value = newValue.text;
      if (newValue.text.length > 2) {
        value = value.replaceAll(RegExp(r'\D'), '');
        value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), thousandSeparator);
      }
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
